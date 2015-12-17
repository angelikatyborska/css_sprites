class Sprites::Sprite
  def initialize(path, options = {})
    validate_path(path)

    options[:name] ||= File.basename(path)

    @name = options[:name]
    @images = load_images(path)

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

  private

  def validate_path(path)
    fail ArgumentError, "Directory #{ path } does not exist" unless Dir.exists?(path)
    fail ArgumentError, "You do not have reading permissions for directory #{ path }" unless File.readable?(path)
  end

  def load_images(path)
    image_filenames = Dir.entries(path).select { |filename| filename =~ /.*\.png/ }

    fail ArgumentError, "Directory #{ path } contains no png files" if image_filenames.empty?

    image_filenames.each_with_object([]) do |filename, images|
      filepath = "#{ path }/#{ filename }"
      fail ArgumentError, "You do not have reading permissions for file #{ filename }" unless File.readable?(filepath)

      images << {
        filename: "#{filename}",
        image: Magick::ImageList.new(filepath)
      }
    end
  end
end