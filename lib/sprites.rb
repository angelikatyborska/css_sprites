require 'sprites/version'
require 'sprites/image_grid'
require 'sprites/sprite_stylesheet'
require 'sprites/sprite'
require 'sprites/cli'
require 'rmagick'

module Sprites
  # Generates a sprite from all PNG files in the directory specified by +path+.
  # Saves a PNG file and a CSS file in the specified directory's parent directory.
  def self.generate_sprite(path, options = {})
    output_path = options[:output] || File.dirname(path)

    sprite = Sprite.new(path, options)

    output_file = "#{ output_path }/#{ sprite.name }"
    sprite.image.write("#{ output_file }.png")
    File.write("#{ output_file }.css", sprite.stylesheet)

    puts "Files saved to #{ File.realpath(output_path) }"
  end
end
