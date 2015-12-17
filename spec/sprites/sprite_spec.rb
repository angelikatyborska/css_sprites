require 'spec_helper'

RSpec.describe Sprites::Sprite do
  describe '#initialize' do
    context 'with an input directory that does not exist' do
      it 'raises an ArgumentError' do
        expect { Sprites::Sprite.new('non_existent_dir') }.to raise_error(ArgumentError, /exist/)
      end
    end

    context 'with an input directory that does not have reading permissions' do
      before :all do
        @unreadable_dir = 'dir_without_reading_permissions'
        Dir.chdir(File.dirname(__FILE__))
        Dir.mkdir(@unreadable_dir, 0333)
      end

      after :all do
        Dir.rmdir(@unreadable_dir)
      end

      it 'raises an ArgumentError' do
        expect { Sprites::Sprite.new(@unreadable_dir) }
          .to raise_error(ArgumentError, Regexp.new("reading permissions.*for directory #{@unreadable_dir}"))
      end
    end

    context 'with an input directory with a single file that does not have reading permissions' do
      before :all do
        @dir_name = "sprite_unreadable_image_test_#{ Time.now.iso8601 }"
        @dir_with_unreadable_image = template_filename
        @image_filename = template_images_filenames[0]

        Dir.chdir(File.dirname(__FILE__))
        Dir.mkdir(@dir_name)
        Dir.chdir(@dir_name)
        Dir.mkdir(@dir_with_unreadable_image)

        FileUtils.cp("#{ resources_path }/#{ @image_filename }.png", @dir_with_unreadable_image)
        File.chmod(0333, "#{ @dir_with_unreadable_image }/#{ @image_filename }.png")
      end

      after :all do
        Dir.chdir("#{File.dirname(__FILE__)}")
        FileUtils.remove_dir(@dir_name)
      end

      it 'raises an ArgumentError' do
        expect { Sprites::Sprite.new("#{@dir_with_unreadable_image}") }
          .to raise_error(ArgumentError, Regexp.new("reading permissions.*for file #{@image_filename}"))
      end
    end
  end

  context 'with an empty input directory' do
    before :all do
      @dir_name = "sprite_empty_test_#{ Time.now.iso8601 }"
      @empty_dir = template_filename

      Dir.chdir(File.dirname(__FILE__))
      Dir.mkdir(@dir_name)
      Dir.chdir(@dir_name)
      Dir.mkdir(@empty_dir)
    end

    after :all do
      Dir.chdir(File.dirname(__FILE__))
      FileUtils.remove_dir(@dir_name)
    end

    it 'raises an ArgumentError' do
      expect { Sprites::Sprite.new(@empty_dir) }
        .to raise_error(ArgumentError, Regexp.new("#{@empty_dir}.*no png files"))
    end
  end

  context 'with a correct input directory' do
    before :all do
      @sprite = Sprites::Sprite.new(resources_path)
    end

    describe '#name' do
      it 'returns the name that was passed to new' do
        sprite = Sprites::Sprite.new(resources_path, name: 'my_name')
        expect(sprite.name).to eq 'my_name'
      end

      it 'is not nil when no name was passed to new' do
        expect(@sprite.name).not_to eq nil
      end
    end

    describe '#stylesheet' do
      it 'is not empty' do
        expect(@sprite.stylesheet).not_to be_empty
      end
    end
  end
end