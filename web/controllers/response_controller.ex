defmodule LitmusTest.ResponseController do
  use LitmusTest.Web, :controller

  alias LitmusTest.Response
  alias LitmusTest.Interview

  def index(conn, %{"name" => name}) do
    query = from from i in LitmusTest.Interview, where: i.name == ^name
    interviews = LitmusTest.Repo.all(query)
    case interviews do
      [interview|_] ->
        changeset = Interview.changeset(interview)
        render(conn, "index.html", interview: interview, changeset: changeset)
      _ ->
        conn
        |> put_status(:not_found)
        |> render(LitmusTest.ErrorView, "404.html")
    end
    responses = Repo.all(Response)
    render(conn, "index.html", responses: responses)
  end

  def new(conn, _params) do
    changeset = Response.changeset(%Response{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"response" => response_params}) do
    changeset = Response.changeset(%Response{}, response_params)

    case Repo.insert(changeset) do
      {:ok, _response} ->
        conn
        |> put_flash(:info, "Response created successfully.")
        |> redirect(to: response_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    response = Repo.get!(Response, id)
    render(conn, "show.html", response: response)
  end

  def edit(conn, %{"id" => id}) do
    response = Repo.get!(Response, id)
    changeset = Response.changeset(response)
    render(conn, "edit.html", response: response, changeset: changeset)
  end

  def update(conn, %{"id" => id, "response" => response_params}) do
    response = Repo.get!(Response, id)
    changeset = Response.changeset(response, response_params)

    case Repo.update(changeset) do
      {:ok, response} ->
        conn
        |> put_flash(:info, "Response updated successfully.")
        |> redirect(to: response_path(conn, :show, response))
      {:error, changeset} ->
        render(conn, "edit.html", response: response, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    response = Repo.get!(Response, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(response)

    conn
    |> put_flash(:info, "Response deleted successfully.")
    |> redirect(to: response_path(conn, :index))
  end
end
