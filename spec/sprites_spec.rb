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

      Dir.chdir(File.dirname(__FILE__))
      Dir.mkdir(@dir_name)
      Dir.chdir(@dir_name)
      Dir.mkdir(template_filename)

      template_images_filenames.each do |filename|
        FileUtils.cp("#{ resources_path }/#{ filename }.png", template_filename)
      end

      Sprites.generate_sprite(template_filename)
    end

    after :all do
      Dir.chdir(File.dirname(__FILE__))
      FileUtils.remove_dir(@dir_name)
    end

    context 'with valid arguments' do
      it 'should create a css file' do
        sprite_image_files = Dir.entries(Dir.pwd).select { |filename| filename == "#{ template_filename }.css" }
        expect(sprite_image_files.size).to eq(1)
      end

      it 'should create a png file' do
        sprite_image_files = Dir.entries(Dir.pwd).select { |filename| filename == "#{ template_filename }.png" }
        expect(sprite_image_files.size).to eq(1)
      end
    end

    context 'with a non-existent output directory' do
      it 'raises an ArgumentError' do
        expect { Sprites.generate_sprite(template_filename, output: 'non_existent_directory') }
          .to raise_error(ArgumentError, /non_existent_directory.*does not exist/)
      end
    end

    context 'with an unwritable output directory' do
      before :all do
        @unwritable_dir = 'unwritable_dir'
        template_filename = 'sprite'

        Dir.chdir(File.dirname(__FILE__))
        Dir.mkdir(@unwritable_dir)
        File.chmod(0555, @unwritable_dir)
      end

      after :all do
        Dir.chdir(File.dirname(__FILE__))
        FileUtils.remove_dir(@unwritable_dir)
      end

      it 'raises an ArgumentError' do
        expect { Sprites.generate_sprite(template_filename, output: @unwritable_dir) }
          .to raise_error(ArgumentError, Regexp.new("writing permissions.*for directory #{ @unwritable_dir }"))
      end
    end
  end
end
