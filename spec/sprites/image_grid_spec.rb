require 'spec_helper'

RSpec.describe Sprites::ImageGrid do
  context 'with no images' do
    before :all do
      @image_row = Sprites::ImageGrid.new
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
      filenames = %w{checkerboard pink_puzzle_with_transparency arrow_tall}
      @images = []
      filenames.each do |filename|
        @images << {
            filename: filename,
            image: Magick::ImageList.new("#{File.dirname(__FILE__)}/../test_images/#{filename}.png")
        }
      end

      @sprite_checkerboard_puzzle_arrow = Magick::ImageList.new("#{File.dirname(__FILE__)}/../test_images/sprite_checkerboard_puzzle_arrow.png")

      @image_row = Sprites::ImageGrid.new(@images)
    end

    describe '#to_image' do
      it 'returns a new image with all images in a row in the same order they were added' do
        diff = @image_row.to_image.compare_channel(@sprite_checkerboard_puzzle_arrow, Magick::AbsoluteErrorMetric)
        expect(diff[1]).to eq(0)
      end
    end
  end
end