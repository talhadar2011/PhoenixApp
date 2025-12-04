defmodule Myapp.Doctors.Doctor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "doctors" do
    field :name, :string
    field :email, :string
    field :image, :string
    field :specialization, :string
    field :age, :integer
    field :years_of_experience, :integer
    field :degrees, {:array, :string}
    field :rating, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(doctor, attrs) do
    doctor
    |> cast(attrs, [:name, :email, :image, :specialization, :age, :years_of_experience, :degrees, :rating])
    |> validate_required([:name, :email, :image, :specialization, :age, :years_of_experience, :degrees, :rating])
  end
end
