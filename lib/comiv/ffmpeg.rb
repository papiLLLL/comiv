require_relative "config"

module Comiv::FFmpeg
  VCODEC = "libx264"
  ACODEC = "aac"
  BITRATE = "2500k"
  NULL = "/dev/null"

  def self.compress_video(video)
    directory = File.dirname(video)
    file = File.basename(video)
    `ffmpeg -i #{video} -c:v #{VCODEC} -an -pass 1 -f mp4 -loglevel error -y #{NULL}`
    `ffmpeg -i #{video} -c:v #{VCODEC} -c:a #{ACODEC} -pass 2 -loglevel error -b:v #{BITRATE} -y #{directory}/#{Comiv::COMPRESS_DIRECTORY}/#{file}`
  end
end
