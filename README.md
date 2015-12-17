# Sprites

Sprites finds all png files in the input directory, merges them together into a single PNG file and generates a CSS stylesheet for the output image. 

## Prerequisites

**ImageMagick** Version 6.4.9 or later. You can get ImageMagick from [www.imagemagick.org](http://www.imagemagick.org).

Or, if you're on Mac OS X and using Homebrew, you can install it by typing:

```bash
$ brew install imagemagick
```

And if you're using Ubuntu:

```bash
$ apt-get imagemagick
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sprites'
```

And then execute:
```bash
$ bundle install
```

Or install it yourself:
```bash
$ gem install sprites
```

## Usage

In your Ruby app:

```ruby
require 'sprites'
Sprites.generate_sprite(path_to_images, options_hash)
```

Or from the command line:

```bash
$ sprites path/to/images
```

### Options

Option | Type | Default | Description
------ | ---- | ------- | -----------
:stacking | :horizontal or :vertical | :horizontal | How to order images in the sprite
:output | string | input directory's parent path | Where to save the generated files
:name | string | input directory's name | A name for the generated files


### Examples with options
In your Ruby app:

```ruby
options = {
    stacking: :vertical,
    name: 'so_awesome',
    output: 'my_awesome_icons_output'
}
Sprites.generate_sprite('my_awesome_icons', options)
```

From the command line:

```bash
$ sprites --stacking vertical --name so_awesome --output my_awesome_icons_output my_awesome_icons
```

For more details:

```bash
$ sprites --help
```
