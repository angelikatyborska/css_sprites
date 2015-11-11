class ImageRow
  include Enumerable

  def initialize(*images)
    @images = images
  end

  def total_width
    @images.inject(0) { |sum, image| sum += image.columns }
  end

  def total_height
    tallest_image = @images.max { |image1, image2| image1.rows <=> image2.rows }
    tallest_image.nil? ? 0 : tallest_image.rows
  end

  def partial_width(n)
    @images[n].columns
  end

  def partial_height(n)
    @images[n].rows
  end

  def to_image
    return nil if @images.empty?

    image_row = Magick::Image.new(total_width, total_height) { self.background_color = 'transparent' }

    width_pointer = 0

    @images.each do |image|
      image_row = image_row.composite(image, width_pointer, 0, Magick::OverCompositeOp)
      width_pointer += image.columns
    end

    image_row
  end

  def each(&block)
    @images.each do |image|
      block.call(image)
    end
  end
end