defmodule MyappWeb.DoctorLive.Form do
  use MyappWeb, :live_view

  alias Myapp.Doctors
  alias Myapp.Doctors.Doctor

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage doctor records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="doctor-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:email]} type="text" label="Email" />
        <.input field={@form[:image]} type="text" label="Image" />
        <.input field={@form[:specialization]} type="text" label="Specialization" />
        <.input field={@form[:age]} type="number" label="Age" />
        <.input field={@form[:years_of_experience]} type="number" label="Years of experience" />
        <.input
          field={@form[:degrees]}
          type="select"
          multiple
          label="Degrees"
          options={[{"Option 1", "option1"}, {"Option 2", "option2"}]}
        />
        <.input field={@form[:rating]} type="text" label="Rating" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Doctor</.button>
          <.button navigate={return_path(@return_to, @doctor)}>Cancel</.button>
        </footer>
      </.form>
    </Layouts.app>
    """
  end

  @impl true
  def mount(params, _session, socket) do
    {:ok,
     socket
     |> assign(:return_to, return_to(params["return_to"]))
     |> apply_action(socket.assigns.live_action, params)}
  end

  defp return_to("show"), do: "show"
  defp return_to(_), do: "index"

  defp apply_action(socket, :edit, %{"id" => id}) do
    doctor = Doctors.get_doctor!(id)

    socket
    |> assign(:page_title, "Edit Doctor")
    |> assign(:doctor, doctor)
    |> assign(:form, to_form(Doctors.change_doctor(doctor)))
  end

  defp apply_action(socket, :new, _params) do
    doctor = %Doctor{}

    socket
    |> assign(:page_title, "New Doctor")
    |> assign(:doctor, doctor)
    |> assign(:form, to_form(Doctors.change_doctor(doctor)))
  end

  @impl true
  def handle_event("validate", %{"doctor" => doctor_params}, socket) do
    changeset = Doctors.change_doctor(socket.assigns.doctor, doctor_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"doctor" => doctor_params}, socket) do
    save_doctor(socket, socket.assigns.live_action, doctor_params)
  end

  defp save_doctor(socket, :edit, doctor_params) do
    case Doctors.update_doctor(socket.assigns.doctor, doctor_params) do
      {:ok, doctor} ->
        {:noreply,
         socket
         |> put_flash(:info, "Doctor updated successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, doctor))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_doctor(socket, :new, doctor_params) do
    case Doctors.create_doctor(doctor_params) do
      {:ok, doctor} ->
        {:noreply,
         socket
         |> put_flash(:info, "Doctor created successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, doctor))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path("index", _doctor), do: ~p"/doctors"
  defp return_path("show", doctor), do: ~p"/doctors/#{doctor}"
end
