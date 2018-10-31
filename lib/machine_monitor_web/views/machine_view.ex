defmodule MachineMonitorWeb.MachineView do
  use MachineMonitorWeb, :view

  def render("list.json", %{machines: machines}) do
    machines
  end

  def render("single.json", %{machine: machine}) do
    machine
  end

  def render("action.json", _) do
    %{done: true}
  end
end
