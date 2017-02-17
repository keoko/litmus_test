defmodule LitmusTest.Repo.Migrations.CreateSolution do
  use Ecto.Migration

  def change do
    create table(:solutions) do
      add :answer, :text

      timestamps()
    end

  end
end
