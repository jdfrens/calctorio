defmodule CalctorioTest do
  use ExUnit.Case, async: true
  import TestHelper

  doctest Calctorio

  alias Calctorio.{AssemblyLine, Productivity, Recipe, Speed}

  describe ".name" do
    test "assembly line with many inputs" do
      al = build_assembly_line()
      assert Calctorio.name(al) == {:error, "assembly lines have no name"}
    end

    test "recipe with many inputs and outputs" do
      r = build_recipe(%{inputs: [x: 20, y: 13, z: 5], outputs: [a: 3, b: 2]})
      assert Calctorio.name(r) == "x,y,z => a,b"
    end

    test "speed punts to recipe" do
      s = %Speed{
        recipe: build_recipe(%{inputs: [x: 20], outputs: [a: 9]}),
        multiplier: 1.0
      }

      assert Calctorio.name(s) == "x => a"
    end

    test "productivity punts to recipe" do
      p = %Productivity{
        recipe: build_recipe(%{inputs: [x: 20], outputs: [a: 9]})
      }

      assert Calctorio.name(p) == "x => a"
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

    test "speed with many inputs" do
      s = %Speed{
        recipe: build_recipe(%{inputs: [x: 20, y: 13, z: 5]}),
        multiplier: 1.0
      }

      assert Calctorio.input_items(s) == [:x, :y, :z]
    end

    test "productivity with many inputs" do
      p = %Productivity{
        recipe: build_recipe(%{inputs: [x: 20, y: 13, z: 5]})
      }

      assert Calctorio.input_items(p) == [:x, :y, :z]
    end
  end

  describe ".output_items" do
    test "recipe with many outputs" do
      r = build_recipe(%{outputs: [a: 20, b: 13, c: 5]})
      assert Calctorio.output_items(r) == [:a, :b, :c]
    end

    test "speed with many outputs" do
      s = %Speed{
        recipe: build_recipe(%{outputs: [a: 20, b: 13, c: 5]})
      }

      assert Calctorio.output_items(s) == [:a, :b, :c]
    end

    test "productivity with many outputs" do
      p = %Productivity{
        recipe: build_recipe(%{outputs: [a: 20, b: 13, c: 5]})
      }

      assert Calctorio.output_items(p) == [:a, :b, :c]
    end
  end

  describe ".input_rates" do
    test "recipe with many inputs" do
      r = build_recipe(%{inputs: [x: 20, y: 13, z: 5], time: 10})
      assert Calctorio.input_rates(r) == [x: 2, y: 1.3, z: 0.5]
    end

    test "speed with recipe with many inputs" do
      s = %Speed{
        recipe: build_recipe(%{inputs: [x: 20, y: 13, z: 5]}),
        multiplier: 2.0
      }

      assert Calctorio.input_rates(s) == [x: 40.0, y: 26.0, z: 10.0]
    end

    test "IGNORE productivity with recipe with many inputs" do
      s = %Productivity{
        recipe: build_recipe(%{inputs: [x: 20, y: 13, z: 5]}),
        multiplier: 2.0
      }

      assert Calctorio.input_rates(s) == [x: 20.0, y: 13.0, z: 5.0]
    end
  end

  describe ".output_rates" do
    test "recipe with many outputs" do
      r = build_recipe(%{outputs: [x: 20, y: 13, z: 5], time: 10})
      assert Calctorio.output_rates(r) == [x: 2, y: 1.3, z: 0.5]
    end

    test "speed with recipe with many outputs" do
      s = %Speed{
        recipe: build_recipe(%{outputs: [x: 20, y: 13, z: 5]}),
        multiplier: 3.0
      }

      assert Calctorio.output_rates(s) == [x: 60.0, y: 39.0, z: 15.0]
    end

    test "productivity with recipe with many outputs" do
      s = %Productivity{
        recipe: build_recipe(%{outputs: [x: 20, y: 13, z: 5]}),
        multiplier: 3.0
      }

      assert Calctorio.output_rates(s) == [x: 60.0, y: 39.0, z: 15.0]
    end
  end
end
