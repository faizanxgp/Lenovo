defmodule Lenovo.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:post) do
      add :header, :string
      add :body, :string

      timestamps()
    end

  end
end
