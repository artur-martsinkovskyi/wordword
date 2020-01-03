# frozen_string_literal: true

require "wordword/commands/train"

RSpec.describe Wordword::Commands::Train do
  it "executes `train` command successfully" do
    output = StringIO.new
    file = nil
    options = {}
    command = Wordword::Commands::Train.new(file, options)

    command.execute(output: output)

    expect(output.string).to eq(
      "File is not readable. Check if it exists and you have correct permissions."
    )
  end
end
