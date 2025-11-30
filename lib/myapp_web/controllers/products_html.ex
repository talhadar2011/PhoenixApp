defmodule MyappWeb.ProductsHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use MyappWeb, :html

  embed_templates "products_html/*"
  def product (assigns) do
    ~H"""
    <h1>Product Page</h1>
    <p>Welcome to the product page! Your current product is {@name}</p>
    """
  end
end
