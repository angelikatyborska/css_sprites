class CSSSprites::ImageGrid
  def initialize(images, options = {})
    @images = images
    @name = options.fetch(:name, 'untitled')
    @stacking = options.fetch(:stacking, :horizontal)

    arrange_images!
  end

  def total_width
    row_widths = @grid.map.with_index { |row, index| image_x_offset(index, row.size) }
    row_widths.max
  end

  def total_height
    image_y_offset(total_rows)
  end

  def name
    @name
  end

  def image_name(row, column)
    File.basename(@grid[row][column][:filename], '.*')
  end

  def image_x_offset(row, column)
    return 0 if column == 0 || @images.empty?

    @grid[row][0..(column - 1)].inject(0) do |sum, image|
      sum += image[:image].columns
    end
  end

  def image_y_offset(row, column = 0)
    return 0 if row == 0 || @images.empty?

    row_heights = @grid[0..(row - 1)].map do |row|
      row.map { |image| image[:image].rows }.max
    end

    row_heights.inject(0, :+)
  end

  def to_image
    return nil if @images.empty?

    image_grid = Magick::Image.new(total_width, total_height) { self.background_color = 'transparent' }

    each_with_index do |image, n, k|
      image_grid = image_grid.composite(image, image_x_offset(n, k), image_y_offset(n), Magick::OverCompositeOp)
    end

    image_grid
  end

  def each_with_index(&block)
    @grid.each.with_index do |row, n|
      row.each.with_index do |image, k|
        block.call(image[:image], n, k)
      end
    end
  end

  private

  def arrange_images!
    @grid = [[]]

    if @stacking == :horizontal
      @images.each do |image|
        @grid[0] << image
      end
    else
      @images.each_with_index do |image, index|
        @grid[index] = [image]
      end
    end

    def total_rows
      @grid.size
    end

    def total_columns
      @grid.map { |row| row.size }.max
    end
  end
end
