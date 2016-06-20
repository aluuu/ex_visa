defmodule ExVisa.Mixfile do
  use Mix.Project

  @description """
  Elixir wrapper for the Visa Developer API
  """

  def project do
    [app: :ex_visa,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:httpoison, "~> 0.8"},
     {:exjsx, "~> 3.2"},
     {:decimal, "~> 1.1", only: :test}]
  end
end
