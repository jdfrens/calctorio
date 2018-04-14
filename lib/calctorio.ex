defmodule Calctorio do
  @moduledoc """
  Computes ratios for Factorio recipes.  "How many machines producing iron gears do 
  I need to support 10 machines producing red science?  What's the throughput of those 
  ten machines?"
  """

  alias Calctorio.{Recipe, Speed}

  @doc """
  Computes the input rates of input items.
  """
  def input_rates(%Recipe{inputs: inputs, time: time}) do
    Enum.map(inputs, fn {item, amount} -> 
      {item, amount / time} 
    end)
  end

  def input_rates(%Speed{craft_speed: craft_speed, recipe: recipe}) do
    recipe
    |> input_rates()
    |> Enum.map(fn {item, amount} -> 
      {item, amount * craft_speed} 
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

  def output_rates(%Speed{craft_speed: craft_speed, recipe: recipe}) do
    recipe
    |> output_rates()
    |> Enum.map(fn {item, amount} -> 
      {item, amount * craft_speed} 
    end)
  end
end
