defmodule Myapp.DoctorsTest do
  use Myapp.DataCase

  alias Myapp.Doctors

  describe "doctors" do
    alias Myapp.Doctors.Doctor

    import Myapp.DoctorsFixtures

    @invalid_attrs %{"\\": nil}

    test "list_doctors/0 returns all doctors" do
      doctor = doctor_fixture()
      assert Doctors.list_doctors() == [doctor]
    end

    test "get_doctor!/1 returns the doctor with given id" do
      doctor = doctor_fixture()
      assert Doctors.get_doctor!(doctor.id) == doctor
    end

    test "create_doctor/1 with valid data creates a doctor" do
      valid_attrs = %{"\\": "some \\"}

      assert {:ok, %Doctor{} = doctor} = Doctors.create_doctor(valid_attrs)
      assert doctor.\ == "some \\"
    end

    test "create_doctor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Doctors.create_doctor(@invalid_attrs)
    end

    test "update_doctor/2 with valid data updates the doctor" do
      doctor = doctor_fixture()
      update_attrs = %{"\\": "some updated \\"}

      assert {:ok, %Doctor{} = doctor} = Doctors.update_doctor(doctor, update_attrs)
      assert doctor.\ == "some updated \\"
    end

    test "update_doctor/2 with invalid data returns error changeset" do
      doctor = doctor_fixture()
      assert {:error, %Ecto.Changeset{}} = Doctors.update_doctor(doctor, @invalid_attrs)
      assert doctor == Doctors.get_doctor!(doctor.id)
    end

    test "delete_doctor/1 deletes the doctor" do
      doctor = doctor_fixture()
      assert {:ok, %Doctor{}} = Doctors.delete_doctor(doctor)
      assert_raise Ecto.NoResultsError, fn -> Doctors.get_doctor!(doctor.id) end
    end

    test "change_doctor/1 returns a doctor changeset" do
      doctor = doctor_fixture()
      assert %Ecto.Changeset{} = Doctors.change_doctor(doctor)
    end
  end

  describe "doctors" do
    alias Myapp.Doctors.Doctor

    import Myapp.DoctorsFixtures

    @invalid_attrs %{name: nil, image: nil, email: nil, specialization: nil, age: nil, years_of_experience: nil, degrees: nil, rating: nil}

    test "list_doctors/0 returns all doctors" do
      doctor = doctor_fixture()
      assert Doctors.list_doctors() == [doctor]
    end

    test "get_doctor!/1 returns the doctor with given id" do
      doctor = doctor_fixture()
      assert Doctors.get_doctor!(doctor.id) == doctor
    end

    test "create_doctor/1 with valid data creates a doctor" do
      valid_attrs = %{name: "some name", image: "some image", email: "some email", specialization: "some specialization", age: 42, years_of_experience: 42, degrees: ["option1", "option2"], rating: "some rating"}

      assert {:ok, %Doctor{} = doctor} = Doctors.create_doctor(valid_attrs)
      assert doctor.name == "some name"
      assert doctor.image == "some image"
      assert doctor.email == "some email"
      assert doctor.specialization == "some specialization"
      assert doctor.age == 42
      assert doctor.years_of_experience == 42
      assert doctor.degrees == ["option1", "option2"]
      assert doctor.rating == "some rating"
    end

    test "create_doctor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Doctors.create_doctor(@invalid_attrs)
    end

    test "update_doctor/2 with valid data updates the doctor" do
      doctor = doctor_fixture()
      update_attrs = %{name: "some updated name", image: "some updated image", email: "some updated email", specialization: "some updated specialization", age: 43, years_of_experience: 43, degrees: ["option1"], rating: "some updated rating"}

      assert {:ok, %Doctor{} = doctor} = Doctors.update_doctor(doctor, update_attrs)
      assert doctor.name == "some updated name"
      assert doctor.image == "some updated image"
      assert doctor.email == "some updated email"
      assert doctor.specialization == "some updated specialization"
      assert doctor.age == 43
      assert doctor.years_of_experience == 43
      assert doctor.degrees == ["option1"]
      assert doctor.rating == "some updated rating"
    end

    test "update_doctor/2 with invalid data returns error changeset" do
      doctor = doctor_fixture()
      assert {:error, %Ecto.Changeset{}} = Doctors.update_doctor(doctor, @invalid_attrs)
      assert doctor == Doctors.get_doctor!(doctor.id)
    end

    test "delete_doctor/1 deletes the doctor" do
      doctor = doctor_fixture()
      assert {:ok, %Doctor{}} = Doctors.delete_doctor(doctor)
      assert_raise Ecto.NoResultsError, fn -> Doctors.get_doctor!(doctor.id) end
    end

    test "change_doctor/1 returns a doctor changeset" do
      doctor = doctor_fixture()
      assert %Ecto.Changeset{} = Doctors.change_doctor(doctor)
    end
  end
end
