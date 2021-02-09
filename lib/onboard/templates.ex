defmodule Onboard.Templates do
  @moduledoc """
  The Templates context.
  """

  import Ecto.Query, warn: false
  alias Onboard.Repo

  alias Onboard.Templates.Template
  alias Onboard.TemplateDoc

  @doc """
  Returns the list of templates.

  ## Examples

      iex> list_templates()
      [%Template{}, ...]

  """
  def list_templates do
    Template
    |> preload(:documents)
    |> Repo.all()
  end

  @doc """
  Gets a single template.

  Raises `Ecto.NoResultsError` if the Template does not exist.

  ## Examples

      iex> get_template!(123)
      %Template{}

      iex> get_template!(456)
      ** (Ecto.NoResultsError)

  """
  def get_template!(id) do
    Template
    |> preload(:documents)
    |> Repo.get!(id)
  end

  @doc """
  Creates a template.

  ## Examples

      iex> create_template(%{field: value})
      {:ok, %Template{}}

      iex> create_template(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_template(attrs \\ %{}) do
    %Template{}
    |> Template.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a template.

  ## Examples

      iex> update_template(template, %{field: new_value})
      {:ok, %Template{}}

      iex> update_template(template, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_template(%Template{} = template, attrs) do
    template
    |> Template.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a template.

  ## Examples

      iex> delete_template(template)
      {:ok, %Template{}}

      iex> delete_template(template)
      {:error, %Ecto.Changeset{}}

  """
  def delete_template(%Template{} = template) do
    Repo.delete(template)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking template changes.

  ## Examples

      iex> change_template(template)
      %Ecto.Changeset{data: %Template{}}

  """
  def change_template(%Template{} = template, attrs \\ %{}) do
    Template.changeset(template, attrs)
  end

  @doc """
  Add a document to the given template.
  This simply update the Template Document Link table.

  ## Examples

      iex> add_document_to_template(%{template_id: template_id, document_id: document_id})
      {:ok, %TemplateDoc{}}

      iex> create_template(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def add_document_to_template(attrs \\ %{}) do
    %TemplateDoc{}
    |> TemplateDoc.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Remove a document form the given template by deleting the entry from
  the Template Document link table.
  """
  def remove_document_from_template(template_id, document_id) do
    from(x in Onboard.TemplateDoc,
      where: x.template_id == ^template_id,
      where: x.document_id == ^document_id
    )
    |> Repo.delete_all()
  end
end
