defmodule Mix.Tasks.Ape.Gen.Client do
  use Mix.Task

  alias CodingApe.Schema

  def run(_) do
    schema =
      Schema.new(
        "Pet",
        "A pet for sale in the pet store",
        [
          %{name: "id", type: "integer"},
          %{name: "name", type: "string"},
          %{name: "status", type: "string"}
        ]
      )

    copy_from(
      [".", :coding_ape],
      "priv/templates",
      [schema: schema],
      files_to_be_generated(schema)
    )
  end

  def files_to_be_generated(_schema) do
    [{:eex, "schema.ex", "generated_schema.ex"}]
  end

  defp copy_from(apps, source_dir, binding, files) do
    roots = Enum.map(apps, &to_app_source(&1, source_dir))

    for {format, source_file_path, target} <- files do
      source =
        Enum.find_value(roots, fn root ->
          source = Path.join(root, source_file_path)
          if File.exists?(source), do: source
        end) || raise "could not find #{source_file_path} in any of the sources"

      case format do
        :eex -> Mix.Generator.create_file(target, EEx.eval_file(source, binding))
      end
    end
  end

  defp to_app_source(path, source_dir) when is_binary(path),
    do: Path.join(path, source_dir)

  defp to_app_source(app, source_dir) when is_atom(app),
    do: Application.app_dir(app, source_dir)
end
