defmodule Myapp.Repo.Migrations.CreateDoctors do
  use Ecto.Migration

  def change do
    create table(:doctors) do
      add :name, :string
      add :email, :string
      add :image, :string
      add :specialization, :string
      add :age, :integer
      add :years_of_experience, :integer
      add :degrees, {:array, :string}
      add :rating, :string

      timestamps(type: :utc_datetime)
    end
  end
end
