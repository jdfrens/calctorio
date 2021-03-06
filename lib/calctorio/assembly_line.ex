defmodule Calctorio.AssemblyLine do
  @moduledoc """
  Represents an assembly line.
  """

  alias Calctorio.{AssemblyLine, Machine}

  defstruct root: nil, lines: [], ratio: nil

  @type t :: %__MODULE__{
          root: Machine.t(),
          lines: list(AssemblyLine.t()),
          ratio: float | nil
        }

  @spec common_item(Calctorio.Machine.t(), Calctorio.Machine.t()) :: atom
  def common_item(first, second) do
    outputs = first |> Calctorio.output_items() |> MapSet.new()
    inputs = second |> Calctorio.input_items() |> MapSet.new()

    case Enum.into(MapSet.intersection(outputs, inputs), []) do
      [] -> {:error, "the first recipe does not feed the second"}
      [one] -> one
      _ -> {:error, "cannot handle one recipe feeding multiple outputs"}
    end
  end

  @spec ratioize(AssemblyLine.t()) :: AssemblyLine.t()
  def ratioize(%AssemblyLine{lines: []} = assembly_line) do
    %{assembly_line | ratio: 1.0}
  end

  def ratioize(%AssemblyLine{root: root, lines: lines}) do
    scale(%AssemblyLine{
      ratio: 1.0,
      root: root,
      lines:
        lines
        |> Enum.map(&ratioize(&1))
        |> Enum.map(fn %AssemblyLine{root: line_root} = assembly_line ->
          ratio = Calctorio.machine_ratio(common_item(root, line_root), root, line_root)
          %{assembly_line | ratio: ratio}
        end)
    })
  end

  @spec scale(AssemblyLine.t(), float) :: AssemblyLine.t()
  def scale(%AssemblyLine{root: root, ratio: ratio, lines: lines}, running_ratio \\ 1.0) do
    next_ratio = ratio * running_ratio

    %AssemblyLine{
      ratio: next_ratio,
      root: root,
      lines: Enum.map(lines, &scale(&1, next_ratio))
    }
  end

  @spec report(AssemblyLine.t(), String.t()) :: String.t()
  def report(%AssemblyLine{ratio: ratio, root: root, lines: lines}, indent \\ "") do
    lines_report =
      lines
      |> Enum.map(&report(&1, indent <> "  "))
      |> Enum.join()

    "#{indent}#{Calctorio.name(root)} #{ratio}\n" <> lines_report
  end
end
