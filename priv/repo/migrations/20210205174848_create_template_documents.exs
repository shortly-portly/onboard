defmodule Onboard.Repo.Migrations.CreateTemplateDocuments do
  use Ecto.Migration

  def change do
    create table(:template_documents) do

      add :template_id, references(:templates, on_delete: :delete_all)
      add :document_id, references(:documents, on_delete: :delete_all)

      timestamps()
    end

  end
end
