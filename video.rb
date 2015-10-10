require 'fileutils'

class Video
  def self.find_videos path
    master_videos = []
    missing_video = []

    FileUtils.cd(path + "/Simon\ HERO4\ Black")
    puts "cd " + path + "/Simon\\ HERO4\\ Black;"
    Dir.foreach('.') do |item|

      next if item == '.' or item == '..'
      next unless item.include? ".MP4" # only MP4

      if item.start_with? "GOPR"
        # than it is a master video
        master_videos << MasterVideo.new(item)
      elsif item.start_with? "GP"
        # it is a sub video to one master
        master_video = match_any?(master_videos, SubVideo.new(item))
        if (master_video)
          master_video.sub_videos << SubVideo.new(item)
        else
          missing_video << SubVideo.new(item)
        end
      end
    end


    sort master_videos

    puts "missing_video: #{missing_video.inspect}"
    raise "Missing video exist" if missing_video.any?
    # puts "master_videos: #{master_videos.inspect}"

    return master_videos
  end


  # sort all sub videos
  def self.sort arr_of_master
    arr_of_master.each do |mv|
      mv.sort_sub
    end
  end


  def self.match_any? master_videos, item
    master_videos.each do |mv|
      return mv if mv.match? item
    end
    false
  end

end

# $ HandBrakeCLI  -i GP040994.MP4 -o GP040994_handbrake_cli.2.mp4 -e x264 -q 20 -B 160 👍
# https://trac.handbrake.fr/wiki/CLIGuide
# $ MP4Box -cat GOPR0912.MP4  -cat GP010912.MP4 -cat GP020912.MP4 -new GOPR0912_merged.MP4
