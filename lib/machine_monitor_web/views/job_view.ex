defmodule MachineMonitorWeb.JobView do
  use MachineMonitorWeb, :view

  def render("job.json", %{network: monitor_network, user_activity: monitor_user_activity,
    applications: applications, services: services})
  do
    %{network: monitor_network, user_activity: monitor_user_activity,
      applications: applications, services: services}
  end
end