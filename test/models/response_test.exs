defmodule LitmusTest.ResponseTest do
  use LitmusTest.ModelCase

  alias LitmusTest.Response

  @valid_attrs %{email: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Response.changeset(%Response{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Response.changeset(%Response{}, @invalid_attrs)
    refute changeset.valid?
  end
end
