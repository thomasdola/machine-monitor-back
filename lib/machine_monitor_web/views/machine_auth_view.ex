defmodule MachineMonitorWeb.MachineAuthView do
  use MachineMonitorWeb, :view

  def render("login.json", %{token: token, uuid: uuid}) do
    %{uuid: uuid, jwt: %{token: token}}
  end

  def render("logout.json", _) do
    %{logout: true}
  end
end