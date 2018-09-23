defmodule MachineMonitor.Repo do
  use Ecto.Repo, otp_app: :machine_monitor

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end

  @spec truncate(Ecto.Schema.t()) :: :ok
  def truncate(schema) do
    table_name = schema.__schema__(:source)
    query("TRUNCATE #{table_name}", [])
    :ok
  end
end
