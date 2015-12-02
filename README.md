# Sprites

Sprites finds all png files in the input directory, merges them together into a single png file and generates a CSS stylesheet for the output png file. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sprites'
```

And then execute:
```bash
$ bundle install
```

Or install it yourself as:
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
:name | string | input directory's name | Filename for the generated files


### Examples with options
In your Ruby app:

```ruby
options = {
    stacking: :vertical,
    name: 'so_awesome',
    output: "#{ Dir.pwd }/my_awesome_icons_output"
}
Sprites.generate_sprite("#{ Dir.pwd }/my_awesome_icons", options)
```

From the command line:

```bash
$ sprites -s vertical -n so_awesome -o my_awesome_icons_output my_awesome_icons
```
