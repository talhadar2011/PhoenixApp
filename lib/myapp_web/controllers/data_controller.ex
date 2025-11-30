defmodule MyappWeb.DataController do
  use MyappWeb, :controller

  def ping(conn, _params) do
    data = [
      %{
        "id" => 1,
        "name" => "Product A"
      },
      %{
        "id" => 2,
        "name" => "Product B"
      },
      %{
        "id" => 3,
        "name" => "Product C"
      }
    ]

    # The json/2 function will encode this list of maps into a JSON array.
    json(conn, data)
  end
end
