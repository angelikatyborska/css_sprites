$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'sprites'

def template_filename
  'sprite'
end

def template_images_filenames
  %w{checkerboard puzzle arrow}
end

def template_images
  images = []

  template_images_filenames.each do |filename|
    images << {
      filename: filename,
      image: Magick::ImageList.new("#{File.dirname(__FILE__)}/resources/#{filename}.png")
    }
  end

  images
end

def horizontal_sprite
  Magick::ImageList.new("#{File.dirname(__FILE__)}/resources/sprite_checkerboard_puzzle_arrow_horizontal.png")
end

def vertical_sprite
  Magick::ImageList.new("#{File.dirname(__FILE__)}/resources/sprite_checkerboard_puzzle_arrow_vertical.png")
end

def horizontal_sprite_image_grid
  Sprites::ImageGrid.new(template_images, name: template_filename, stacking: :horizontal)
end

def vertical_sprite_image_grid
  Sprites::ImageGrid.new(template_images, name: template_filename, stacking: :vertical)
end

def horizontal_sprite_stylesheet
  Sprites::SpriteStylesheet.new(horizontal_sprite_image_grid)
end

def vertical_sprite_stylesheet
  Sprites::SpriteStylesheet.new(vertical_sprite_image_grid)
end