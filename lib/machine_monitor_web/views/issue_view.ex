defmodule MachineMonitorWeb.IssueView do
  use MachineMonitorWeb, :view

  def render("list.json", %{issues: issues}) do
    issues
  end
end