defmodule MachineMonitorWeb.UserAuthController do
  use MachineMonitorWeb, :controller

  action_fallback MachineMonitorWeb.ActionFallbackController

  alias MachineMonitor.Accounts
  alias MachineMonitor.Accounts.User
  alias MachineMonitorWeb.Serializers.User, as: UserSerializer

  alias MachineMonitorWeb.Auth.Guardian

  def login(conn, %{"email" => email, "password" => plain_password}) do
    with {:ok, %User{name: name, email: email, uuid: uuid} = user} <- Accounts.Auth.authenticate_user(email, plain_password) do
      {:ok, token, _} = Guardian.encode_and_sign(user)
      user = UserSerializer.to_map(user) |> Map.put(:token, token)
      render(conn, "login.json", user: user)
    end
  end

  def logout(conn, _) do
    {:ok, _} = Guardian.Plug.current_token(conn) |> Guardian.revoke()
    render(conn, "logout.json")
  end
end