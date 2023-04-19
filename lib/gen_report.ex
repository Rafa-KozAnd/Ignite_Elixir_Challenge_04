defmodule FreelasReportsGenerator do
  alias FreelasReportsGenerator.Parser

  @users [
    "Daniele",
    "Mayk",
    "Giuliano",
    "Cleiton",
    "Jakeliny",
    "Joseph",
    "Diego",
    "Danilo",
    "Rafael",
    "Vinicius"
  ]

  @months_numbers %{
    "1" => "janeiro",
    "2" => "fevereiro",
    "3" => "março",
    "4" => "abril",
    "5" => "maio",
    "6" => "junho",
    "7" => "julho",
    "8" => "agosto",
    "9" => "setembro",
    "10" => "outubro",
    "11" => "novembro",
    "12" => "dezembro"
  }

  @months %{
    "janeiro" => 0,
    "fevereiro" => 0,
    "março" => 0,
    "abril" => 0,
    "maio" => 0,
    "junho" => 0,
    "julho" => 0,
    "agosto" => 0,
    "setembro" => 0,
    "outubro" => 0,
    "novembro" => 0,
    "dezembro" => 0
  }

  @years %{
    "2016" => 0,
    "2017" => 0,
    "2018" => 0,
    "2019" => 0,
    "2020" => 0
  }

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(report_acc(), fn line, report -> make_report(line, report) end)
  end

  def build_from_many(filenames) when not is_list(filenames) do
    {:error, "Please provide a list of strings."}
  end

  def build_from_many(filenames) do
    result =
      filenames
      |> Task.async_stream(&build/1)
      |> Enum.reduce(report_acc(), fn {:ok, result}, report ->
        make_many_reports(report, result)
      end)

    {:ok, result}
  end

  defp make_many_reports(
         %{
           "all_hours" => all_hours1,
           "hours_per_month" => hours_per_month1,
           "hours_per_years" => hours_per_years1
         },
         %{
           "all_hours" => all_hours2,
           "hours_per_month" => hours_per_month2,
           "hours_per_years" => hours_per_years2
         }
       ) do
    all_hours = merge_maps(all_hours1, all_hours2)
    hours_per_month = merge_maps(hours_per_month1, hours_per_month2)
    hours_per_years = merge_maps(hours_per_years1, hours_per_years2)

    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_years" => hours_per_years
    }
  end

  defp merge_maps(map1, map2) do
    Map.merge(map1, map2, fn _key, value1, value2 ->
      case is_map(value1) and is_map(value2) do
        true -> merge_maps(value1, value2)
        false -> value1 + value2
      end
    end)
  end

  defp make_report([name, hours, _day, month, year], report) do
    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_years" => hours_per_years
    } = report

    month = Map.get(@months_numbers, month)

    all_hours = Map.put(all_hours, name, all_hours[name] + hours)

    hours_per_month =
      Map.put(hours_per_month, name, increase_hour(hours_per_month, name, month, hours))

    hours_per_years =
      Map.put(hours_per_years, name, increase_hour(hours_per_years, name, year, hours))

    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_years" => hours_per_years
    }
  end

  defp increase_hour(map, name, key, hours) do
    %{
      map[name]
      | key => map[name][key] + hours
    }
  end

  defp report_acc do
    all_hours = Enum.into(@users, %{}, &{&1, 0})
    hours_per_month = Enum.into(@users, %{}, &{&1, @months})
    hours_per_years = Enum.into(@users, %{}, &{&1, @years})

    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_years" => hours_per_years
    }
  end
end