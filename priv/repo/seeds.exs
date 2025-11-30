# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Myapp.Repo.insert!(%Myapp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
# priv/repo/seeds.exs
# priv/repo/seeds.exs

# 1. Alias your Repo and Schema modules
alias Myapp.Repo
alias Myapp.Product # Uses the schema you provided

# 2. Define the product data using the correct Ecto.Enum values
products = [
  %{
    name: "Cyberpunk 2077",
    slug: "cyberpunk-2077",
    console: :pc # Must be the atom :pc
  },
  %{
    name: "Forza Horizon 5",
    slug: "forza-horizon-5",
    console: :xbox # Must be the atom :xbox
  },
  %{
    name: "The Last of Us Part II",
    slug: "the-last-of-us-2",
    console: :playstation # Must be the atom :playstation
  }
]

# 3. Insert the data into the database using the schema's changeset
Enum.each(products, fn attrs ->
  %Product{}
  |> Product.changeset(attrs)
  # Instead of using Repo.insert!, we will use a conditional insert
  # that checks if a product with the same slug already exists.
  |> case do
    %Ecto.Changeset{valid?: true} = changeset ->
      case Repo.insert(changeset) do
        {:ok, product} ->
          IO.puts("Seeded product: #{product.name}")
        {:error, failed_changeset} ->
          IO.puts("Failed to seed #{attrs.name}. Errors: #{inspect(failed_changeset.errors)}")
      end
    %Ecto.Changeset{valid?: false} = changeset ->
      IO.puts("Failed validation for #{attrs.name}. Errors: #{inspect(changeset.errors)}")
  end
end)
