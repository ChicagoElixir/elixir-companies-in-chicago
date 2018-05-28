defmodule Mix.Tasks.GenerateReadme do
  use Mix.Task

  @shortdoc "Generates a README.md with data from companies.json"
  def run(_) do
    ReadmeGenerator.generate_readme()
    |> ReadmeGenerator.save()
  end
end
