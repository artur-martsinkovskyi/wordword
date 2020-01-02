# frozen_string_literal: true

require_relative '../command'

module Wordword
  module Commands
    class Compose < Wordword::Command
      def initialize(options)
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        words = {}
        loop do
          word = prompt.ask("What is the word?(write \\q to exit)") do |w|
            w.required true
          end
          break if word == "\\q"
          translation = prompt.ask("What is the translation?(write \\q to exit)") do |t|
            t.required true
          end
          break if translation == "\\q"
          words[word] = translation
        end
      rescue TTY::Reader::InputInterrupt
        prompt.error("\n")
        prompt.error("You interrupted the command, exiting...")
      ensure
        exit unless words.any?
        save = prompt.yes?("Save the file?")
        if save
          filename = prompt.ask("What is the filename?")
          File.write(filename, words.map { |word| word.join(" # ") }.join("\n"))
        end
      end
    end
  end
end
