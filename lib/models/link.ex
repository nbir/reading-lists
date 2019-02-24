defmodule ReadingLists.Models.Link do
  use Ecto.Schema
  import Ecto.Changeset
  alias ReadingLists.Models.List

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "links" do
    field :is_starred, :boolean, default: false
    field :title, :string
    field :url, :string

    timestamps(type: :utc_datetime)

    belongs_to :list, List
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:url, :title, :is_starred, :list_id])
    |> validate_required([:url, :title, :is_starred, :list_id])
  end
end
