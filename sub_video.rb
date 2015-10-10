class SubVideo
  attr_accessor :video
  attr_accessor :lastest_name
  attr_accessor :has_commpresed_version  # handbrake version

  def initialize(arg)
    self.video = arg
    self.lastest_name = arg
    self.has_commpresed_version = false
  end

  def name
    name = video.split(".")[0]
    name += ".handbrake" if self.has_commpresed_version
    name += "." + video.split(".")[-1]
    name
  end

end
