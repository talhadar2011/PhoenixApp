defmodule Myapp.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset
 @derive {Jason.Encoder, only: [:id, :name, :slug, :console, :inserted_at, :updated_at]}
  schema "products" do
    field :name, :string
    field :slug, :string
    field :console, Ecto.Enum, values: [:pc, :xbox, :playstation]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name,  :console])
    |> validate_required([:name,  :console])
    |>  generate_slug()
    |> unique_constraint(:slug)
  end
  defp generate_slug(changeset) do
    slug = changeset.changes.name
    |> String.downcase()
    |> String.replace(" ", "-")

    put_change(changeset, :slug, slug)

  end
end
