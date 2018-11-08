defmodule MachineMonitor.LocationTest do
  use MachineMonitor.DataCase

  alias MachineMonitor.Location

  describe "regions" do
    alias MachineMonitor.Location.Region

    @valid_attrs %{code: "some code", name: "some name"}
    @update_attrs %{code: "some updated code", name: "some updated name"}
    @invalid_attrs %{code: nil, name: nil}

    def region_fixture(attrs \\ %{}) do
      {:ok, region} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Location.create_region()

      region
    end

    test "list_regions/0 returns all regions" do
      region = region_fixture()
      assert Location.list_regions() == [region]
    end

    test "get_region!/1 returns the region with given id" do
      region = region_fixture()
      assert Location.get_region!(region.id) == region
    end

    test "create_region/1 with valid data creates a region" do
      assert {:ok, %Region{} = region} = Location.create_region(@valid_attrs)
      assert region.code == "some code"
      assert region.name == "some name"
    end

    test "create_region/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Location.create_region(@invalid_attrs)
    end

    test "update_region/2 with valid data updates the region" do
      region = region_fixture()
      assert {:ok, region} = Location.update_region(region, @update_attrs)
      assert %Region{} = region
      assert region.code == "some updated code"
      assert region.name == "some updated name"
    end

    test "update_region/2 with invalid data returns error changeset" do
      region = region_fixture()
      assert {:error, %Ecto.Changeset{}} = Location.update_region(region, @invalid_attrs)
      assert region == Location.get_region!(region.id)
    end

    test "delete_region/1 deletes the region" do
      region = region_fixture()
      assert {:ok, %Region{}} = Location.delete_region(region)
      assert_raise Ecto.NoResultsError, fn -> Location.get_region!(region.id) end
    end

    test "change_region/1 returns a region changeset" do
      region = region_fixture()
      assert %Ecto.Changeset{} = Location.change_region(region)
    end
  end

  describe "district" do
    alias MachineMonitor.Location.District

    @valid_region_attrs %{code: "some region code", name: "some region name"}
    @valid_attrs %{code: "some code", name: "some name", region_id: nil}
    @update_attrs %{code: "some updated code", name: "some updated name"}
    @invalid_attrs %{code: nil, name: nil, region_id: nil}

    def district_fixture(attrs \\ %{}) do
      %{id: region_id} = region_fixture(@valid_region_attrs)
      {:ok, district} =
        attrs
        |> Enum.into(%{@valid_attrs | region_id: region_id})
        |> Location.create_district()

      district
    end

    # def region_fixture(attrs \\ %{}) do
    #   {:ok, region} =
    #     attrs
    #     |> Enum.into(@valid_region_attrs)
    #     |> Location.create_region()

    #   region
    # end

    test "list_district/0 returns all district" do
      district = district_fixture()
      assert Location.list_district() == [district]
    end

    test "get_district!/1 returns the district with given id" do
      district = district_fixture()
      assert Location.get_district!(district.id) == district
    end

    test "create_district/1 with valid data creates a district" do
      %{id: region_id} = region_fixture()
      assert {:ok, %District{} = district} = Location.create_district(%{@valid_attrs | region_id: region_id})
      assert district.code == "some code"
      assert district.name == "some name"
    end

    test "create_district/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Location.create_district(@invalid_attrs)
    end

    test "update_district/2 with valid data updates the district" do
      district = district_fixture()
      assert {:ok, district} = Location.update_district(district, @update_attrs)
      assert %District{} = district
      assert district.code == "some updated code"
      assert district.name == "some updated name"
    end

    test "update_district/2 with invalid data returns error changeset" do
      district = district_fixture()
      assert {:error, %Ecto.Changeset{}} = Location.update_district(district, @invalid_attrs)
      assert district == Location.get_district!(district.id)
    end

    test "delete_district/1 deletes the district" do
      district = district_fixture()
      assert {:ok, %District{}} = Location.delete_district(district)
      assert_raise Ecto.NoResultsError, fn -> Location.get_district!(district.id) end
    end

    test "change_district/1 returns a district changeset" do
      district = district_fixture()
      assert %Ecto.Changeset{} = Location.change_district(district)
    end
  end
end
