# frozen_string_literal: true

require_relative "./single_choice"

module Train
  class WordLoop

    attr_reader :wrong_answers

    def initialize(command_context)
      @command_context = command_context
      @wrong_answers = []
    end

    def run(words, loop_depth:)
      selected_words = selected_words(words, loop_depth)

      selected_words.each do |word, translated_word|
        answer = single_choice.call(word, translated_word, words: selected_words)
        if answer.failure?
          command_context.prompt.error(I18n.t("train.wrong_alert"))
          @wrong_answers << answer.failure
        end
      end
    end

    private

    attr_reader :command_context

    def selected_words(words, loop_depth)
      words.to_a.sample(loop_depth || words.size).to_h
    end

    def single_choice
      SingleChoice.new(
        @command_context,
      )
    end

  end
end
