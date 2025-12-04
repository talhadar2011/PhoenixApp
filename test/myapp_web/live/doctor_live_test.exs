defmodule MyappWeb.DoctorLiveTest do
  use MyappWeb.ConnCase

  import Phoenix.LiveViewTest
  import Myapp.DoctorsFixtures

  @create_attrs %{name: "some name", image: "some image", email: "some email", specialization: "some specialization", age: 42, years_of_experience: 42, degrees: ["option1", "option2"], rating: "some rating"}
  @update_attrs %{name: "some updated name", image: "some updated image", email: "some updated email", specialization: "some updated specialization", age: 43, years_of_experience: 43, degrees: ["option1"], rating: "some updated rating"}
  @invalid_attrs %{name: nil, image: nil, email: nil, specialization: nil, age: nil, years_of_experience: nil, degrees: [], rating: nil}
  defp create_doctor(_) do
    doctor = doctor_fixture()

    %{doctor: doctor}
  end

  describe "Index" do
    setup [:create_doctor]

    test "lists all doctors", %{conn: conn, doctor: doctor} do
      {:ok, _index_live, html} = live(conn, ~p"/doctors")

      assert html =~ "Listing Doctors"
      assert html =~ doctor.name
    end

    test "saves new doctor", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/doctors")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Doctor")
               |> render_click()
               |> follow_redirect(conn, ~p"/doctors/new")

      assert render(form_live) =~ "New Doctor"

      assert form_live
             |> form("#doctor-form", doctor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#doctor-form", doctor: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/doctors")

      html = render(index_live)
      assert html =~ "Doctor created successfully"
      assert html =~ "some name"
    end

    test "updates doctor in listing", %{conn: conn, doctor: doctor} do
      {:ok, index_live, _html} = live(conn, ~p"/doctors")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#doctors-#{doctor.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/doctors/#{doctor}/edit")

      assert render(form_live) =~ "Edit Doctor"

      assert form_live
             |> form("#doctor-form", doctor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#doctor-form", doctor: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/doctors")

      html = render(index_live)
      assert html =~ "Doctor updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes doctor in listing", %{conn: conn, doctor: doctor} do
      {:ok, index_live, _html} = live(conn, ~p"/doctors")

      assert index_live |> element("#doctors-#{doctor.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#doctors-#{doctor.id}")
    end
  end

  describe "Show" do
    setup [:create_doctor]

    test "displays doctor", %{conn: conn, doctor: doctor} do
      {:ok, _show_live, html} = live(conn, ~p"/doctors/#{doctor}")

      assert html =~ "Show Doctor"
      assert html =~ doctor.name
    end

    test "updates doctor and returns to show", %{conn: conn, doctor: doctor} do
      {:ok, show_live, _html} = live(conn, ~p"/doctors/#{doctor}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/doctors/#{doctor}/edit?return_to=show")

      assert render(form_live) =~ "Edit Doctor"

      assert form_live
             |> form("#doctor-form", doctor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#doctor-form", doctor: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/doctors/#{doctor}")

      html = render(show_live)
      assert html =~ "Doctor updated successfully"
      assert html =~ "some updated name"
    end
  end
end
