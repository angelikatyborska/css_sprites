$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'css_sprites'

def template_filename
  'sprite'
end

def template_images_filenames
  %w{checkerboard puzzle arrow}
end

def resources_path
  "#{ File.dirname(__FILE__) }/resources"
end

def template_images
  template_images_filenames.each_with_object([]) do |filename, images|
    images << {
      filename: filename,
      image: Magick::ImageList.new("#{ resources_path }/#{ filename }.png")
    }
  end
end

def horizontal_sprite
  Magick::ImageList.new("#{ resources_path }/sprite_checkerboard_puzzle_arrow_horizontal.png")
end

def vertical_sprite
  Magick::ImageList.new("#{ resources_path }/sprite_checkerboard_puzzle_arrow_vertical.png")
end

def horizontal_sprite_image_grid
  CSSSprites::ImageGrid.new(template_images, name: template_filename, stacking: :horizontal)
end

def vertical_sprite_image_grid
  CSSSprites::ImageGrid.new(template_images, name: template_filename, stacking: :vertical)
end

def horizontal_sprite_stylesheet
  CSSSprites::SpriteStylesheet.new(horizontal_sprite_image_grid)
end

def vertical_sprite_stylesheet
  CSSSprites::SpriteStylesheet.new(vertical_sprite_image_grid)
end