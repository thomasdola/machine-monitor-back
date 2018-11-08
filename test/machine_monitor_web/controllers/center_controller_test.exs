defmodule MachineMonitorWeb.CenterControllerTest do
    use MachineMonitorWeb.ConnCase

    alias MachineMonitor.Settings

    @test_sketch_path Path.expand("test/fixtures/sketch.jpg")
    @test_centers_sheet Path.expand("test/fixtures/centers.xlsx")

    @web_attrs %{
        name: "some name",
        code: "some code",

        ghana_post_gps: "some gps",
        longitude: 0.55555,
        latitude: 0.5555,
        sketch: %Plug.Upload{path: @test_sketch_path, filename: Path.basename(@test_sketch_path)},

        contact_name: "some name",
        contact_phone: "some phone",

        preferred_network: "some network",
        backup_network: "some network",
        recomended: true
    }

    @center_contact %{
        name: "some name",
        phone: "some phone"
    }
    @center_recomendation %{
        preferred_network: "pr net",
        backup_network: "bc net",
        recomended: true
    }
    @center_location %{
        ghana_post_gps: "some gps",
        longitude: 0.55555,
        latitude: 0.5555,
        sketch: @test_sketch_path
    }

    @valid_attrs %{code: "some code", name: "some name", location: @center_location, 
    contact: @center_contact, recomendation: @center_recomendation}


    def center_fixture(attrs \\ %{}) do
        {:ok, center} =
          attrs
          |> Enum.into(@valid_attrs)
          |> Settings.create_center()
  
        center
    end

    test "GET / list all centers", %{conn: conn} do
        center_fixture()
        conn = get(conn, center_path(conn, :list))
        assert json_response(conn, 200)
    end

    test "GET / list all centers for map", %{conn: conn} do
        center_fixture()
        conn = get(conn, center_path(conn, :list), %{map: true})
        assert json_response(conn, 200)
    end

    test "GET / filter list centers", %{conn: conn} do
        center_fixture()
        params = %{filter: "region|3"}
        conn = get(conn, center_path(conn, :list), params)
        assert json_response(conn, 200)
    end

    test "POST / create new center", %{conn: conn} do
        conn = post(conn, center_path(conn, :add), @web_attrs)
        assert json_response(conn, 200)
    end

    test "POST / create new centers from sheet uploaded", %{conn: conn} do
        conn = post(conn, center_path(conn, :add), %{sheet: %Plug.Upload{path: @test_centers_sheet}})
        assert json_response(conn, 200)
    end

    test "PUT /:id update a center", %{conn: conn} do
        %{id: id} = center_fixture()
        conn = put(conn, center_path(conn, :update, id), @web_attrs)
        assert json_response(conn, 200)
    end

    test "PUT /:id update a center with a deployment", %{conn: conn} do
        %{id: id} = center_fixture()
        {:ok, %{id: printer_id}} = MachineMonitor.Settings.create_printer(%{laminator: "some laminator", serial: "some serial"})
        printers = ["#{printer_id}"]
        {:ok, %{id: machine_id}} = MachineMonitor.Accounts.create_machine(%{name: "some name", password: "some password"})
        machines = ["#{machine_id}"]
        date = DateTime.utc_now() |> DateTime.to_unix()
        data = %{"deployment" => "1", "center_id" => id, "status" => 1, 
            "start_date" => "#{date}", "end_date" => "#{date}", "printers" => printers, "machines" => machines}

        IO.inspect {:test_deployment, data, printer_id, machine_id}
        conn = put(conn, center_path(conn, :update, id), data)
        assert json_response(conn, 200)

        conn = get(conn, center_path(conn, :single, id))
        assert json_response(conn, 200)
    end

    test "GET /:id returns a single center", %{conn: conn} do
        %{id: id} = center_fixture()
        conn = get(conn, center_path(conn, :single, id))
        assert json_response(conn, 200)
    end

    test "DELETE /:id deletes a single center", %{conn: conn} do
        %{id: id} = center_fixture()
        conn = get(conn, center_path(conn, :delete, id))
        assert json_response(conn, 200)
    end
end