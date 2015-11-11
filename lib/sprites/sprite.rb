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

      @image_grid = Sprites::ImageGrid.new(@images)
    end

    def name
      @name
    end

    def image
      @image_grid.to_image
    end

    def stylesheet

    end
  end
end