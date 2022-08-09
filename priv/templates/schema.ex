defmodule <%= inspect schema.module %> do
  @moduledoc """
  <%= schema.description %>
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias <%= inspect schema.module %>

  embedded_schema do
<%= CodingApe.Schema.format_fields_for_schema(schema) %>
  end
end
