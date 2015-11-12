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
      template_filename = 'sprite'

      Dir.chdir(File.dirname(__FILE__))
      Dir.mkdir(@dir_name)
      Dir.chdir(@dir_name)
      Dir.mkdir(template_filename)

      template_images_filenames.each do |filename|
        FileUtils.cp("#{File.dirname(__FILE__)}/resources/#{filename}.png", template_filename)
      end

      Sprites.generate_sprite("#{ Dir.pwd }/#{ template_filename }")
    end

    after :all do
      Dir.chdir('..')
      FileUtils.remove_dir(@dir_name)
    end

    it 'should create a css file' do
      sprite_image_files = Dir.entries(Dir.pwd).select { |filename| filename == "#{ template_filename }.css" }
      expect(sprite_image_files.size).to eq(1)
    end

    it 'should create a png file' do
      sprite_image_files = Dir.entries(Dir.pwd).select { |filename| filename == "#{ template_filename }.png" }
      expect(sprite_image_files.size).to eq(1)
    end
  end
end
