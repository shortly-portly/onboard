defmodule Onboard.Templates.Template do
  use Ecto.Schema
  import Ecto.Changeset

  schema "templates" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(template, attrs) do
    template
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
