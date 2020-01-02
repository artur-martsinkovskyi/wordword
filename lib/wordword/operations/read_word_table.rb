# frozen_string_literal: true

require 'dry/monads'

class ReadWordTable
  include Dry::Monads[:result]

  def call(filename:)
    read_file(filename).bind do |lines|
      parse_lines(lines).fmap(&:itself)
    end
  end

  private

  def read_file(filename)
    Success(File.readlines(filename))
  rescue StandardError
    Failure(:file_is_not_readable)
  end

  def parse_lines(file)
    words = {}
    file.each do |line|
      next if line.strip == ''
      return Failure(:file_is_not_parseable) unless line.match?(/.*#.*/)

      word, translated_word = line.split('#').map(&:strip)
      words[word] = translated_word
    end
    Success(words)
  end
end
