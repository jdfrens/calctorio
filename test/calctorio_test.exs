defmodule CalctorioTest do
  use ExUnit.Case, async: true
  import TestHelper

  doctest Calctorio

  alias Calctorio.{AssemblyLine, Machine, Recipe}

  describe ".name" do
    test "assembly line with many inputs" do
      al = build_assembly_line()
      assert Calctorio.name(al) == {:error, "assembly lines have no name"}
    end

    test "recipe with many inputs and outputs" do
      r = build_recipe(%{inputs: [x: 20, y: 13, z: 5], outputs: [a: 3, b: 2]})
      assert Calctorio.name(r) == "x,y,z => a,b"
    end

    test "machine punts to recipe" do
      m = %Machine{
        recipe: build_recipe(%{inputs: [x: 20], outputs: [a: 9]}),
        speed: 100_000.0,
        productivity: 99_999.9
      }

      assert Calctorio.name(m) == "x => a"
    end
  end

  describe ".input_items" do
    test "assembly line with many inputs" do
      al = %AssemblyLine{root: build_recipe(%{inputs: [x: 20, y: 13, z: 5]})}
      assert Calctorio.input_items(al) == [:x, :y, :z]
    end

    test "recipe with many inputs" do
      r = build_recipe(%{inputs: [x: 20, y: 13, z: 5]})
      assert Calctorio.input_items(r) == [:x, :y, :z]
    end

    test "machine with many inputs" do
      m = %Machine{
        recipe: build_recipe(%{inputs: [x: 20, y: 13, z: 5]}),
        speed: 10.0,
        productivity: 99.9
      }

      assert Calctorio.input_items(m) == [:x, :y, :z]
    end
  end

  describe ".output_items" do
    test "recipe with many outputs" do
      r = build_recipe(%{outputs: [a: 20, b: 13, c: 5]})
      assert Calctorio.output_items(r) == [:a, :b, :c]
    end

    test "machine with many outputs" do
      m = %Machine{
        recipe: build_recipe(%{outputs: [a: 20, b: 13, c: 5]}),
        speed: 10.0,
        productivity: 99.9
      }

      assert Calctorio.output_items(m) == [:a, :b, :c]
    end
  end

  describe ".input_rates" do
    test "recipe with many inputs" do
      r = build_recipe(%{inputs: [x: 20, y: 13, z: 5], time: 10})
      assert Calctorio.input_rates(r) == [x: 2, y: 1.3, z: 0.5]
    end

    test "machine with speed" do
      m = %Machine{
        recipe: build_recipe(%{inputs: [x: 20, y: 13, z: 5]}),
        speed: 2.0,
        productivity: 1.0
      }

      assert Calctorio.input_rates(m) == [x: 40.0, y: 26.0, z: 10.0]
    end

    test "machine with productivity which is ignored" do
      m = %Machine{
        recipe: build_recipe(%{inputs: [x: 20, y: 13, z: 5]}),
        speed: 1.0,
        productivity: 2.0
      }

      assert Calctorio.input_rates(m) == [x: 20.0, y: 13.0, z: 5.0]
    end

    test "machine with speed and productivity" do
      m = %Machine{
        recipe: build_recipe(%{inputs: [x: 20, y: 13, z: 5]}),
        speed: 2.0,
        productivity: 100.0
      }

      assert Calctorio.input_rates(m) == [x: 40.0, y: 26.0, z: 10.0]
    end
  end

  describe ".output_rates" do
    test "recipe with many outputs" do
      r = build_recipe(%{outputs: [x: 20, y: 13, z: 5], time: 10})
      assert Calctorio.output_rates(r) == [x: 2, y: 1.3, z: 0.5]
    end

    test "speed with recipe with many outputs" do
      m = %Machine{
        recipe: build_recipe(%{outputs: [x: 20, y: 13, z: 5]}),
        speed: 3.0,
        productivity: 1.0
      }

      assert Calctorio.output_rates(m) == [x: 60.0, y: 39.0, z: 15.0]
    end

    test "productivity with recipe with many outputs" do
      m = %Machine{
        recipe: build_recipe(%{outputs: [x: 20, y: 13, z: 5]}),
        speed: 1.0,
        productivity: 3.0
      }

      assert Calctorio.output_rates(m) == [x: 60.0, y: 39.0, z: 15.0]
    end

    test "speed and productivity" do
      m = %Machine{
        recipe: build_recipe(%{outputs: [x: 20, y: 13, z: 5]}),
        speed: 5.0,
        productivity: 3.0
      }

      assert Calctorio.output_rates(m) == [x: 300.0, y: 195.0, z: 75.0]
    end
  end
end
