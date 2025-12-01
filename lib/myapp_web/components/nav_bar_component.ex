# lib/my_app_web/components/nav_components.ex
defmodule MyappWeb.NavComponents do
  use MyappWeb, :html
  def navbar(assigns) do
    ~H"""
    <nav class="bg-gray-800 p-4">
      <div class="container mx-auto flex justify-between items-center">
        <.link navigate={~p"/"} class="text-white text-lg font-bold">
          My Phoenix App

        </.link>
        <div>
           <.link navigate={~p"/products"} class="text-gray-300 hover:text-white px-3 py-2 rounded-md text-sm font-medium">
            Products
          </.link>

        </div>
      </div>
    </nav>
    """
  end
end
