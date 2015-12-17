require 'spec_helper'

RSpec.describe CSSSprites::SpriteStylesheet do
  context 'with three differently-sized images' do
    context 'stacked horizontally' do
      it 'generates styles identical to the template' do
        expect(horizontal_sprite_stylesheet.to_s).to eq(File.read("#{File.dirname(__FILE__)}/../resources/#{template_filename}-horizontal.css"))
      end
    end

    context 'stacked vertically' do
      it 'generates styles identical to the template' do
        expect(vertical_sprite_stylesheet.to_s).to eq(File.read("#{File.dirname(__FILE__)}/../resources/#{template_filename}-vertical.css"))
      end
    end
  end
end