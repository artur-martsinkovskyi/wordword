# frozen_string_literal: true

RSpec.describe '`wordword train` command', type: :cli do
  it 'executes `wordword help train` command successfully' do
    output = `wordword help train`
    expected_output = <<~OUT
      Usage:
        wordword train FILE

      Options:
        -h, [--help], [--no-help]  # Display usage information

      Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
