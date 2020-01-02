require 'wordword/commands/compose'

RSpec.describe Wordword::Commands::Compose do
  it "executes `compose` command successfully" do
    output = StringIO.new
    options = {}
    command = Wordword::Commands::Compose.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
