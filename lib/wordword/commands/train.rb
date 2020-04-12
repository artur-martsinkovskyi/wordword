# frozen_string_literal: true

require_relative "../command"
require_relative "../operations/read_word_table"
require_relative "../interactors/train/word_loop"
require "tty/reader"

module Wordword
  module Commands
    class Train < Wordword::Command

      def initialize(file, options)
        @file = file
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        read_result = ReadWordTable.new.call(filename: @file)
        if read_result.success?
          words = read_result.success
        else
          output.puts(
            pastel.red(
              I18n.t("errors.#{read_result.failure}"),
            ),
          )
          return
        end

        word_loop.run(
          words,
          loop_depth: @options[:number],
        )
      rescue TTY::Reader::InputInterrupt
        prompt.error(
          pastel.red(
            I18n.t("train.interrupted"),
          ),
        )
      ensure
        if words && word_loop
          if word_loop.wrong_answers.any?
            prompt.error(I18n.t("train.wrong_answers_intro"))
            word_loop.wrong_answers.each do |wrong_answer_message|
              prompt.say(wrong_answer_message)
            end
          elsif words.any?
            prompt.ok(
              I18n.t("train.everything_correct"),
            )
          end
        end
      end

      private

      def word_loop
        @word_loop ||= ::Train::WordLoop.new(self)
      end

      def pastel
        @pastel ||= Pastel.new
      end

    end
  end
end
