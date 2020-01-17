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
    |> Enum.sort(&(comparable_company_name(&1) <= comparable_company_name(&2)))
  end

  defp comparable_company_name(company) do
    company
    |> Map.get(@sort_by)
    |> String.downcase()
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
