require 'sprites/version'
require 'sprites/image_grid'
require 'sprites/sprite_stylesheet'
require 'sprites/sprite'
require 'sprites/cli'
require 'rmagick'

module Sprites
  def self.generate_sprite(path, options = {})
    output_path = options[:output] || File.dirname(path)
    sprite = Sprite.new(path, options)
    sprite.image.write("#{ output_path }/#{ sprite.name }.png")
    File.write("#{ output_path }/#{ sprite.name }.css", sprite.stylesheet)
  end
end
