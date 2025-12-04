defmodule Myapp.DoctorsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Myapp.Doctors` context.
  """

  @doc """
  Generate a doctor.
  """
  def doctor_fixture(attrs \\ %{}) do
    {:ok, doctor} =
      attrs
      |> Enum.into(%{
        \: "some \\"
      })
      |> Myapp.Doctors.create_doctor()

    doctor
  end

  @doc """
  Generate a doctor.
  """
  def doctor_fixture(attrs \\ %{}) do
    {:ok, doctor} =
      attrs
      |> Enum.into(%{
        age: 42,
        degrees: ["option1", "option2"],
        email: "some email",
        image: "some image",
        name: "some name",
        rating: "some rating",
        specialization: "some specialization",
        years_of_experience: 42
      })
      |> Myapp.Doctors.create_doctor()

    doctor
  end
end
