defmodule MyappWeb.ProductsHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use MyappWeb, :html

  embed_templates "products_html/*"

end
