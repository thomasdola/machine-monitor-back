ExUnit.configure formatters: [ExUnitNotifier, ExUnit.CLIFormatter]
ExUnit.start(trace: true)

Ecto.Adapters.SQL.Sandbox.mode(MachineMonitor.Repo, :manual)

