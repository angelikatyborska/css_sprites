require 'sprites/version'
require 'sprites/image_grid'
require 'sprites/sprite_stylesheet'
require 'sprites/sprite'
require 'rmagick'

module Sprites
  # Generates a sprite from all PNG files in the directory specified by +path+.
  # Saves a PNG file and a CSS file in the specified directory's parent directory.
  # Returns the path to the directory to which those files were saved to.
  def self.generate_sprite(path, options = {})
    output_path = options[:output] || File.dirname(path)

    # TODO: write specs for this
    fail ArgumentError, "Directory #{ output_path } does not exist" unless Dir.exists?(output_path)
    fail ArgumentError, "You have no writing permissions for directory #{ output_path }" unless File.writable?(output_path)

    sprite = Sprite.new(path, options)

    output_file = "#{ output_path }/#{ sprite.name }"
    sprite.image.write("#{ output_file }.png")
    File.write("#{ output_file }.css", sprite.stylesheet)

    File.realpath(output_path)
  end
end
