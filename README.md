# Presentify

Is a little ruby gem that turns a folder of ruby scripts into
a CLI based presentation, where one can show and run the code.

## Installation

    $ gem install presentify

## Slides

Any folder with numerical filenames

    slides/
      1.rb
      2.rb
      ...

Every slide should have a header comment with the slide title and
some ruby code to show / run

    # Slide Title

    print "Hello world!"

## Running and navigating

You can start your presentation by running the `presentify` command
with the argument that points to your slides folder

    $ presentify slides

Once it starts, use the arrow keys to switch between slides and code/demo modes

* `up` - show the code
* `down` - run the code
* `left` - previous slide
* `right` - next slide

## License & Copyright

All code in this library is licensed under the terms of the MIT License

Copyright (C) 2014 Nikolay Nemshilov
