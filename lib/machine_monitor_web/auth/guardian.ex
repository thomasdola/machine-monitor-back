defmodule MachineMonitorWeb.Auth.Guardian do
  use Guardian, otp_app: :machine_monitor

  alias MachineMonitor.Accounts
  alias MachineMonitor.Accounts.{User, Machine}

  def subject_for_token(%User{id: id}, _claims) do
    {:ok, "USER:#{id}"}
  end
  def subject_for_token(%Machine{id: id}, _claims) do
    {:ok, "MACHINE:#{id}"}
  end

  def resource_from_claims(%{"sub" => "USER:" <> id}) do
    case Accounts.get_user(id) do
      nil -> {:error, :resource_not_found}
      user -> {:ok, user}
    end
  end
  def resource_from_claims(%{"sub" => "MACHINE:" <> id}) do
    case Accounts.get_machine(id) do
      nil -> {:error, :resource_not_found}
      machine -> {:ok, machine}
    end
  end
end
