defmodule MyappWeb.DataController do
  use MyappWeb, :controller
  alias Myapp.Products

  def index(conn, _params) do
    products = Products.list_products()
    conn
    |>assign(:products, products)
    |>render(:index)
  end
end
