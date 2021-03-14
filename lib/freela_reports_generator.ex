defmodule FreelaReportsGenerator do
  alias FreelaReportsGenerator.Parser

  @avaliable_names [
    "daniele",
    "mayk",
    "giuliano",
    "cleiton",
    "jakeliny",
    "joseph",
    "diego",
    "danilo",
    "rafael",
    "vinicius"
  ]

  @avaliable_months [
    "janeiro",
    "fevereiro",
    "março",
    "abril",
    "maio",
    "junho",
    "julho",
    "agosto",
    "setembro",
    "outubro",
    "novembro",
    "dezembro"
  ]

  @avaliable_years [
    "2016",
    "2017",
    "2018",
    "2019",
    "2020"
  ]

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(report_acc(), fn line, report -> sum_values(line, report) end)
  end

  def build_from_many(filenames) when not is_list(filenames) do
    {:error, "Please provide a list of strings"}
  end

  def build_from_many(filenames) do
    result =
      filenames
      |> Task.async_stream(&build/1)
      |> Enum.reduce(report_acc(), fn {:ok, result}, report -> sum_reports(report, result) end)

    {:ok, result}
  end

  defp sum_values([name, hours, _day, month, year], %{
         "all_hours" => all_hours,
         "hours_per_month" => hours_per_month,
         "hours_per_year" => hours_per_year
       }) do
    month = Enum.at(@avaliable_months, month - 1)
    all_hours = Map.put(all_hours, name, all_hours[name] + hours)

    hours_per_month =
      Map.put(hours_per_month, name, %{
        hours_per_month[name]
        | month => hours_per_month[name][month] + hours
      })

    hours_per_year =
      Map.put(hours_per_year, name, %{
        hours_per_year[name]
        | year => hours_per_year[name][year] + hours
      })

    build_report(all_hours, hours_per_month, hours_per_year)
  end

  defp sum_reports(
         %{
           "all_hours" => all_hours_1,
           "hours_per_month" => hours_per_month_1,
           "hours_per_year" => hours_per_year_1
         },
         %{
           "all_hours" => all_hours_2,
           "hours_per_month" => hours_per_month_2,
           "hours_per_year" => hours_per_year_2
         }
       ) do
    all_hours = merge_maps(all_hours_1, all_hours_2)
    hours_per_month = merge_maps(hours_per_month_1, hours_per_month_2)
    hours_per_year = merge_maps(hours_per_year_1, hours_per_year_2)

    build_report(all_hours, hours_per_month, hours_per_year)
  end

  defp merge_maps(map_1, map_2) do
    Map.merge(map_1, map_2, fn _key, item_1, item_2 -> merge_values(item_1, item_2) end)
  end

  defp merge_values(item_1, item_2) when is_map(item_1) and is_map(item_2) do
    Map.merge(item_1, item_2, fn _key, value_1, value_2 -> value_1 + value_2 end)
  end

  defp merge_values(item_1, item_2) do
    item_1 + item_2
  end

  defp report_acc do
    all_hours = Enum.into(@avaliable_names, %{}, &{String.downcase(&1), 0})
    months = Enum.into(@avaliable_months, %{}, &{String.downcase(&1), 0})
    years = Enum.into(@avaliable_years, %{}, &{String.downcase(&1), 0})
    hours_per_month = Enum.into(@avaliable_names, %{}, &{String.downcase(&1), months})
    hours_per_year = Enum.into(@avaliable_names, %{}, &{String.downcase(&1), years})

    build_report(all_hours, hours_per_month, hours_per_year)
  end

  defp build_report(all_hours, hours_per_month, hours_per_year) do
    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
  end
end
