# JojoEncrypted

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/jojo_encrypted`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jojo_encrypted'
```

Or you can do this
```ruby
gem 'jojo_encrypted', git: 'git@github.com:solehudinmq/jojo_encrypted.git', branch: 'master'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jojo_encrypted

## Usage

After that create this file in:

    $ config/jojo_encrypted.yml

With the contents of a file like this:

    $ SECRET_KEY_BASE: "xxxxxxx"
    $ ENCRYPTION_SERVICE_SALT: "xxxxxxx"

You can try the following steps to create a value from the .yml file:

  1. SECRET_KEY_BASE
    - irb
    - require 'active_support'
    - SecureRandom.random_bytes(
        ActiveSupport::MessageEncryptor.key_len
      ) 
  2. ENCRYPTION_SERVICE_SALT
    - irb
    - require 'securerandom'
    - SecureRandom.hex(64)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/jojo_encrypted. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the JojoEncrypted project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/jojo_encrypted/blob/master/CODE_OF_CONDUCT.md).
