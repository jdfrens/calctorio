defmodule Calctorio.MixProject do
  use Mix.Project

  def project do
    [
      app: :calctorio,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      dialyzer: [flags: ["-Wunmatched_returns", :error_handling, :race_conditions, :underspecs]]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo, "~> 0.9.3", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.2", only: [:dev, :test], runtime: false}
    ]
  end

  defp aliases do
    [
      all_tests: [
        "compile --force --warnings-as-errors",
        "credo --strict",
        "format --check-formatted",
        "dialyzer"
        # "coveralls --umbrella"
      ]
    ]
  end
end
