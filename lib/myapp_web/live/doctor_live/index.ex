defmodule MyappWeb.DoctorLive.Index do
  use MyappWeb, :live_view

  alias Myapp.Doctors

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Listing Doctors
        <:actions>
          <.button variant="primary" navigate={~p"/doctors/new"}>
            <.icon name="hero-plus" /> New Doctor
          </.button>
        </:actions>
      </.header>

      <.table
        id="doctors"
        rows={@streams.doctors}
        row_click={fn {_id, doctor} -> JS.navigate(~p"/doctors/#{doctor}") end}
      >
        <:col :let={{_id, doctor}} label="Name">{doctor.name}</:col>
        <:col :let={{_id, doctor}} label="Email">{doctor.email}</:col>
        <:col :let={{_id, doctor}} label="Image">{doctor.image}</:col>
        <:col :let={{_id, doctor}} label="Specialization">{doctor.specialization}</:col>
        <:col :let={{_id, doctor}} label="Age">{doctor.age}</:col>
        <:col :let={{_id, doctor}} label="Years of experience">{doctor.years_of_experience}</:col>
        <:col :let={{_id, doctor}} label="Degrees">{doctor.degrees}</:col>
        <:col :let={{_id, doctor}} label="Rating">{doctor.rating}</:col>
        <:action :let={{_id, doctor}}>
          <div class="sr-only">
            <.link navigate={~p"/doctors/#{doctor}"}>Show</.link>
          </div>
          <.link navigate={~p"/doctors/#{doctor}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, doctor}}>
          <.link
            phx-click={JS.push("delete", value: %{id: doctor.id}) |> hide("##{id}")}
            data-confirm="Are you sure?"
          >
            Delete
          </.link>
        </:action>
      </.table>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Listing Doctors")
     |> stream(:doctors, list_doctors())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    doctor = Doctors.get_doctor!(id)
    {:ok, _} = Doctors.delete_doctor(doctor)

    {:noreply, stream_delete(socket, :doctors, doctor)}
  end

  defp list_doctors() do
    Doctors.list_doctors()
  end
end
