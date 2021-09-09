defmodule Lenovo.Repo.Migrations.PostBelongsToUser do
  use Ecto.Migration

  def change do
    alter table(:post) do
      add :user_id, references(:users)
    end

  end
end
