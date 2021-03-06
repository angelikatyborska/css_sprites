require 'optparse'

class CSSSprites::CLI
  def initialize(args)
    @args = args
    @options = {}
  end

  def parse!
    opts = OptionParser.new(&method(:set_options))
    opts.parse!(@args)
    path = ARGV[0]

    if path
      begin
        output = CSSSprites.generate_sprite(path, @options)
        $stdout.puts "Files saved to #{ output }"
      rescue ArgumentError => error
        $stdout.puts error.message
      end
    else
      $stderr.puts opts.banner
    end
  end

  private

  def set_options(opts)
    opts.banner = <<END
Usage: css_sprites [options] input_dir

Description:
  Merges png files from the input directory into one png file and generates an adequate stylesheet.
END

    opts.on(
      '-s',
      '--stacking TYPE',
      'Image stacking orientation. Can be horizontal (default) or vertical.'
    ) do |stacking|
      @options[:stacking] = stacking.to_sym || :horizontal
    end

    opts.on(
      '-n',
      '--name FILENAME',
      'The name for the generated css and png files. Uses input directory name if no name given.'
    ) do |name|
      @options[:name] = name
    end

    opts.on(
      '-o',
      '--output PATH',
      'The path to the directory to which generated files should be saved. Uses input directory\'s parent\'s path if no path given.'
    ) do |output|
      @options[:output] = output
    end

    opts.on_tail(
      '-h',
      '--help',
      'Show this message'
    ) do
      puts opts
      exit
    end

    opts.on_tail(
      '-v',
      '--version',
      'Show version'
    ) do
      puts "CSS Sprites #{ CSSSprites::VERSION }"
      exit
    end
  end
end