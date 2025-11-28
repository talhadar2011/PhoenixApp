defmodule MyappWeb.ProductsController do
  use MyappWeb, :controller
  def products(conn, _params) do
    render(conn, :products)
  end
  def productsWithID(conn,%{"id"=>id} ) do
    render(conn, :productWithId,id: id)
  end
end
