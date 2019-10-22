require "comiv/version"
require "comiv/docopt"
require "comiv/ffmpeg"
require "comiv/tinify"

module Comiv
  CONFIG_DIRECTORY = ".comiv"
  STORED_DIRECTORY = "stored"
  CONFIG = "#{CONFIG_DIRECTORY}/config"
  PATH = "#{__dir__}/test"
  IMAGE_EXTENSION = "jpg"
  VIDEO_EXTENSION = "mp4"

  class << self
    def check_argument
      args = Comiv::Docopt.docopt
      if args.is_a?(Hash)
        check_command(args)
      else
        puts args
        exit(0)
      end
    end

    def check_command(args)
      command = args.find{ |k, v| v }.first
      command == "config" ? Comiv.send(command, args) : Comiv.send(command)
    end

    def init
      create_directory
      create_config
    end

    def delete
    end

    def run
    end

    def config(*options)
    end

    def create_directory
      [CONFIG_DIRECTORY, STORED_DIRECTORY].each do |dir|
        if File.exist?(dir)
          puts "Already #{dir} directory."
        else
          Dir.mkdir(dir)
          puts "Create #{dir} directory."
        end
      end
    end

    def create_config
      if File.exist?(CONFIG)
        puts "Already #{CONFIG}."
      else
        File.open("#{CONFIG_DIRECTORY}/config", "w").close()
        puts "Create #{CONFIG}."
      end
    end

    def find_video
      Dir.glob("#{PATH}/*.#{VIDEO_EXTENSION}") do |video|
        puts video
        Comiv::FFmpeg.compress_video(video)
      end
    end

    def find_image
      Dir.glob("#{PATH}/*.#{IMAGE_EXTENSION}") do |image|
        puts image
        Comiv::Tinify.compress_image(image)
      end
    end

    def path_exist?
      Dir.exist?(PATH)
    end

    def aaaa
      check_argument
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

Comiv.check_argument