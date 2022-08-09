defmodule CodingApe.Schema.Property do
  @type t :: %{
          name: String.t(),
          type: String.t(),
          required: boolean()
        }

  defstruct [
    :name,
    :type,
    required: false
  ]

  def new(attrs) do
    struct!(__MODULE__, attrs)
  end
end
