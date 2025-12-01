defmodule Myapp.Products do
  alias Myapp.{Repo, Products.Product}
  import Ecto.Query

  def list_products do
    Repo.all(Product)
  end
  def get_product_by_Id(id) do
     Repo.get_by(Product, id: id)
  end
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end
  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end
end
