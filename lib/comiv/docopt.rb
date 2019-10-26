require "docopt"

module Comiv::Docopt
  def self.docopt
    doc = <<DOCOPT
Usage:
  comiv init
  comiv run
  comiv config (--add-key KEY | --delete-key | --show-count)
  comiv -h | --help
  comiv -v | --version

Options:
  init            Create .comiv and stored directory.
  run             Compress image and video files in stored directory.
  config          Set comiv configuration.
  --add-key KEY   Add tinify api key.
  --delete-key    Delete tinify api key.
  --show-count    Show compresstion count this month.
  -h --help       Show help. 
  -v --version    Show version.
DOCOPT
    begin
      Docopt::docopt(doc)
    rescue Docopt::Exit => e
      e.message
    end
  end
end