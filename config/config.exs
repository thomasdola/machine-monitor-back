# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :machine_monitor,
       ecto_repos: [MachineMonitor.Repo],
       env: Mix.env()

# Configures the endpoint
config :machine_monitor,
       MachineMonitorWeb.Endpoint,
       url: [
         host: "localhost"
       ],
       secret_key_base: "e0NaQK6Fwf3cto9WMedHWoC3qomm2nMN0Fh/yBAZU/Am12Vf9WXWI4pmL3iXf9V+",
       render_errors: [
         view: MachineMonitorWeb.ErrorView,
         accepts: ~w(html json)
       ],
       pubsub: [
         name: MachineMonitor.PubSub,
         adapter: Phoenix.PubSub.PG2
       ]

# Configures Elixir's Logger
config :logger,
       :console,
       format: "$time $metadata[$level] $message\n",
       metadata: [:request_id]

config :machine_monitor,
       MachineMonitorWeb.Auth.Guardian,
       issuer: "machine_monitor",
       secret_key: "fBI2iRXeCMjVpWDykjp7dFhjoAcTeGwwwuOmpBF/q3zzlqSrBAsRXm2U0EisoAD8"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
