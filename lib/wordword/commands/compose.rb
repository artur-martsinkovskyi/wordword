# frozen_string_literal: true

require_relative "../command"
require_relative "../interactors/compose/handle_exit"

module Wordword
  module Commands
    class Compose < Wordword::Command

      QUIT_CODE = '\\q'

      def initialize(options)
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        words = {}
        loop do
          word = prompt.ask(
            "What is the word/phrase?(write #{QUIT_CODE} to exit)",
          ) do |w|
            w.required true
          end
          break if word == QUIT_CODE

          translation = prompt.ask(
            "What is the translation?(write #{QUIT_CODE} to exit)",
          ) do |t|
            t.required true
          end
          break if translation == QUIT_CODE

          words[word] = translation
        end
      rescue TTY::Reader::InputInterrupt
        prompt.error("\nYou interrupted the command, exiting...")
      ensure
        ::Compose::HandleExit.new(self).call(words)
      end

    end
  end
end
