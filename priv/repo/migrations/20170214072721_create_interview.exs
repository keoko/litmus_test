defmodule LitmusTest.Repo.Migrations.CreateInterview do
  use Ecto.Migration

  def change do
    create table(:interviews) do
      add :name, :string

      timestamps()
    end

  end
end
