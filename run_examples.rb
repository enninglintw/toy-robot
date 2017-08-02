require_relative "lib/toy_robot"
files = Dir["examples/*"]
files.map { |file| ToyRobot.read(file) }
