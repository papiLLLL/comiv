require "tinify"

module Tinify
  Tinify.key = "L_nb7B7m7qiURVttmeUTID96hxHUeLg0"
  COMPRESS_DIR = "compress"

  def compress_image(image)
    directory = File.dirname(image)
    file = File.basename(image)
    source = Tinify.from_file("#{image}")
    source.to_file("#{directory}/#{COMPRESS_DIR}/#{file}")
  end
end