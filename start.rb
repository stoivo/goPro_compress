load "master_video.rb"
load "video.rb"

require 'byebug'

require_relative "master_video"
require_relative "sub_video"
require_relative "video"

# dd = MasterVideo.new()
files = Video.find_videos("/Users/simon/Pictures/Kamera/GoPro/2015-08-19")
# puts files
files.each do |mv|
  puts "\n\n\n"
  mv.compress_all
  mv.merge_to_one_video
end

files = Video.find_videos("/Users/simon/Pictures/Kamera/GoPro/2015-08-27")
# files = Video.find_videos("/Users/simon/Pictures/Kamera/GoPro/2015-10-01")
# puts files
files.each do |mv|
  puts "\n\n\n"
  mv.compress_all
  mv.merge_to_one_video
end

