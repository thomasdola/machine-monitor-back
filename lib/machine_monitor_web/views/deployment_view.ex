defmodule MachineMonitorWeb.DeploymentView do
  use MachineMonitorWeb, :view

  def render("list.json", %{deployments: deployments}) do
    deployments
  end
end