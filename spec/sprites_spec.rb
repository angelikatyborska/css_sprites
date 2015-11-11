require 'spec_helper'
require 'time'
require 'fileutils'

RSpec.describe Sprites do
  it 'has a version number' do
    expect(Sprites::VERSION).not_to be nil
  end

  describe '#generate_sprite' do
    before :all do
      @dir_name = "generate_sprite_test_#{ Time.now.iso8601 }"
      @images_dir_name = 'sprite'

      Dir.chdir(File.dirname(__FILE__))
      Dir.mkdir(@dir_name)
      Dir.chdir(@dir_name)
      Dir.mkdir(@images_dir_name)

      filenames = %w{checkerboard.png pink_puzzle_with_transparency.png arrow_tall.png}
      filenames.each do |filename|
        FileUtils.cp("#{File.dirname(__FILE__)}/test_images/#{filename}", @images_dir_name)
      end

      Sprites.generate_sprite("#{ Dir.pwd }/#{ @images_dir_name}")
    end

    after :all do
      Dir.chdir('..')
      FileUtils.remove_dir(@dir_name)
    end

    it 'should create a css file' do
      sprite_image_files = Dir.entries(Dir.pwd).select { |filename| filename == "#{ @images_dir_name }.css" }
      expect(sprite_image_files.size).to eq(1)
    end

    it 'should create a png file' do
      sprite_image_files = Dir.entries(Dir.pwd).select { |filename| filename == "#{ @images_dir_name }.png" }
      expect(sprite_image_files.size).to eq(1)
    end
  end
end
