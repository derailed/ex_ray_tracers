defmodule Traceme.Store.Castle do
  use Traceme.Record

  @moduledoc """
  Handles castles persistent records
  """

  schema "castles" do
    field :name       , :string
    field :description, :string
    field :avatar     , :string, virtual: true

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  @spec changeset(Ecto.Schema.t, %{required(atom) => any}) :: Ecto.Schema.t
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description])
    |> validate_required([:name, :description])
  end

  @doc """
  Add a new castle given a name and a descriptiom
  """
  @spec add(name: String.t, desc: String.t) :: Ecto.Schema.t | no_return
  def add(name: name, desc: desc) do
    %__MODULE__{
      name:        name,
      description: desc
    }
    |> Repo.insert!
  end
end
