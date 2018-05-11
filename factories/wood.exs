alias Calctorio.{AssemblyLine, Productivity, Recipe, Speed}

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

  def s(recipe, multiplier) do
    %Speed{
      multiplier: multiplier,
      recipe: recipe
    }
  end

  def p(recipe, multiplier) do
    %Productivity{
      multiplier: multiplier,
      recipe: recipe
    }
  end

  def wood_to_tar_and_petroleum do
    %Recipe{
      inputs: [wood: 1],
      outputs: [tar: 1, petroleum: 30],
      # maybe in a %Machine{}?
      crafting_speed: 1.25,
      time: 3
    }
    |> s(8.75)
  end

  def tar_to_solid_fuel do
    %Recipe{
      inputs: [tar: 1],
      outputs: [solid_fuel: 1],
      # maybe in a %Machine{}?
      crafting_speed: 1.25,
      time: 5
    }
    |> s(8.75)
  end

  def petroleum_to_solid_fuel do
    %Recipe{
      inputs: [petroleum: 20],
      outputs: [solid_fuel: 1],
      # maybe in a %Machine{}?
      crafting_speed: 1.25,
      time: 3
    }
    |> p(1.20)
    |> s(6.75)
  end
end

WoodAssemblyLine.foo()
|> AssemblyLine.ratioize()
|> AssemblyLine.report()
|> IO.puts()
