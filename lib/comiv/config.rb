module Comiv
  CONFIG_DIRECTORY = ".comiv"
  STORED_DIRECTORY = "stored"
  COMPRESS_DIRECTORY = "compress"
  DIRECTORIES = [CONFIG_DIRECTORY, STORED_DIRECTORY, "#{STORED_DIRECTORY}/#{COMPRESS_DIRECTORY}"]
  CONFIG_FILE = ".comiv/config.yml"
  IMAGE_EXTENSION = "jpg"
  VIDEO_EXTENSION = "mp4"
  KEY = "key"
  COMPRESSION_COUNT = "compression_count"
  CONFIG = <<"CONTENT"
key: nil
compression_count: 0
CONTENT
end