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
      compress_exist?
      find_image(load_config)
      find_video
    end

    def config(options)
      options.each do |key, value|
        case key
        when "--add-key" then add_key(value) if value
        when "--delete-key" then delete_key if value
        when "--show-count" then show_count if value
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
      write_config(KEY, value)
      reset_count
      puts "Add tinify api key."
    end

    def delete_key
      config_exist?
      write_config(KEY)
      reset_count
      puts "Delete tinify api key."
    end

    def show_count
      config_exist?
      compression_count = load_config.fetch(COMPRESSION_COUNT)
      puts "Compression count is #{compression_count}"
    end

    def config_exist?
      unless File.exist?(CONFIG_FILE)
        puts "Nothing #{CONFIG_FILE}. please `comiv init` command."
        exit(0)
      end
    end

    def compress_exist?
      unless File.exist?("#{STORED_DIRECTORY}/#{COMPRESS_DIRECTORY}")
        puts "Nothing #{STORED_DIRECTORY}/#{COMPRESS_DIRECTORY}. please `comiv init` command."
        exit(0)
      end
    end      

    def write_config(key, replacement = "nil")
      File.write(CONFIG_FILE, File.read(CONFIG_FILE).gsub(/#{key}:.*/, "#{key}: #{replacement}"))
    end

    def reset_count
      File.write(CONFIG_FILE, File.read(CONFIG_FILE).gsub(/#{COMPRESSION_COUNT}:.*/, "#{COMPRESSION_COUNT}: 0"))
    end

    def load_config
      YAML.load_file(CONFIG_FILE)
    end

    def find_image(config)
      puts "Checking image..."
      images = Dir.glob("#{STORED_DIRECTORY}/*.#{IMAGE_EXTENSION}")
      images.each.with_index(1) do |image, index|
        puts "Nothing image." if image.nil? 
        puts "#{index}: #{image}"
        index == images.size ?
          write_config(COMPRESSION_COUNT, Comiv::Tinify.compress_image(image, config["key"])) :
          Comiv::Tinify.compress_image(image, config["key"])
      end

      show_count
      puts "Completed."
    end

    def find_video
      puts "Checking video..."
      videos = Dir.glob("#{STORED_DIRECTORY}/*.#{VIDEO_EXTENSION}")
      videos.each.with_index(1) do |video, index|
        puts "Nothind video." if video.nil?
        puts "#{index}: #{video}"
        Comiv::FFmpeg.compress_video(video)
      end

      File.delete("ffmpeg2pass-0.log")
      File.delete("ffmpeg2pass-0.log.mbtree")
      puts "Complted."
    end
  end
end
