require "comiv/version"
require "comiv/ffmpeg"
require "comiv/tinify"

include Tinify
include FFmpeg

module Comiv
  PATH = "#{__dir__}/test"
  IMAGE_EXTENSION = "jpg"
  VIDEO_EXTENSION = "mp4"

  class << self
    def parse
      #docopt
    end

    def find_video
      Dir.glob("#{PATH}/*.#{VIDEO_EXTENSION}") do |video|
        puts video
        compress_video(video)
      end
    end

    def find_image
      Dir.glob("#{PATH}/*.#{IMAGE_EXTENSION}") do |image|
        puts image
        compress_image(image)
      end
    end

    def path_exist?
      Dir.exist?(PATH)
    end

    def run(ARGV)
      puts "Begin comiv."
      unless path_exist?
        puts "Not exist directory."
        exit(0)
      end
      
      #find_image
      find_video
      puts "End comiv."
    end
  end
end