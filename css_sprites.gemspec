# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'css_sprites/version'

Gem::Specification.new do |spec|
  spec.name          = "css_sprites"
  spec.version       = CSSSprites::VERSION
  spec.authors       = ["Angelika Tyborska"]
  spec.email         = ["atyborska93@gmail.com"]
  spec.summary       = %q{Merges many PNG images into a single image and generates a CSS stylesheet}
  spec.homepage      = "https://github.com/angelikatyborska/css_sprites"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4.0"
  spec.add_runtime_dependency "rmagick", "~> 2.15.4"
end
