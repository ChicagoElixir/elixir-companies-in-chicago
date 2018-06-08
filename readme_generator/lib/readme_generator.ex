defmodule ReadmeGenerator do
  @sort_by "company_name"

  def generate_readme do
    template()
    |> EEx.eval_string(companies: company_list())
  end

  def save(contents, filename \\ "../README.md") do
    File.write!(filename, contents)
  end

  defp company_list do
    "../companies.json"
    |> File.read!()
    |> Jason.decode!()
    |> Map.get("companies")
    |> Stream.map(&inject_map_url/1)
    |> Enum.sort(&(&1[@sort_by] <= &2[@sort_by]))
  end

  defp inject_map_url(company) do
    address = Map.get(company, "address")
    query = URI.encode(address)
    url = "https://duckduckgo.com/?q=#{query}&ia=maps&iaxm=maps"
    Map.put(company, "map_url", url)
  end

  defp template do
    "templates/README.md.eex"
    |> File.read!()
  end
end
