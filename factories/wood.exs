alias Calctorio.{AssemblyLine, Recipe}

wood_to_tar_and_petroleum = %Recipe{
  inputs: [wood: 1],
  outputs: [tar: 1, petroleum: 30],
  time: 3
}

tar_to_solid_fuel = %Recipe{
  inputs: [tar: 1],
  outputs: [solid_fuel: 1],
  time: 5
}

petroleum_to_solid_fuel = %Recipe{
  inputs: [petroleum: 20],
  outputs: [solid_fuel: 1],
  time: 3
}

wood_to_solid_fuel = %AssemblyLine{
  root: wood_to_tar_and_petroleum,
  lines: [
    %AssemblyLine{root: tar_to_solid_fuel},
    %AssemblyLine{root: petroleum_to_solid_fuel}
  ]
}

wood_to_solid_fuel
|> AssemblyLine.ratioize()
|> AssemblyLine.report()
|> IO.puts()
