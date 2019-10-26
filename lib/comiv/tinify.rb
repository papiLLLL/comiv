require "tinify"

module Comiv::Tinify
  Tinify.key = nil
  COMPRESS_DIRECTORY = "compress"

  def self.compress_image(image, key)
    Tinify.key = key
    directory = File.dirname(image)
    file = File.basename(image)
    source = Tinify.from_file("#{image}")
    source.to_file("#{directory}/#{COMPRESS_DIRECTORY}/#{file}")
  end
end
