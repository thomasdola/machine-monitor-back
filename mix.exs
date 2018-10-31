defmodule MachineMonitor.Mixfile do
  use Mix.Project

  def project do
    [
      app: :machine_monitor,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {MachineMonitor.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    password_hash_lib = case :os.type() do
      {:unix, :linux} -> {:bcrypt_elixir, "~> 0.12"}
      _ -> {:pbkdf2_elixir, "~> 0.12.3"}
    end
    [
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.10"},
      {:comeonin, "~> 4.0"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.11"},
      {:nanoid, "~> 1.0"},
      {:guardian, "~> 1.0"},
      {:remodel, "~> 0.0.4"},
      {:cowboy, "~> 1.0"},
      {:xlsxir, "~> 1.6"},
      {:elixlsx, "~> 0.4.0"},
      {:csvlixir, "~> 2.0.3"},
      {:ex_unit_notifier, "~> 0.1.4", only: :test},
      {:edeliver, "~> 1.4.3"},
      {:distillery, "~> 1.4"},
      {:distance, "~> 0.2.1"},
      password_hash_lib
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
