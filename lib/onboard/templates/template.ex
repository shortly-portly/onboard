defmodule Onboard.Templates.Template do
  use Ecto.Schema
  import Ecto.Changeset

  schema "templates" do
    field :name, :string

    many_to_many :documents, Onboard.Documents.Document, join_through: Onboard.TemplateDoc

    timestamps()
  end

  @doc false
  def changeset(template, attrs) do
    template
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> cast_assoc(:documents)
  end
end
