module Sprites
  class Sprite
    def initialize(path)
      @name = File.basename(path)
      @images = []

      image_filenames = Dir.entries(path).select { |filename| filename =~ /.*\.png/ }
      image_filenames.each do |filename|
        @images << {
          filename: "#{filename}",
          image: Magick::ImageList.new("#{ path }/#{ filename }")
        }
      end

      # TODO: implement orientation choice
      @image_grid = Sprites::ImageGrid.new(@images, name: @name, orientation: :horizontal)
      @stylesheet = Sprites::SpriteStylesheet.new(@image_grid)
    end

    def name
      @name
    end

    def image
      @image_grid.to_image
    end

    def stylesheet
      @stylesheet.to_s
    end
  end
end