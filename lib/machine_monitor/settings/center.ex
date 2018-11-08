defmodule MachineMonitor.Settings.Center do
  use Ecto.Schema
  import Ecto.Changeset


  schema "centers" do
    field :code, :string
    field :name, :string
    field :status, :integer, default: 0

    embeds_one :location, MachineMonitor.Settings.Center.Location, on_replace: :update
    embeds_one :contact, MachineMonitor.Settings.Center.Contact, on_replace: :update
    embeds_one :recomendation, MachineMonitor.Settings.Center.Recomendation, on_replace: :update

    has_many :deployments, MachineMonitor.Settings.Deployment 

    timestamps()
  end

  @doc false
  def changeset(center, attrs) do
    center
    |> cast(attrs, [:code, :name, :status])
    |> cast_embed(:location)
    |> cast_embed(:contact)
    |> cast_embed(:recomendation)
    |> validate_required([:code, :name])
  end
end


defmodule MachineMonitor.Settings.Center.Location do
  use Ecto.Schema
  import Ecto.Changeset


  embedded_schema do
    field :ghana_post_gps, :string
    field :longitude, :float
    field :latitude, :float
    field :sketch, :string
    field :radius, :integer
    field :region_id, :integer
    field :district_id, :integer
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:ghana_post_gps, :longitude, :latitude, :sketch, :radius, :region_id, :district_id])
    # |> validate_required([:ghana_post_gps, :longitude, :latitude, :sketch, :radius])
  end
end

defmodule MachineMonitor.Settings.Center.Contact do
  use Ecto.Schema
  import Ecto.Changeset


  embedded_schema do
    field :name, :string
    field :phone, :string
  end

  @doc false
  def changeset(contact, attrs) do
    contact
    |> cast(attrs, [:name, :phone])
    # |> validate_required([:name, :phone])
  end
end

defmodule MachineMonitor.Settings.Center.Recomendation do
  use Ecto.Schema
  import Ecto.Changeset


  embedded_schema do
    field :preferred_network, :string
    field :backup_network, :string
    field :recomended, :boolean
  end

  @doc false
  def changeset(recomendation, attrs) do
    recomendation
    |> cast(attrs, [:preferred_network, :backup_network, :recomended])
    # |> validate_required([:preferred_network, :backup_network, :recomended])
  end
end
