require "tinify"

module Comiv::Tinify
  Tinify.key = "XXXXX"
  COMPRESS_DIR = "compress"

  def compress_image(image)
    directory = File.dirname(image)
    file = File.basename(image)
    source = Tinify.from_file("#{image}")
    source.to_file("#{directory}/#{COMPRESS_DIR}/#{file}")
  end
end
