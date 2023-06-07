defmodule UrsusRpn.MixProject do
  use Mix.Project
  @version "0.1.0"

  def project do
    [
      app: :ipfx_rarbg,
      version: "0.1.0",
      elixir: ">= 1.14.1",
      start_permanent: Mix.env() == :prod,
      escript: [main_module: IpfxRarbg],
      deps: deps(),
      aliases: aliases(),
      # Docs
      name: "IpfxRarbg",
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp aliases do
    []
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:exqlite, "~> 0.13"},
      {:ex_sqlean, "~> 0.8.8"},
      {:ex_doc, "~> 0.29.1", only: [:docs, :test], runtime: false},
      {:dialyxir, "~> 1.2", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false}
    ]
  end

  defp docs do
    [
      main: "IpfxRarbg",
      source_ref: "v#{@version}"
    ]
  end
end
