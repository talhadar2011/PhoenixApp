defmodule MyappWeb.DataJSON do
  def index(assign) do
    %{ products: assign.products}
  end
end
