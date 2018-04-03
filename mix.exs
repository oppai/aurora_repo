defmodule AuroraRepo.Mixfile do
  use Mix.Project

  def project do
    [
      app: :aurora_repo,
      version: "0.1.1",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
     {:ecto, "~> 2.2"},
     {:mariaex, github: "xflagstudio/mariaex", branch: "aurora_failover_0_8_4"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
