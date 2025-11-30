defmodule MyappWeb.DataController do
  use MyappWeb, :controller

  def ping(%{ products: products}=conn) do

    data = products
    json(conn, data)
  end
end
