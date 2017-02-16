defmodule LitmusTest.Repo.Migrations.CreateResponse do
  use Ecto.Migration

  def change do
    create table(:responses) do
      add :name, :string
      add :email, :string

      timestamps()
    end

  end
end
