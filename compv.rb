require_relative "ffmpeg"
require_relative "tinify"

class Compv
  def initialize
    @PATH = ARGV[0]
    @PHOTO_EXTENSION = "jpg"
  end

  def parse
    #docopt
  end

  def video_exist?
    # find mp4
  end

  def photo_exist?
    Dir.glob("#{@PATH}/*.#{@PHOTO_EXTENSION}") do |file|
      
    end
  end

  def path_exist?
    Dir.exist?(@PATH)
  end

  def start
    unless path_exist?
      puts "Not exist directory."
      exit(0)
    end

    photo_exist?
  end
end

Compv.new.start