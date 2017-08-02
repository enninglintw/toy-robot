require "toy_robot"

describe ToyRobot do
  it 'should respond to :read with 1 argument' do
    expect(ToyRobot).to respond_to(:read).with(1).argument
  end

  it 'should read example_a.md, and return an array with commands and args' do
    file = "examples/example_a.md"
    expect(ToyRobot.read(file)).to eq([["PLACE", 0, 0, "NORTH"], "MOVE", "REPORT"])
  end

  it 'should read example_b.md, and return an array with commands and args' do
    file = "examples/example_b.md"
    expect(ToyRobot.read(file)).to eq([["PLACE", 0, 0, "NORTH"], "LEFT", "REPORT"])
  end

  it 'should read example_c.md, and return an array with commands and args' do
    file = "examples/example_c.md"
    expect(ToyRobot.read(file)).to eq([["PLACE", 1, 2, "EAST"], "MOVE", "MOVE", "LEFT", "MOVE", "REPORT"])
  end

  it 'should read example_d.md, and return an array with commands and args' do
    file = "examples/example_d.md"
    expect(ToyRobot.read(file)).to eq(["move", "left", "right", "right", ["PLACE", 0, 2, "NORTH"], "move", "move", "move", "move", "move", "move", "move", "move", "right", "move", "left", "left", "REPORT"])
  end

  it { should respond_to(:place).with(3).arguments }
  it { should respond_to(:move) }
  it { should respond_to(:left) }
  it { should respond_to(:right) }
  it { should respond_to(:report) }
  it { should respond_to(:x) }
  it { should respond_to(:y) }
  it { should respond_to(:f) }

  let(:toy_robot) { ToyRobot.new }
  let(:x_units) { 5 }
  let(:y_units) { 5 }
  let(:directions) { %w(NORTH EAST SOUTH WEST) }

  describe '#place' do
    context 'x, y, f are all valid' do
      let(:x) { rand(x_units) }
      let(:y) { rand(y_units) }
      let(:f) { directions.sample }

      before { toy_robot.place(x, y, f) }

      it 'assigns toy_robot.x as x' do
        expect(toy_robot.x).to eq(x)
      end
      it 'assigns toy_robot.y as y' do
        expect(toy_robot.y).to eq(y)
      end
      it 'assigns toy_robot.f as f' do
        expect(toy_robot.f).to eq(f)
      end
    end

    context 'any of x, y, f is invalid' do
      context 'x is invalid' do
        let(:x) { -2 }
        let(:y) { rand(y_units) }
        let(:f) { directions.sample }

        it 'does not change toy_robot.x' do
          expect { toy_robot.place(x, y, f) }.to_not change { toy_robot.x }
        end
        it 'does not change toy_robot.y' do
          expect { toy_robot.place(x, y, f) }.to_not change { toy_robot.y }
        end
        it 'does not change toy_robot.f' do
          expect { toy_robot.place(x, y, f) }.to_not change { toy_robot.f }
        end
      end

      context 'y is invalid' do
        let(:x) { rand(x_units) }
        let(:y) { 12 }
        let(:f) { directions.sample }

        it 'does not change toy_robot.x' do
          expect { toy_robot.place(x, y, f) }.to_not change { toy_robot.x }
        end
        it 'does not change toy_robot.y' do
          expect { toy_robot.place(x, y, f) }.to_not change { toy_robot.y }
        end
        it 'does not change toy_robot.f' do
          expect { toy_robot.place(x, y, f) }.to_not change { toy_robot.f }
        end
      end

      context 'f is invalid' do
        let(:x) { rand(x_units) }
        let(:y) { rand(y_units) }
        let(:f) { "SOUTHWEST" }

        it 'does not change toy_robot.x' do
          expect { toy_robot.place(x, y, f) }.to_not change { toy_robot.x }
        end
        it 'does not change toy_robot.y' do
          expect { toy_robot.place(x, y, f) }.to_not change { toy_robot.y }
        end
        it 'does not change toy_robot.f' do
          expect { toy_robot.place(x, y, f) }.to_not change { toy_robot.f }
        end
      end
    end
  end

  describe '#report' do
    context 'after initialized' do
      it 'returns nil' do
        expect(toy_robot.report).to be_nil
      end
    end

    context 'after placed' do
      before { toy_robot.place(x, y, f) }

      context 'x, y, f are all valid' do
        let(:x) { rand(x_units) }
        let(:y) { rand(y_units) }
        let(:f) { directions.sample }

        it 'returns position x, y, f' do
          expect(toy_robot.report).to eq("#{x},#{y},#{f}")
        end

        context 'after placed again' do
          before { toy_robot.place(new_x, new_y, new_f) }

          context 'new_x, new_y, new_f are all valid' do
            let(:new_x) { rand(x_units) }
            let(:new_y) { rand(y_units) }
            let(:new_f) { directions.sample }

            it 'returns position new_x, new_y, new_f' do
              expect(toy_robot.report).to eq("#{new_x},#{new_y},#{new_f}")
            end
          end

          context 'any of new_x, new_y, new_f is invalid' do
            context 'new_x is invalid' do
              let(:new_x) { -2 }
              let(:new_y) { rand(y_units) }
              let(:new_f) { directions.sample }

              it 'returns position x, y, f' do
                expect(toy_robot.report).to eq("#{x},#{y},#{f}")
              end
            end
          end
        end
      end

      context 'any of x, y, f is invalid' do
        context 'x is invalid' do
          let(:x) { -2 }
          let(:y) { rand(y_units) }
          let(:f) { directions.sample }

          it 'returns nil' do
            expect(toy_robot.report).to be_nil
          end

          context 'after placed again' do
            before { toy_robot.place(new_x, new_y, new_f) }

            context 'new_x, new_y, new_f are all valid' do
              let(:new_x) { rand(x_units) }
              let(:new_y) { rand(y_units) }
              let(:new_f) { directions.sample }

              it 'returns position new_x, new_y, new_f' do
                expect(toy_robot.report).to eq("#{new_x},#{new_y},#{new_f}")
              end
            end

            context 'any of new_x, new_y, new_f is invalid' do
              context 'new_x is invalid' do
                let(:new_x) { -2 }
                let(:new_y) { rand(y_units) }
                let(:new_f) { directions.sample }

                it 'returns nil' do
                  expect(toy_robot.report).to be_nil
                end
              end
            end
          end
        end
        context 'y is invalid' do
          let(:x) { rand(x_units) }
          let(:y) { 12 }
          let(:f) { directions.sample }

          it 'returns nil' do
            expect(toy_robot.report).to be_nil
          end
        end
        context 'f is invalid' do
          let(:x) { rand(x_units) }
          let(:y) { rand(y_units) }
          let(:f) { "SOUTHWEST" }

          it 'returns nil' do
            expect(toy_robot.report).to be_nil
          end
        end
      end
    end
  end

  describe '#left' do
    context 'after placed' do
      let(:x) { rand(x_units) }
      let(:y) { rand(y_units) }

      before { toy_robot.place(x, y, f) }

      context 'facing NORTH' do
        let(:f) { "NORTH" }

        it 'faces WEST after turned left' do
          expect { toy_robot.left }.to change { toy_robot.f }.from("NORTH").to("WEST")
        end
      end

      context 'facing WEST' do
        let(:f) { "WEST" }

        it 'faces SOUTH after turned left' do
          expect { toy_robot.left }.to change { toy_robot.f }.from("WEST").to("SOUTH")
        end
      end

      context 'facing SOUTH' do
        let(:f) { "SOUTH" }

        it 'faces EAST after turned left' do
          expect { toy_robot.left }.to change { toy_robot.f }.from("SOUTH").to("EAST")
        end
      end

      context 'facing EAST' do
        let(:f) { "EAST" }

        it 'faces NORTH after turned left' do
          expect { toy_robot.left }.to change { toy_robot.f }.from("EAST").to("NORTH")
        end
      end
    end
  end
end
