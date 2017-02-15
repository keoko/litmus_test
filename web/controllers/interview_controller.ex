defmodule LitmusTest.InterviewController do
  require Logger
  use LitmusTest.Web, :controller

  alias LitmusTest.Interview

  def index(conn, _params) do
    interviews = Repo.all(Interview)
    render(conn, "index.html", interviews: interviews)
  end

  def new(conn, _params) do
    changeset = Interview.changeset(%Interview{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, _interview) do
    interview_params = %{name: random_string(10)}
    Logger.debug "params: #{inspect(interview_params)}"
    changeset = Interview.changeset(%Interview{}, interview_params)

    case Repo.insert(changeset) do
      {:ok, interview} ->
        conn
        |> redirect(to: interview_path(conn, :show, interview))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    interview = Repo.get!(Interview, id)
    render(conn, "show.html", interview: interview)
  end

  def edit(conn, %{"id" => id}) do
    interview = Repo.get!(Interview, id)
    changeset = Interview.changeset(interview)
    render(conn, "edit.html", interview: interview, changeset: changeset)
  end

  def update(conn, %{"id" => id, "interview" => interview_params}) do
    interview = Repo.get!(Interview, id)
    changeset = Interview.changeset(interview, interview_params)

    case Repo.update(changeset) do
      {:ok, interview} ->
        conn
        |> put_flash(:info, "Interview updated successfully.")
        |> redirect(to: interview_path(conn, :show, interview))
      {:error, changeset} ->
        render(conn, "edit.html", interview: interview, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    interview = Repo.get!(Interview, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(interview)

    conn
    |> put_flash(:info, "Interview deleted successfully.")
    |> redirect(to: interview_path(conn, :index))
  end

  def random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
  end

end
