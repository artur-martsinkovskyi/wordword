# frozen_string_literal: true

require_relative '../command'
require_relative '../interactors/compose/handle_exit'

module Wordword
  module Commands
    class Compose < Wordword::Command
      def initialize(options)
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        words = {}
        loop do
          word = prompt.ask(
            'What is the word/phrase?(write \\q to exit)'
          ) do |w|
            w.required true
          end
          break if word == '\\q'

          translation = prompt.ask(
            'What is the translation?(write \\q to exit)'
          ) do |t|
            t.required true
          end
          break if translation == '\\q'

          words[word] = translation
        end
      rescue TTY::Reader::InputInterrupt
        print_interrupt_message
      ensure
        ::Compose::HandleExit.new(self).call(words)
      end

      private

      def print_interrupt_message
        prompt.error("\nYou interrupted the command, exiting...")
      end
    end
  end
end
