# frozen_string_literal: true

require "wordword/commands/compose"
require "tty-prompt"
require "pry"

RSpec.describe Wordword::Commands::Compose do
  let(:prompt) { instance_double("TTY::Prompt") }

  before do
    allow(TTY::Prompt).to receive(:new).and_return(prompt)
  end

  it "executes `compose` command successfully" do
    output = StringIO.new
    options = {}
    command = Wordword::Commands::Compose.new(options)

    expect(prompt).to receive(:ask).with(
      "What is the word/phrase?(write #{described_class::QUIT_CODE} to exit)",
    ).and_return(described_class::QUIT_CODE)

    command.execute(output: output)
  end
end
