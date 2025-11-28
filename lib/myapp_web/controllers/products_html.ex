defmodule MyappWeb.ProductsHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use MyappWeb, :html

  # embed_templates "products_html/*"
  def index (assigns) do
    ~H"""
    <h1>Products Page</h1>
     """
  end
end
