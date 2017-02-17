defmodule LitmusTest.Solution do
  use LitmusTest.Web, :model

  schema "solutions" do
    field :answer, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:answer])
    |> validate_required([:answer])
  end
end
