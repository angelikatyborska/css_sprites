require 'sprites/version'
require 'sprites/image_grid'
require 'sprites/sprite_stylesheet'
require 'sprites/sprite'
require 'rmagick'

module Sprites
  def self.generate_sprite(path)
    sprite = Sprite.new(path)
    sprite.image.write("#{ File.dirname(path) }/#{ sprite.name }.png")
    style = ::Stylish.generate do
      a :color => :bright
    end
  end
end
