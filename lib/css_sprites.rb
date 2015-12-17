require 'css_sprites/version'
require 'css_sprites/image_grid'
require 'css_sprites/sprite_stylesheet'
require 'css_sprites/sprite'
require 'rmagick'

module CSSSprites
  # Generates a sprite from all PNG files in the directory specified by +path+.
  # Saves a PNG file and a CSS file in the specified directory's parent directory.
  # Returns the path to the directory to which those files were saved to.
  def self.generate_sprite(path, options = {})
    output_path = options[:output] || File.dirname(path)

    fail ArgumentError, "Directory #{ output_path } does not exist" unless Dir.exists?(output_path)
    fail ArgumentError, "You have no writing permissions for directory #{ output_path }" unless File.writable?(output_path)

    sprite = Sprite.new(path, options)

    output_file = "#{ output_path }/#{ sprite.name }"
    sprite.image.write("#{ output_file }.png")
    File.write("#{ output_file }.css", sprite.stylesheet)

    File.realpath(output_path)
  end
end
