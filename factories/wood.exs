alias Calctorio.{AssemblyLine, Machine, Recipe}

defmodule WoodAssemblyLine do
  def foo do
    %AssemblyLine{
      root: wood_to_tar_and_petroleum(),
      lines: [
        %AssemblyLine{root: tar_to_solid_fuel()},
        %AssemblyLine{root: petroleum_to_solid_fuel()}
      ]
    }
  end

  def m(recipe) do
    %Machine{recipe: recipe}
  end

  def s(machine, multiplier) do
    %{machine | speed: multiplier}
  end

  def p(machine, multiplier) do
    %{machine | productivity: multiplier}
  end

  def wood_to_tar_and_petroleum do
    %Recipe{
      inputs: [wood: 1],
      outputs: [tar: 1, petroleum: 30],
      time: 3
    }
    |> m()
    |> s(8.75)
  end

  def tar_to_solid_fuel do
    %Recipe{
      inputs: [tar: 1],
      outputs: [solid_fuel: 1],
      time: 5
    }
    |> m()
    |> s(8.75)
  end

  def petroleum_to_solid_fuel do
    %Recipe{
      inputs: [petroleum: 20],
      outputs: [solid_fuel: 1],
      time: 3
    }
    |> m()
    |> p(1.20)
    |> s(6.75)
  end
end

WoodAssemblyLine.foo()
|> AssemblyLine.ratioize()
|> AssemblyLine.report()
|> IO.puts()
