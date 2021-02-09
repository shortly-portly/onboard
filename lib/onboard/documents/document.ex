defmodule Onboard.Documents.Document do
  use Ecto.Schema
  import Ecto.Changeset

  schema "documents" do
    field :name, :string

    many_to_many :templates, Onboard.Templates.Template, join_through: Onboard.TemplateDoc
    timestamps()
  end

  @doc false
  def changeset(document, attrs) do
    document
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
