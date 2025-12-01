defmodule MyappWeb.ProductsController do
  use MyappWeb, :controller
  alias Myapp.{Repo, Products.Product}

  def index(conn, _params) do
   products = Myapp.Products.list_products()
    conn
    |> assign(:products, products)
    |> render(:index)
  end

  def show(conn,%{"id"=>id} ) do
    product=Myapp.Products.get_product_by_Id(id)
    conn
    |> assign(:product, product)
    |>  render(:show,id: id)
  end
end
