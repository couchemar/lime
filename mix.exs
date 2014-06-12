defmodule Lime.Mixfile do
  use Mix.Project

  def project do
    [ app: :lime,
      version: "0.0.1",
      elixir: "~> 0.14.0",
      compilers: [ :yecc, :leex, :erlang, :elixir, :app ],
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [mod: { Lime, [] }]
  end

  defp deps do
    [
     {:sand_cat, github: "couchemar/sand-cat"}
    ]
  end
end
