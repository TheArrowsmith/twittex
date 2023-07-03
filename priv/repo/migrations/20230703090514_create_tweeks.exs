defmodule Twittex.Repo.Migrations.CreateTweeks do
  use Ecto.Migration

  def change do
    create table(:tweeks) do
      add :content, :text, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:tweeks, [:inserted_at, :user_id])
  end
end
