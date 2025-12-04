defmodule MyappWeb.DoctorLive.Show do
  use MyappWeb, :live_view

  alias Myapp.Doctors

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Doctor {@doctor.id}
        <:subtitle>This is a doctor record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/doctors"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/doctors/#{@doctor}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit doctor
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Name">{@doctor.name}</:item>
        <:item title="Email">{@doctor.email}</:item>
        <:item title="Image">{@doctor.image}</:item>
        <:item title="Specialization">{@doctor.specialization}</:item>
        <:item title="Age">{@doctor.age}</:item>
        <:item title="Years of experience">{@doctor.years_of_experience}</:item>
        <:item title="Degrees">{@doctor.degrees}</:item>
        <:item title="Rating">{@doctor.rating}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Doctor")
     |> assign(:doctor, Doctors.get_doctor!(id))}
  end
end
