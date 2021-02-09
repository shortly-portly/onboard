defmodule Onboard.TemplateDoc do
  use Ecto.Schema

  import Ecto.Changeset

  schema "template_documents" do
    belongs_to :template, Onboard.Templates.Template
    belongs_to :document, Onboard.Documents.Document

    timestamps()
  end

  def changeset(document_for_template, attrs) do
    document_for_template
    |> cast(attrs, [:template_id, :document_id])
    |> validate_required([:template_id, :document_id])
  end
end
