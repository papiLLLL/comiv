module FFmpeg
  VCODEC = "libx264"
  ACODEC = "aac"
  BITRATE = "2500k"
  NULL = "/dev/null"
  COMPRESS_DIR = "compress"

  def compress_video(video)
    directory = File.dirname(video)
    file = File.basename(video)
    `ffmpeg -i #{video} -c:v #{VCODEC} -an -pass 1 -f mp4 -loglevel error -y #{NULL}`
    `ffmpeg -i #{video} -c:v #{VCODEC} -c:a #{ACODEC} -pass 2 -loglevel error -b:v #{BITRATE} #{directory}/#{COMPRESS_DIR}/#{file}`
  end
end