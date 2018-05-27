defmodule GenerateReadme do
  def generate do
    "README.md.eex"
    |> File.read!()
    |> EEx.eval_string(bar: "baz")
    |> IO.inspect()
  end

  def company_list do
    "companies.json"
    |> File.read!()
    |> Jason.decode!()
    |> IO.inspect()
  end
end

# GenerateReadme.generate()
GenerateReadme.company_list()
