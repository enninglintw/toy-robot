require "toy_robot"

describe ToyRobot do
  it 'should respond to :read with 1 argument' do
    expect(ToyRobot).to respond_to(:read).with(1).argument
  end

  it 'should read example_a.md, and return an array' do
    file = "examples/example_a.md"
    expect(ToyRobot.read(file)).to eq(["PLACE 0,0,NORTH", "MOVE", "REPORT"])
  end

  it 'should read example_b.md, and return an array' do
    file = "examples/example_b.md"
    expect(ToyRobot.read(file)).to eq(["PLACE 0,0,NORTH", "LEFT", "REPORT"])
  end

  it 'should read example_c.md, and return an array' do
    file = "examples/example_c.md"
    expect(ToyRobot.read(file)).to eq(["PLACE 1,2,EAST", "MOVE", "MOVE", "LEFT", "MOVE", "REPORT"])
  end
end
