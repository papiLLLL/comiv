require "yaml"

require "comiv/version"
require "comiv/config"
require "comiv/docopt"
require "comiv/ffmpeg"
require "comiv/tinify"

module Comiv
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
      command = args.find{ |key, value| value }.first
      command == "config" ? Comiv.send(command, args) : Comiv.send(command)
    end

    def init
      create_directory
      create_config
    end

    def run
      config_exist?
      find_image(load_config)
      find_video
    end

    def config(options)
      options.each do |key, value|
        case key
        when "--add-key" then add_key(value) if value
        when "--delete-key" then delete_key if value
        end
      end
    end

    def create_directory
      DIRECTORIES.each do |dir|
        if File.exist?(dir)
          puts "Already #{dir}"
        else
          Dir.mkdir(dir)
          puts "Create #{dir}"
        end
      end
    end

    def create_config
      if File.exist?(CONFIG_FILE)
        puts "Already #{CONFIG_FILE}"
      else
        File.write(CONFIG_FILE, CONFIG)
        puts "Create #{CONFIG_FILE}"
      end
    end

    def add_key(value)
      config_exist?
      write_config(value)
      puts "Add tinify api key."
    end

    def delete_key
      config_exist?
      write_config
      puts "Delete tinify api key."
    end

    def config_exist?
      unless File.exist?(CONFIG_FILE)
        puts "Nothing #{CONFIG_FILE}. please `comiv init` command."
        exit(0)
      end
    end

    def write_config(replacement = "nil")
      File.write(CONFIG_FILE, File.read(CONFIG_FILE).gsub(/key:.*/, "key: #{replacement}"))
    end

    def load_config
      YAML.load_file(CONFIG_FILE).fetch("key")
    end

    def find_image(key)
      count = 1
      puts "Checking image..."
      Dir.glob("#{STORED_DIRECTORY}/*.#{IMAGE_EXTENSION}") do |image|
        puts "Nothing image." if image.nil? 
        puts "#{count}: #{image}"
        Comiv::Tinify.compress_image(image, key)
        count += 1
      end

      puts "Completed."
    end

    def find_video
      count = 1
      puts "Checking video..."
      Dir.glob("#{STORED_DIRECTORY}/*.#{VIDEO_EXTENSION}") do |video|
        puts "Nothind video." if video.nil?
        puts "#{count}: #{video}"
        Comiv::FFmpeg.compress_video(video)
        count += 1
      end

      puts "Complted."
    end
  end
end

Comiv.check_argument