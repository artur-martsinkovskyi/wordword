# frozen_string_literal: true

RSpec.describe "`wordword compose` command", type: :cli do
  it "executes `wordword help compose` command successfully" do
    output = `wordword help compose`
    expected_output = <<~OUT
      Usage:
        wordword compose

      Options:
        -h, [--help], [--no-help]  # Display usage information

      Launches a repl loop to create file with words/phrases and translations that can be fed to train
    OUT

    expect(output).to eq(expected_output)
  end
end
