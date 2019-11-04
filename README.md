# ComIV
Compress image and video. 
Use FFmpeg and Tinify API.

## Extension
Following are supported extensions.

### Photo
- jpg

### Video
- mp4

## Requirement
- FFmpeg
- Tinify API key

## Install
```
gem install comiv
```

## Usage
Add key and store photo or video to stored directory. When ran, compressed file is created in stored/compress directory. 
```
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
  --show-count    Show compresstion count this month. however, it needs to be executed once.
  -h --help       Show help.
  -v --version    Show version.
```

## Licence
[MIT License](https://github.com/yuitoku/compv/blob/master/LICENSE.txt) @ Yuitoku
