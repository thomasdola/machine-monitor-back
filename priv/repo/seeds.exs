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

MachineMonitor.Accounts.create_user!(
  %{email: "admin@admin.admin", name: "Mr Admin", password: "adminadmin"}
)

Enum.each([
  %{name: "EnrollmentStation", display: "Dermalog Enrollment Station",
    path: "C:\\Program Files (x86)\\DERMALOG\\EnrollmentStation\\EnrollmentStation.exe"},
  %{name: "Dermalog Card Issuing Station", display: "Dermalog Card Issuing Station",
    path: "C:\\Program Files (x86)\\DERMALOG\\Dermalog Card Issuing Station\\CardIssuingStation.exe"},
], fn app -> MachineMonitor.Settings.create_application(app) end)

Enum.each([
  %{name: "CardReaderService", display: "Dermalog Card Reader Service",
    path: "C:\\Program Files (x86)\\DERMALOG\\CardReaderService\\CardReaderServiceWrapper.exe"},
  %{name: "CodeMeter.exe", display: "CodeMeter Runtime Server",
    path: "C:\\Program Files (x86)\\CodeMeter\\Runtime\\bin\\CodeMeter.exe"},
], fn service -> MachineMonitor.Settings.create_service(service) end)
