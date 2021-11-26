defmodule DayFour do
  @moduledoc false

  def count_valid_from_file(file_name) do
    file_name
    |> File.read!()
    |> read_passports
    |> Enum.count(&valid_passport?/1)
  end

  def valid_passport?(passport) when is_map(passport) do
    (has_expected_keys?(passport) and has_valid_expected_fields?(passport))
  end

  defp has_valid_expected_fields?(passport) do
    [{"byr", &valid_byr?/1},
        {"iyr", &valid_iyr?/1},
        {"eyr", &valid_eyr?/1},
        {"pid", &valid_pid?/1},
        {"hcl", &valid_hcl?/1},
        {"ecl", &valid_ecl?/1},
        {"hgt", &valid_hgt?/1}
      ]
      |> Enum.map(fn {key, func} -> {Map.fetch(passport, key), func} end)
      |> Enum.all?(fn {value, func} -> func.(value) end)

  end

  def run_validation({key, func}, passport) do
    with {:ok, value} <- Map.fetch(passport, key) do
      func.(value)
    else
      _ -> false
    end
  end


  def valid_hgt?(:error), do: false
  def valid_hgt?({:ok, hgt}) do
    case Integer.parse(hgt) do
      {_, ""} -> false
      {inches, "in"} -> inches in 59..76
      {cm, "cm"} -> cm in 150..193
    end
  end


  def valid_byr?(byr), do: valid_number?(byr, 1920..2002)
  def valid_iyr?(iyr), do: valid_number?(iyr, 2010..2020)
  def valid_eyr?(eyr), do: valid_number?(eyr, 2020..2030)

  def valid_ecl?(:error), do: false
  def valid_ecl?({:ok, ecl}) do
    ecl in ["amb","blu","brn","gry","grn","hzl","oth"]
  end

  def valid_hcl?(:error), do: false
  def valid_hcl?({:ok, hcl}) do
    Regex.match?(~r/#[0-9|a-f]{6}/, hcl)
  end

  def valid_pid?(:error), do: false
  def valid_pid?({:ok, pid}) do
    case Integer.parse(pid) do
      {num, ""} -> String.length(pid) == 9 and num > 0
      _ -> false
    end
  end

  def valid_number?(:error, _), do: false
  def valid_number?({:ok, string_year}, range) do
    String.to_integer(string_year) in range
  end

  defp has_expected_keys?(passport) do
    expected_keys = ["eyr", "hgt", "ecl", "pid"]
    Enum.all?(expected_keys, fn required -> Map.has_key?(passport, required) end)
  end

  def read_passports(passports) do
    passports
    |> String.split(~r/\n\n/)
    |> Enum.map(&read_passport/1)
  end

  def read_passport(string) do
    string
    |> String.split()
    |> Enum.map(fn s -> String.split(s, ":") end)
    |> Enum.into(%{}, fn [a, b] -> {a, b} end)
  end
end
