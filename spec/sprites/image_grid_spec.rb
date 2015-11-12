require 'spec_helper'

RSpec.describe Sprites::ImageGrid do
  context 'with no images' do
    before :all do
      @empty_image_grid = Sprites::ImageGrid.new([])
    end

    describe '#total_width' do
      it 'equals zero' do
        expect(@empty_image_grid.total_width).to eq(0)
      end
    end

    describe '#total_width' do
      it 'equals zero' do
        expect(@empty_image_grid.total_height).to eq(0)
      end
    end

    describe '#to_image' do
      it 'return nil' do
        expect(@empty_image_grid.to_image).to eq(nil)
      end
    end
  end

  context 'with three differently-sized images' do
    context 'stacked horizontally' do
      describe '#to_image' do
        it 'returns a new image with all images in the same order they were added' do
          diff = horizontal_sprite_image_grid.to_image.compare_channel(horizontal_sprite, Magick::AbsoluteErrorMetric)
          expect(diff[1]).to eq(0)
        end
      end

      describe '#image_x_offset' do
        it 'returns the x coordinate of the image\'s top left corner in a given cell' do
          expect(horizontal_sprite_image_grid.image_x_offset(0, 0)).to eq(0)
          expect(horizontal_sprite_image_grid.image_x_offset(0, 1)).to eq(100)
          expect(horizontal_sprite_image_grid.image_x_offset(0, 2)).to eq(150)
        end
      end

      describe '#image_y_offset' do
        it 'returns 0 for every image' do
          expect(horizontal_sprite_image_grid.image_y_offset(0, 0)).to eq(0)
          expect(horizontal_sprite_image_grid.image_y_offset(0, 1)).to eq(0)
          expect(horizontal_sprite_image_grid.image_y_offset(0, 2)).to eq(0)
        end
      end

      describe '#total_width' do
        it 'calculates total width as sum of all images\' widths' do
          expect(horizontal_sprite_image_grid.total_width).to eq(template_images.map{ |image| image[:image].columns }.inject(0, :+))
        end
      end

      describe '#total_width' do
        it 'calculates total height as maximum of all images\' heights' do
          expect(horizontal_sprite_image_grid.total_height).to eq(template_images.map{ |image| image[:image].rows }.max)
        end
      end
    end

    context 'stacked vertically' do
      describe '#to_image' do
        it 'returns a new image with all images stacked vertically in the same order they were added' do
          diff = vertical_sprite_image_grid.to_image.compare_channel(vertical_sprite, Magick::AbsoluteErrorMetric)
          expect(diff[1]).to eq(0)
        end
      end

      describe '#image_x_offset' do
        it 'returns 0 for every image' do
          expect(vertical_sprite_image_grid.image_x_offset(0, 0)).to eq(0)
          expect(vertical_sprite_image_grid.image_x_offset(1, 0)).to eq(0)
          expect(vertical_sprite_image_grid.image_x_offset(2, 0)).to eq(0)
        end
      end

      describe '#image_y_offset' do
        it 'returns the y coordinate of the image\'s top left corner in a given cell' do
          expect(vertical_sprite_image_grid.image_y_offset(0, 0)).to eq(0)
          expect(vertical_sprite_image_grid.image_y_offset(1, 0)).to eq(100)
          expect(vertical_sprite_image_grid.image_y_offset(2, 0)).to eq(150)
        end
      end

      describe '#total_width' do
        it 'calculates total width as maximum of all images\' widths' do
          expect(vertical_sprite_image_grid.total_width).to eq(template_images.map{ |image| image[:image].columns }.max)
        end
      end

      describe '#total_width' do
        it 'calculates total height as sum of all images\' heights' do
          expect(vertical_sprite_image_grid.total_height).to eq(template_images.map{ |image| image[:image].rows }.inject(0, :+))
        end
      end
    end
  end
end