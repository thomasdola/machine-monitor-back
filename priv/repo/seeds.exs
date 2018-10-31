# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     MachineMonitor.Repo.insert!(%MachineMonitor.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias MachineMonitor.{Repo, Accounts, Settings, Location}

# seed root user
Repo.truncate(Accounts.User)
Accounts.create_user!(
  %{email: "admin@admin.admin", name: "Mr Admin", password: "adminadmin", root: true}
)

# seed available networks for the project
Repo.truncate(Settings.Network)
Enum.each([%{operator: "MTN", type: "SIM/4G"}, %{operator: "Vodafone", type: "SIM/3G"}, %{operator: "BNC", type: "Router"}], fn network ->  
  {:ok, _} = Settings.create_network(network)
end)

# seed centers
# Repo.truncate(Settings.Center)
# centers_sheet = Path.join([:code.priv_dir(:machine_monitor), "/store/seeds/centers_with_coordinates.xlsx"])
# Settings.create_centers_from_sheet(centers_sheet)


# _seed_districts_for = fn 
#   %{name: "GREATER ACCRA", id: region_id} = region ->  
#     sheet = Path.join([:code.priv_dir(:machine_monitor), "/store/seeds/greater_accra_districts.xlsx"])
#     Location.create_districts_from_sheet(region_id, sheet)
#     region
#   region -> region
# end

# seed regions
# regions = [
#   %{name: "WESTERN", code: "code"},
#   %{name: "CENTRAL", code: "code"},
#   %{name: "GREATER ACCRA", code: "code"},
#   %{name: "VOLTA", code: "code"},
#   %{name: "EASTERN", code: "code"},
#   %{name: "ASHANTI", code: "code"},
#   %{name: "BRONG AHAFO", code: "code"},
#   %{name: "NORTHERN", code: "code"},
#   %{name: "UPPER EAST", code: "code"},
#   %{name: "UPPER WEST", code: "code"}
# ]
# Repo.truncate(Location.Region)
# Repo.truncate(Location.District)
# Enum.each(regions, fn region ->  
#   {:ok, region} = Location.create_region(region)
#   _seed_districts_for.(region)
# end)

# seed pages
Repo.truncate(Accounts.Action)
Repo.truncate(Accounts.Gate)
Repo.truncate(Accounts.Entity)
Repo.truncate(Accounts.Role)
Repo.truncate(Accounts.Policy)
actions = ["add", "edit", "delete", "view", "download", "export", "deploy", "upload", 
  "restart", "change password", "power off", "start", "stop"]
Enum.each(actions, fn action -> Accounts.create_action(%{name: action}) end)

pages = [
  %{
    gate: "dashboard", 
    entities: [
      %{name: "dashboard", actions: ["view"]}
    ]
  }, 
  %{
    gate: "users", 
    entities: [
      %{name: "user", actions: ["add", "edit", "delete"]}
    ]
  }, 
  %{
    gate: "roles", 
    entities: [
      %{name: "role", actions: ["add", "edit", "delete"]},
      %{name: "policy", actions: ["add", "edit", "delete"]},
    ]
  }, 
  %{
    gate: "settings", 
    entities: [
      %{name: "region", actions: ["add", "edit", "delete"]},
      %{name: "district", actions: ["add", "edit", "delete"]},
      %{name: "printer", actions: ["add", "edit", "delete"]},
      %{name: "application", actions: ["add", "edit", "delete"]},
      %{name: "service", actions: ["add", "edit", "delete"]},
      %{name: "network", actions: ["add", "edit", "delete"]},
    ]
  }, 
  %{gate: "logs", entities: [%{name: "log", actions: ["export"]}]}, 
  %{
    gate: "centers", 
    entities: [
      %{name: "center", actions: ["add", "delete", "edit", "deploy"]}
    ]
  }, 
  %{gate: "map", entities: [%{name: "map", actions: ["view"]}]}, 
  %{
    gate: "consumables", 
    entities: [
      %{name: "blank card transaction", actions: ["add"]},
      %{name: "ribbon transaction", actions: ["add"]},
      %{name: "laminate transaction", actions: ["add"]},
      %{name: "receipt paper roll transaction", actions: ["add"]}
    ]
  }, 
  %{
    gate: "machines", 
    entities: [
      %{name: "machine", actions: ["restart", "power off", "change password"]},
      %{name: "application", actions: ["start", "stop"]},
      %{name: "service", actions: ["start", "stop"]}
    ]
  }, 
  %{gate: "reports", entities: []}
]

Enum.each(pages, fn page ->  
  {:ok, %{id: gate_id}} = Accounts.create_gate(%{name: page.gate})
  Enum.each(page.entities, fn entity ->  
    actions = Enum.map(entity.actions, fn name ->  
      %Accounts.Action{id: id} = action = Accounts.get_action_by_name!(name)
      id
    end)
    {:ok, %{id: entity_id}} = Accounts.create_entity(%{name: entity.name, gate_id: gate_id, actions: actions})
  end)
end)

if Mix.env() in [:dev, :test] do

  # seed applications | test purpose only
  Repo.truncate(Settings.Application)
  Enum.each([
    %{name: "Application", display: "Application Display Name",
      path: ~S"C:\Program Files (x86)\Application\application.exe"}], 
      fn app -> {:ok, _} = Settings.create_application(app) end)

  # seed services | test purpose only
  Repo.truncate(Settings.Service)
  Enum.each([
    %{name: "Service", display: "Service Display Name",
      path: ~S"C:\Program Files (x86)\Service\service.exe"}], 
      fn service -> {:ok, _} = Settings.create_service(service) end)

  #seed centers | test purpose only

end