defmodule Calctorio.Machine do
  @moduledoc """
  Represents productivity modules.
  """

  defstruct recipe: nil, speed: 1.0, productivity: 1.0

  @type t :: %__MODULE__{
          recipe: Calctorio.Recipe.t(),
          speed: float,
          productivity: float
        }
end
