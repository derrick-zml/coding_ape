defmodule CodingApe.Schema do
  alias CodingApe.Schema
  alias CodingApe.Schema.Property

  @type t :: %{
          module: String.t(),
          description: String.t(),
          properties: list(Property.t())
        }

  defstruct [
    :module,
    :description,
    properties: []
  ]

  def new(name, description, properties) do
    base = "CodingApe"

    %Schema{
      module: Module.concat([base, name]),
      description: description,
      properties: Enum.map(properties, &Property.new/1)
    }
  end

  def format_fields_for_schema(schema) do
    Enum.map_join(schema.properties, "\n", fn property ->
      "    field #{inspect(property.name)}, #{property.type}"
    end)
  end
end
