defmodule Calctorio.Recipe do
  @moduledoc """
  Represents a recipe.
  """

  defstruct inputs: [], outputs: [], time: 0.0

  @type t :: %__MODULE__{
          inputs: keyword,
          outputs: keyword,
          time: float
        }
end
