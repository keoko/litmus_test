defmodule LitmusTest.InterviewControllerTest do
  use LitmusTest.ConnCase

  alias LitmusTest.Interview
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, interview_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing interviews"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, interview_path(conn, :new)
    assert html_response(conn, 200) =~ "New interview"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, interview_path(conn, :create), interview: @valid_attrs
    assert redirected_to(conn) == interview_path(conn, :index)
    assert Repo.get_by(Interview, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, interview_path(conn, :create), interview: @invalid_attrs
    assert html_response(conn, 200) =~ "New interview"
  end

  test "shows chosen resource", %{conn: conn} do
    interview = Repo.insert! %Interview{}
    conn = get conn, interview_path(conn, :show, interview)
    assert html_response(conn, 200) =~ "Show interview"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, interview_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    interview = Repo.insert! %Interview{}
    conn = get conn, interview_path(conn, :edit, interview)
    assert html_response(conn, 200) =~ "Edit interview"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    interview = Repo.insert! %Interview{}
    conn = put conn, interview_path(conn, :update, interview), interview: @valid_attrs
    assert redirected_to(conn) == interview_path(conn, :show, interview)
    assert Repo.get_by(Interview, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    interview = Repo.insert! %Interview{}
    conn = put conn, interview_path(conn, :update, interview), interview: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit interview"
  end

  test "deletes chosen resource", %{conn: conn} do
    interview = Repo.insert! %Interview{}
    conn = delete conn, interview_path(conn, :delete, interview)
    assert redirected_to(conn) == interview_path(conn, :index)
    refute Repo.get(Interview, interview.id)
  end
end
