defmodule MachineMonitorWeb.Serializers.User do
  use Remodel

  attributes [:uuid, :email, :full_name, :root, :role, :channel]

  def full_name(%{name: name}), do: name

  def role(_) do
    %{name: "", gates: [], entities: [], policies: []}
  end

  def channel(%{uuid: uuid}), do: "USER:"<>uuid
end