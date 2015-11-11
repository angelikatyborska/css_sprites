module Sprites
  class ImageGrid
    include Enumerable

    def initialize(images = [])
      @images = images
      arrange_images!
    end

    def total_width
      row_widths = @grid.map.with_index { |row, index| partial_width(index, row.size) }
      row_widths.inject(0, :+)
    end

    def total_height
      partial_height(total_rows, total_columns)
    end


    def name(row, column)
      @grid[row][column][:filename]
    end

    def partial_width(row, column)
      @grid[row][0..column].inject(0) do |sum, image|
        sum += image[:image].columns
      end
    end

    def partial_height(row, column)
      row_heights = @grid[0..row].map do |row|
        row[0..column].inject(0) do |sum, image|
          sum += image[:image].columns
        end
      end

      row_heights.inject(0, :+)
    end

    def to_image
      return nil if @images.empty?

      image_grid = Magick::Image.new(total_width, total_height) { self.background_color = 'transparent' }

      width_pointer = 0

      @images.each do |image|
        image_grid = image_grid.composite(image[:image], width_pointer, 0, Magick::OverCompositeOp)
        width_pointer += image[:image].columns
      end

      image_grid
    end

    def each(&block)
      @images.each do |image|
        block.call(image)
      end
    end

    private

    def arrange_images!
      @grid = [[]]

      @images.each do |image, index|
        @grid[0] << image
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
