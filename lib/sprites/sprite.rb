class Sprites::Sprite
  def initialize(path, options = {})
    options[:name] ||= File.basename(path)
    @name = options[:name]
    @images = []

    image_filenames = Dir.entries(path).select { |filename| filename =~ /.*\.png/ }
    image_filenames.each do |filename|
      @images << {
        filename: "#{filename}",
        image: Magick::ImageList.new("#{ path }/#{ filename }")
      }
    end

    @image_grid = Sprites::ImageGrid.new(@images, options)
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