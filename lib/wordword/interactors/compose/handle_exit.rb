# frozen_string_literal: true

require 'forwardable'
require_relative '../../operations/read_word_table'

module Compose
  class HandleExit
    extend Forwardable

    def_delegators :@command_context, :prompt

    MERGE = :merge
    REWRITE = :rewrite

    def initialize(command_context)
      @command_context = command_context
    end

    def call(words)
      exit unless words.any?
      return unless prompt.yes?('Save the file?')

      filename = prompt.ask('What is the filename?')
      if File.exist?(filename)
        file_mode = ask_file_mode
        if file_mode == REWRITE
          write_words(filename, words)
        elsif file_mode == MERGE
          existing_words = ReadWordTable.new.call(filename: filename).value!
          merged_words = existing_words.merge(words)

          write_words(filename, merged_words)
        end
      else
        write_words(filename, words)
      end
    end

    private

    def ask_file_mode
      prompt.select(
        'File with that name already exists. Merge, rewrite or discard current input?(it will be lost in that case)'
      ) do |menu|
        menu.choice 'Merge', -> { MERGE }
        menu.choice 'Rewrite', -> { REWRITE }
        menu.choice 'Discard'
      end
    end

    def write_words(filename, words)
      File.write(
        filename,
        words.sort.to_h.map { |word| word.join(' # ') }.join("\n")
      )
    end
  end
end
