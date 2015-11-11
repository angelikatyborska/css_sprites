require 'spec_helper'
require_relative '../../lib/sprites/image_row'

RSpec.describe ImageRow do
  context 'with no images' do
    before :all do
      @image_row = ImageRow.new
    end

    describe '#total_width' do
      it 'equals zero' do
        expect(@image_row.total_width).to eq(0)
      end
    end

    describe '#total_width' do
      it 'equals zero' do
        expect(@image_row.total_height).to eq(0)
      end
    end

    describe '#to_image' do
      it 'return nil' do
        expect(@image_row.to_image).to eq(nil)
      end
    end
  end

  context 'with three differently-sized images with transparency' do
    before :all do
      @checkerboard = Magick::ImageList.new("#{File.realpath('.')}/spec/test_images/checkerboard.png")
      @puzzle = Magick::ImageList.new("#{File.realpath('.')}/spec/test_images/pink_puzzle_with_transparency.png")
      @arrow = Magick::ImageList.new("#{File.realpath('.')}/spec/test_images/arrow_tall.png")
      @sprite_checkerboard_puzzle_arrow = Magick::ImageList.new("#{File.realpath('.')}/spec/test_images/sprite_checkerboard_puzzle_arrow.png")

      @image_row = ImageRow.new(@checkerboard, @puzzle, @arrow)
    end

    describe '#to_image' do
      it 'returns a new image with all images in a row in the same order they were added' do
        diff = @image_row.to_image.compare_channel(@sprite_checkerboard_puzzle_arrow, Magick::AbsoluteErrorMetric)
        expect(diff[1]).to eq(0)
      end
    end

    describe '#total_width' do
      it 'returns the sum of widths of all images' do
        sum_of_widths = @checkerboard.columns + @puzzle.columns + @arrow.columns
        expect(@image_row.total_width).to eq(sum_of_widths)
      end
    end
  end
end