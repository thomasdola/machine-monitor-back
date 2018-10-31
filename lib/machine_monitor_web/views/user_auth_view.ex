defmodule MachineMonitorWeb.UserAuthView do
  use MachineMonitorWeb, :view

  def render("login.json", %{user: user}) do
    user
  end

  def render("logout.json", _) do
    %{logout: true}
  end
end