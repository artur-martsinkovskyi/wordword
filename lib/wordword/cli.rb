# frozen_string_literal: true

require "thor"
require_relative "../wordword"

module Wordword
  # Handle the application command line parsing
  # and the dispatch to various command objects
  #
  # @api public
  class CLI < Thor

    # Error raised by this runner
    Error = Class.new(StandardError)

    desc "version", "wordword version"
    def version
      require_relative "version"
      puts File.read(File.join(File.dirname(__FILE__), "..", "..", "assets/logo.txt"))
      puts "v#{Wordword::VERSION}"
    end
    map %w[--version -v] => :version

    desc "compose", "Launches a repl loop to create file with words/phrases and translations that can be fed to train"
    method_option :help, aliases: "-h", type: :boolean,
                         desc: "Display usage information"
    def compose(*)
      if options[:help]
        invoke :help, ["compose"]
      else
        require_relative "commands/compose"
        Wordword::Commands::Compose.new(options).execute
      end
    end

    desc "train FILE", "Train knowledge of the words in the provided file."
    method_option :help, aliases: "-h", type: :boolean,
                         desc: "Display usage information"
    method_option :number, type: :numeric, aliases: %w[-n],
                           desc: "Number of words to be trained"
    def train(file = nil)
      if options[:help]
        invoke :help, ["train"]
      else
        require_relative "commands/train"
        Wordword::Commands::Train.new(file, options).execute
      end
    end

  end
end
__END__

I8,        8        ,8I   ,ad8888ba,    88888888ba   88888888ba,             "8a           I8,        8        ,8I   ,ad8888ba,    88888888ba   88888888ba,
`8b       d8b       d8'  d8"'    `"8b   88      "8b  88      `"8b              "8a         `8b       d8b       d8'  d8"'    `"8b   88      "8b  88      `"8b
 "8,     ,8"8,     ,8"  d8'        `8b  88      ,8P  88        `8b               "8a        "8,     ,8"8,     ,8"  d8'        `8b  88      ,8P  88        `8b
  Y8     8P Y8     8P   88          88  88aaaaaa8P'  88         88                 "8a       Y8     8P Y8     8P   88          88  88aaaaaa8P'  88         88
  `8b   d8' `8b   d8'   88          88  88""""88'    88         88     aaaaaaaa    a8"       `8b   d8' `8b   d8'   88          88  88""""88'    88         88
   `8a a8'   `8a a8'    Y8,        ,8P  88    `8b    88         8P     """"""""  a8"          `8a a8'   `8a a8'    Y8,        ,8P  88    `8b    88         8P
    `8a8'     `8a8'      Y8a.    .a8P   88     `8b   88      .a8P              a8"             `8a8'     `8a8'      Y8a.    .a8P   88     `8b   88      .a8P
     `8'       `8'        `"Y8888Y"'    88      `8b  88888888Y"'             a8"                `8'       `8'        `"Y8888Y"'    88      `8b  88888888Y"'
