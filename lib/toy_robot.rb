class ToyRobot
  X_UNITS = 5
  Y_UNITS = 5
  DIRECTIONS = %w(NORTH EAST SOUTH WEST)

  def self.read(file)
    puts "# #{File.basename file}"
    toy_robot = self.new

    text = File.open(file).read
    text.split("\n").each do |command|
      case command
      when /(^MOVE$|^LEFT$|^RIGHT$|^REPORT$)/i
        puts command
        toy_robot.__send__($1.downcase)
      when /(PLACE)\s*(\d*),\s?(\d*),\s?(NORTH$|EAST$|SOUTH$|WEST$)/i
        puts command
        toy_robot.__send__($1.downcase, *[$2.to_i, $3.to_i, $4.upcase])
      end
    end
    puts "=> #{toy_robot.report}"
    puts "\n"
    toy_robot.report
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
    return unless @x && @y && @f

    case @f
    when "NORTH" then @y += 1 unless @y == (0...Y_UNITS).max
    when "EAST"  then @x += 1 unless @x == (0...X_UNITS).max
    when "SOUTH" then @y -= 1 unless @y == (0...Y_UNITS).min
    when "WEST"  then @x -= 1 unless @x == (0...X_UNITS).min
    end
  end

  def left
    return unless @f

    @f = DIRECTIONS[(DIRECTIONS.index(@f) - 1) % DIRECTIONS.count]
  end

  def right
    return unless @f

    @f = DIRECTIONS[(DIRECTIONS.index(@f) + 1) % DIRECTIONS.count]
  end

  def report
    return unless @x && @y && @f

    "#{x},#{y},#{f}"
  end
end
