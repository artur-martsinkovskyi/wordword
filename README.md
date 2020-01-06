# Wordword

Process of learning of a new language consist of two parts - grammar and vocabulary. First is best studied with a person near you, a book and will to understand and grasp the concepts of a language. The second, though, can be improved by repetition and perservance. In order to ease the process of repetition of learning words and stick to the most minimal sufficient environment without hussle of the UI this gem is created specifically to work in the console. Just toss the words and translations list file in the `wordword train FILE` command and you are good to go!

## Installation

Install it with:

    $ gem install wordword

## Usage

This application has two commands - `train` and `compose`.

`train` command is a command that is aimed to train (oh yeah?) your knowledge of the words in the file provided with tests like that one. It goes over all the words in the file and says you if you are wrong. In the end you are either congratulated with no wrong answers or given a list of wrong answers and their relative correct ones.

```
What is the translation of 'die Apfeltasche'? (Use ↑/↓ arrow keys, press Enter to select)
‣ apple pie
  beer
  hamburger
  fries
```

`compose` command allows you to create files that can be processed by `train` command. It asks you for word and translation until you ethier interrupt the command or type `\q` into the prompt.
After this you can save this in the file. If the file already exists, it allows you to merge new and old words and save them in that file, discard your new words or rewrite the file and write only the new words in the file.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/artur-martsinkovskyi/wordword. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the Wordword project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/artur-martsinovskyi/wordword/blob/master/CODE_OF_CONDUCT.md).

## Copyright

Copyright (c) 2020 Artur Martsinkovskyi. See [MIT License](LICENSE.txt) for further details.
