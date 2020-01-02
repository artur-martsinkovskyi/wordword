# frozen_string_literal: true

require 'thor'

module Wordword
  # Handle the application command line parsing
  # and the dispatch to various command objects
  #
  # @api public
  class CLI < Thor
    # Error raised by this runner
    Error = Class.new(StandardError)

    desc 'version', 'wordword version'
    def version
      require_relative 'version'
      puts "v#{Wordword::VERSION}"
    end
    map %w[--version -v] => :version

    desc 'compose', 'Command description...'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def compose(*)
      if options[:help]
        invoke :help, ['compose']
      else
        require_relative 'commands/compose'
        Wordword::Commands::Compose.new(options).execute
      end
    end

    desc 'train FILE', 'Command description...'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    method_option :number, type: :numeric, aliases: %w[-n],
                           desc: 'Number of words to be trained'
    def train(file)
      if options[:help]
        invoke :help, ['train']
      else
        require_relative 'commands/train'
        Wordword::Commands::Train.new(file, options).execute
      end
    end
  end
end
