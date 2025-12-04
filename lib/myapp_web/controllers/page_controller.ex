defmodule MyappWeb.PageController do
  use MyappWeb, :controller

  def home(conn, _params) do
    render(conn, :home )
  end
  def contact(conn, _params) do
    render(conn, :contact )
  end
  def about(conn, _params) do
    render(conn, :about )
  end
end
