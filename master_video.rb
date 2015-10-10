class MasterVideo
  attr_accessor :video , :sub_videos, :lastest_name
  attr_accessor :has_commpresed_version  # handbrake version

  def initialize(arg)
    self.video = arg
    self.lastest_name = arg
    self.sub_videos = []
  end

  def match? name
    video[-8..-5] == name.video[-8..-5]
  end

  def sort_sub
    self.sub_videos.sort {|a,b|
      a.lastest_name <=> b.lastest_name
    }
  end

  def name
    name = video.split(".")[0]
    name += ".handbrake" if self.has_commpresed_version
    name += "." + video.split(".")[-1]
    name
  end

  def merge_to_one_video
    # $ MP4Box -cat GOPR0912.MP4  -cat GP010912.MP4 -cat GP020912.MP4 -new GOPR0912_merged.MP4
    return nil if sub_videos.empty?
    command = "MP4Box "
    command += "-cat #{name} "
    sub_videos.each do |sub_video|
      command += "-cat #{sub_video.name} "
    end
    self.lastest_name = "#{video.split('.')[0]}_merged.MP4"
    command += "-new #{self.lastest_name} ;"
    puts command
  end

  def compress_all
    # $ HandBrakeCLI  -i GP040994.MP4 -o GP040994_handbrake_cli.2.mp4 -e x264 -q 20 -B 160 👍
    command = "HandBrakeCLI -i #{self.name} -o #{video.split('.')[0]}.handbrake.MP4 -e x264 -q 20 -B 160;"
    self.lastest_name = "#{video.split('.')[0]}.handbrake.MP4"
    self.has_commpresed_version = true
    puts command
    compress_all_sub
  end

  def compress_all_sub
    sub_videos.each do |vid|
      command = "HandBrakeCLI -i #{vid.name} -o #{vid.name.split('.')[0]}.handbrake.MP4 -e x264 -q 20 -B 160;"
      vid.has_commpresed_version = true
      # "#{vid.split('.')[0]}.handbrake.MP4"
      vid.lastest_name = "#{vid.video.split('.')[0]}.handbrake.MP4"
      puts command
    end
    true
  end


end
