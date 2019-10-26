require "tinify"
require_relative "config"

module Comiv::Tinify
  def self.compress_image(image, key)
    Tinify.key = key
    directory = File.dirname(image)
    file = File.basename(image)
    source = Tinify.from_file("#{image}")
    source.to_file("#{directory}/#{Comiv::COMPRESS_DIRECTORY}/#{file}")
  end
end
