class ToyRobot
  X_UNITS = 5
  Y_UNITS = 5
  DIRECTIONS = %w(NORTH EAST SOUTH WEST)

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

  attr_accessor :x, :y, :f

  def x_is_valid?(x)
    (0...X_UNITS).to_a.include?(x)
  end

  def y_is_valid?(y)
    (0...Y_UNITS).to_a.include?(y)
  end

  def f_is_valid?(f)
    DIRECTIONS.include?(f)
  end

  def place(x, y, f)
    return unless x_is_valid?(x) && y_is_valid?(y) && f_is_valid?(f)

    @x, @y, @f = x, y, f
  end

  def move
  end

  def left
  end

  def right
  end

  def report
    return unless @x && @y && @f

    "#{x},#{y},#{f}"
  end
end
