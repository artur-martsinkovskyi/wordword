# frozen_string_literal: true

require_relative '../command'
require_relative '../operations/read_word_table'
require_relative '../interactors/train/word_loop'
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
        words = ReadWordTable.new.call(filename: @file).value!

        word_loop.run(
          words,
          loop_depth: @options[:number]
        )
      rescue TTY::Reader::InputInterrupt
        prompt.error(
          Pastel.new.red(
            "\nYou finished the training abruptly."
          )
        )
      ensure
        if word_loop.wrong_answers.any?
          prompt.error('Here are the words/phrases you got wrong:')
          word_loop.wrong_answers.each do |word:, answer:, correct_answer:|
            prompt.say(
              "'#{word}' is '#{correct_answer}'. Your answer was '#{answer}.'"
            )
          end
        elsif words.any?
          prompt.ok(
            "You've got every word/phrase right. You're awesome, [FRIENDLY PRONOUN OF CHOICE]."
          )
        end
      end

      private

      def word_loop
        @word_loop ||= ::Train::WordLoop.new(self)
      end
    end
  end
end
