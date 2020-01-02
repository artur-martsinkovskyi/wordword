# frozen_string_literal: true

require_relative '../command'
require 'tty/reader'
require 'pry'

module Wordword
  module Commands
    class Train < Wordword::Command
      def initialize(file, options)
        @file = file
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        words = {}
        wrong_answers = []
        File.readlines(@file).each do |line|
          word, translated_word = line.split('#').map(&:strip)
          words[word] = translated_word
        end

        words.to_a.shuffle.to_h.first(@options[:number] || words.size).each do |word, translated_word|
          choices = [translated_word]

          until choices.size == 4
            sample = words.values.sample
            choices << sample unless choices.include?(sample)
          end

          answer = prompt.select(
            "What is the translation of '#{word}'?",
            choices.shuffle
          )

          next unless answer != translated_word

          prompt.error('Wrong!')
          wrong_answers << {
            word: word,
            answer: answer,
            correct_answer: translated_word
          }
        end
      rescue TTY::Reader::InputInterrupt
        prompt.error("\n")
        prompt.error(
          Pastel.new.red(
            'You finished the training abruptly.'
          )
        )
      ensure
        if wrong_answers.any?
          prompt.error('Here are the words you got wrong:')
          wrong_answers.each do |word:, answer:, correct_answer:|
            prompt.say(
              "'#{word}' is '#{correct_answer}'. Your answer was '#{answer}.'"
            )
          end
        else
          prompt.ok(
            "You've got every word right. You're awesome, [FRIENDLY PRONOUN OF CHOICE]."
          )
        end
      end
    end
  end
end
