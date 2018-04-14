defmodule Calctorio do
  @moduledoc """
  Computes ratios for Factorio recipes.  "How many machines producing iron gears do 
  I need to support 10 machines producing red science?  What's the throughput of those 
  ten machines?"
  """

  @doc """
  Computes the input rates of input items.
  """
  def input_rates(recipe) do
    recipe.inputs
    |> Enum.map(fn {item, amount} -> 
      {item, amount / recipe.time} 
    end)
  end

  @doc """
  Computes the output rates of output items.
  """
  def output_rates(recipe) do
    recipe.outputs
    |> Enum.map(fn {item, amount} -> 
      {item, amount / recipe.time} 
    end)
  end
end
