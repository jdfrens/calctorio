defmodule TestHelper do
  alias Calctorio.{AssemblyLine, Recipe}

  @default_recipe_attributes %{time: 1}
  @default_assembly_line_attributes %{}

  def build_recipe(attributes \\ %{}) do
    attributes = Map.merge(@default_recipe_attributes, Enum.into(attributes, %{}))
    struct(Recipe, attributes)
  end

  def build_assembly_line(attributes \\ %{}) do
    attributes = Map.merge(@default_assembly_line_attributes, Enum.into(attributes, %{}))
    struct(AssemblyLine, attributes)
  end
end

ExUnit.start()
