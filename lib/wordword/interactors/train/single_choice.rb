# frozen_string_literal: true

require 'dry/monads'

module Train
  class SingleChoice
    include Dry::Monads[:result]
    CHOICES_SIZE = 4

    def initialize(command_context)
      @command_context = command_context
    end

    def call(word, translated_word, words:)
      answer = command_context.prompt.select(
        "What is the translation of '#{word}'?",
        choices(translated_word, words)
      )

      if answer == translated_word
        Success(answer)
      else
        command_context.prompt.error('Wrong!')
        Failure(word: word, answer: answer, correct_answer: translated_word)
      end
    end

    private

    attr_reader :command_context

    def choices(translated_word, words)
      result = [translated_word]

      until result.size == CHOICES_SIZE
        sample = words.values.sample
        result << sample unless result.include?(sample)
      end

      result.shuffle
    end
  end
end
