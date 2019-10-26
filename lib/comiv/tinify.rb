require "tinify"
require_relative "config"

module Comiv::Tinify
  Tinify.key = nil

  class << self
    def set_key(key)
      Tinify.key = key
    end

    def compress_image(image, key)
      set_key(key)
      directory = File.dirname(image)
      file = File.basename(image)
      source = Tinify.from_file("#{image}")
      source.to_file("#{directory}/#{Comiv::COMPRESS_DIRECTORY}/#{file}")
      Tinify.compression_count
    end
  end
end
