defmodule MachineMonitorWeb.MachineLogView do
  use MachineMonitorWeb, :view

  def render("list.json", %{logs: logs}) do
    logs
  end
end