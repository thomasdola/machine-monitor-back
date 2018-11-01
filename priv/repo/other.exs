# if Application.get_env(:machine_monitor, :env) in [:dev, :test] do

#   # seed applications | test purpose only
#   Repo.truncate(Settings.Application)
#   Enum.each([
#     %{name: "Application", display: "Application Display Name",
#       path: ~S"C:\Program Files (x86)\Application\application.exe"}], 
#       fn app -> {:ok, _} = Settings.create_application(app) end)

#   # seed services | test purpose only
#   Repo.truncate(Settings.Service)
#   Enum.each([
#     %{name: "Service", display: "Service Display Name",
#       path: ~S"C:\Program Files (x86)\Service\service.exe"}], 
#       fn service -> {:ok, _} = Settings.create_service(service) end)

#   #seed centers | test purpose only

# end