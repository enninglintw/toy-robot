class ToyRobot
  def self.read(file)
    text = File.open(file).read
    text.split("\n").map do |command|
      case command
      when /(^MOVE$|^LEFT$|^RIGHT$|^REPORT$)/i
        $1
      when /(PLACE)\s*(\d*),\s?(\d*),\s?(NORTH$|EAST$|SOUTH$|WEST$)/i
        [$1, $2.to_i, $3.to_i, $4]
      end
    end.compact
  end

  def place(x, y, f)
  end

  def move
  end

  def left
  end

  def right
  end

  def report
  end
end
