defmodule Calctorio.AssemblyLineTest do
  use ExUnit.Case, async: true
  import TestHelper

  alias Calctorio.AssemblyLine

  describe ".ratioize" do
    test "compute ratios for one recipe" do
      assembly_line = build_assembly_line(root: build_recipe(inputs: [x: 2], outputs: [a: 9]))

      assert AssemblyLine.ratioize(assembly_line) == %{assembly_line | ratio: 1.0}
    end

    test "compute ratios for two recipes" do
      x_to_y = build_recipe(inputs: [x: 2], outputs: [y: 1])
      y_to_a = build_recipe(inputs: [y: 10], outputs: [a: 5])

      assembly_line =
        build_assembly_line(
          root: x_to_y,
          lines: [build_assembly_line(root: y_to_a)]
        )

      assert AssemblyLine.ratioize(assembly_line) ==
               build_assembly_line(
                 ratio: 1.0,
                 root: x_to_y,
                 lines: [build_assembly_line(ratio: 0.1, root: y_to_a)]
               )
    end

    test "compute ratios for three recipes in series" do
      x_to_y = build_recipe(inputs: [x: 2], outputs: [y: 1])
      y_to_z = build_recipe(inputs: [y: 10], outputs: [z: 5])
      z_to_a = build_recipe(inputs: [z: 10], outputs: [a: 3])

      assembly_line =
        build_assembly_line(
          root: x_to_y,
          lines: [
            build_assembly_line(
              root: y_to_z,
              lines: [build_assembly_line(root: z_to_a)]
            )
          ]
        )

      assert AssemblyLine.ratioize(assembly_line) ==
               build_assembly_line(
                 ratio: 1.0,
                 root: x_to_y,
                 lines: [
                   build_assembly_line(
                     ratio: 0.1,
                     root: y_to_z,
                     lines: [build_assembly_line(ratio: 0.05, root: z_to_a)]
                   )
                 ]
               )
    end

    test "computes ratios with branching" do
      w_to_xy = build_recipe(inputs: [w: 10], outputs: [x: 2, y: 15])
      x_to_z = build_recipe(inputs: [x: 10], outputs: [z: 10])
      z_to_a = build_recipe(inputs: [z: 5], outputs: [a: 8])
      y_to_b = build_recipe(inputs: [y: 5], outputs: [b: 20])

      assembly_line =
        build_assembly_line(
          root: w_to_xy,
          lines: [
            build_assembly_line(
              root: x_to_z,
              lines: [build_assembly_line(root: z_to_a)]
            ),
            build_assembly_line(root: y_to_b)
          ]
        )

      assert AssemblyLine.ratioize(assembly_line) ==
               build_assembly_line(
                 ratio: 1.0,
                 root: w_to_xy,
                 lines: [
                   build_assembly_line(
                     ratio: 0.2,
                     root: x_to_z,
                     lines: [build_assembly_line(ratio: 0.4, root: z_to_a)]
                   ),
                   build_assembly_line(ratio: 3.0, root: y_to_b)
                 ]
               )

      [
        {"w => x,y", 1},
        {"x => z", 2 / 10},
        {"z => a", 2 / 10 * 10 / 5},
        {"y => b", 15 / 5}
      ]
    end
  end

  describe ".common" do
    test "one item matches" do
      recipe = build_recipe(outputs: [x: 5, y: 2])
      assembly_line = build_assembly_line(root: build_recipe(inputs: [x: 5]))

      assert AssemblyLine.common_item(recipe, assembly_line) == :x
    end
  end
end
