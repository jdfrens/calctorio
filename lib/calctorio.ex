defmodule Calctorio do
  @moduledoc """
  Computes ratios for Factorio recipes.  "How many machines producing iron gears do
  I need to support 10 machines producing red science?  What's the throughput of those
  ten machines?"

  ## Examples

          iex> alias Calctorio.{Machine, Recipe}
          iex> iron_plates =
          ...>   %Machine{
          ...>     productivity: 1.4,
          ...>     speed: 5.575,
          ...>     recipe: %Recipe{
          ...>       inputs: [iron_ore: 1],
          ...>       outputs: [iron_plate: 1],
          ...>       time: 3
          ...>     }
          ...>   }
          iex> gears =
          ...>   %Machine{
          ...>     productivity: 1.4,
          ...>     speed: 5.575,
          ...>     recipe: %Recipe{
          ...>       inputs: [iron_plate: 1],
          ...>       outputs: [gear: 2],
          ...>       time: 0.5
          ...>     }
          ...>   }
          iex> Calctorio.output_rates(iron_plates)
          [iron_plate: 2.6016666666666666]
          iex> Calctorio.input_rates(gears)
          [iron_plate: 11.15]
          iex> Calctorio.machine_ratio(:iron_plate, iron_plates, gears)
          0.2333333333333333

  iron_ore_to_gears =
    %Progression{
      recipe1: iron_plates,
      recipe2: gears
    }

  wood_to_solid_fuel = %{
    recipes: [wood_to_tar_and_petroleum_recipe],

  }
  """

  alias Calctorio.{AssemblyLine, Machine, Recipe}

  def name(%AssemblyLine{}), do: {:error, "assembly lines have no name"}

  def name(%Recipe{inputs: inputs, outputs: outputs}) do
    input_items = inputs |> Keyword.keys() |> Enum.join(",")
    output_items = outputs |> Keyword.keys() |> Enum.join(",")
    "#{input_items} => #{output_items}"
  end

  def name(%{recipe: recipe}) do
    name(recipe)
  end

  def machine_ratio(item, recipe1, recipe2) do
    output_rate = recipe1 |> output_rates() |> Keyword.fetch!(item)
    input_rate = recipe2 |> input_rates() |> Keyword.fetch!(item)
    output_rate / input_rate
  end

  def input_items(%AssemblyLine{root: root}), do: input_items(root)
  def input_items(%Recipe{inputs: inputs}), do: Keyword.keys(inputs)
  def input_items(%{recipe: recipe}), do: input_items(recipe)

  def output_items(%Recipe{outputs: outputs}), do: Keyword.keys(outputs)
  def output_items(%{recipe: recipe}), do: output_items(recipe)

  @doc """
  Computes the input rates of input items.
  """
  def input_rates(%Recipe{inputs: inputs, time: time}) do
    Enum.map(inputs, fn {item, amount} ->
      {item, amount / time}
    end)
  end

  def input_rates(%Machine{recipe: recipe, speed: speed}) do
    recipe
    |> input_rates()
    |> Enum.map(fn {item, amount} ->
      {item, amount * speed}
    end)
  end

  @doc """
  Computes the output rates of output items.
  """
  def output_rates(%Recipe{outputs: outputs, time: time}) do
    Enum.map(outputs, fn {item, amount} ->
      {item, amount / time}
    end)
  end

  def output_rates(%Machine{recipe: recipe, speed: speed, productivity: productivity}) do
    recipe
    |> output_rates()
    |> Enum.map(fn {item, amount} ->
      {item, amount * speed * productivity}
    end)
  end
end
