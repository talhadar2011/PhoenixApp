defmodule MyappWeb.ProductsController do
  use MyappWeb, :controller

  @data [
    %{
      "id" => 1,
      "name" => "Product A",
      "description" => "This is Product A",
      "price" => 19.99
    },
    %{
      "id" => 2,
      "name" => "Product B",
      "description" => "This is Product B",
      "price" => 29.99
    },
    %{
      "id" => 3,
      "name" => "Product C",
      "description" => "This is Product C",
      "price" => 39.99
    }
  ]
  def index(conn, _params) do
    conn
    |> assign(:products, @data)
    |> render(:index)
  end

  def show(conn,%{"id"=>id} ) do
    conn
    |> assign(:product, Enum.find(@data, fn p -> Integer.to_string(p["id"]) == id end))
    |>  render(:show,id: id)
  end
end
