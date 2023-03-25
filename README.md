# DigitalDocument

Low level gem for representing and creating PDFs with Ruby

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add digital_document

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install digital_document

## Usage

This gem maps PDF Objects to Ruby data types and objects, allowing the generation
of PDFs with ease, without dependencies and using only Ruby!

| PDF        | Ruby                            |
|------------|---------------------------------|
| Boolean    | TrueClass, FalseClass           |
| Numeric    | Float, Integer                  |
| String     | String                          |
| Name       | Symbol                          |
| Array      | Array                           |
| Dictionary | Hash                            |
| Stream     | DigitalDocument::PDF::Stream    |
| Reference  | DigitalDocument::PDF::Reference |


A document can be created instantiating `DigitalDocument::PDF`, passing an `Array`
to the constructor with objects to build the PDF, as in the example below:

```ruby
pdf = DigitalDocument::PDF.new([
  {Type: :Catalog, Pages: DigitalDocument::PDF::Reference.new(2)},
  {Type: :Pages, Kids: [DigitalDocument::PDF::Reference.new(3)], Count: 1},
  {Type: :Page, MediaBox: [0, 0, 595.44, 841.68], Contents: DigitalDocument::PDF::Reference.new(4)},
  DigitalDocument::PDF::Stream.new("1.0 0.0 0.0 RG\n0.5 0.75 1.0 rg\n97.72 220.84 400 400 re\nB"),
])

DigitalDocument::PDF::Save.to_file("demo.pdf", pdf: pdf)
```
The example above produces the following PDF:
![image](https://user-images.githubusercontent.com/36938811/227730272-f3fc415b-1b8e-45b1-9227-864236e8d897.png)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tomascco/digital_document. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/tomascco/digital_document/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the DigitalDocument project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/tomascco/digital_document/blob/main/CODE_OF_CONDUCT.md).
