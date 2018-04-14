defmodule CalctorioTest do
  use ExUnit.Case
  doctest Calctorio

  alias Calctorio.Recipe

  @default_recipe_attributes %{inputs: [], outputs: [], time: 1}

  def build_recipe(attributes) do
    attributes = Map.merge(@default_recipe_attributes, attributes)
    struct(Recipe, attributes)
  end

  describe "#input_rates" do
    test "recipe with many inputs" do
      r = build_recipe(%{inputs: [x: 20, y: 13, z: 5], time: 10})
      assert Calctorio.input_rates(r) == [x: 2, y: 1.3, z: 0.5]
    end
  end

  describe "#output_rates" do
    test "recipe with many inputs" do
      r = build_recipe(%{outputs: [x: 20, y: 13, z: 5], time: 10})
      assert Calctorio.output_rates(r) == [x: 2, y: 1.3, z: 0.5]
    end
  end
end
