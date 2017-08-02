This is a toy robot simulator.

You can add examples in the examples directory, and execute the command below to run all examples.

The output shows:
1. Filename
2. Commands in the file
3. Output of the toy robot simulator

```
$ ruby run_examples.rb

# example_a.md
PLACE 0,0,NORTH
MOVE
REPORT
=> 0,1,NORTH

# example_b.md
PLACE 0,0,NORTH
LEFT
REPORT
=> 0,0,WEST

# example_c.md
PLACE 1,2,EAST
MOVE
MOVE
LEFT
MOVE
REPORT
=> 3,3,NORTH

# example_d.md
...
```
