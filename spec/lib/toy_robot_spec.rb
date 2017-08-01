require "toy_robot"

describe ToyRobot do
  it 'should respond to :read with 1 argument' do
    expect(ToyRobot).to respond_to(:read).with(1).argument
  end
end
