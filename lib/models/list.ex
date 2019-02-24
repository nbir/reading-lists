defmodule ReadingLists.Models.List do
  use Ecto.Schema
  import Ecto.Changeset
  alias ReadingLists.Models.Link

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "lists" do
    field :is_starred, :boolean, default: false
    field :title, :string

    timestamps(type: :utc_datetime)

    has_many :links, Link
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:title, :is_starred])
    |> validate_required([:title, :is_starred])
  end
end
