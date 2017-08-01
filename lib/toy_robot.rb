class ToyRobot
  def self.read(file)
    text = File.open(file).read
    text.split("\n")
  end
end
