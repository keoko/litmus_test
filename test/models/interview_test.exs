defmodule LitmusTest.InterviewTest do
  use LitmusTest.ModelCase

  alias LitmusTest.Interview

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Interview.changeset(%Interview{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Interview.changeset(%Interview{}, @invalid_attrs)
    refute changeset.valid?
  end
end
