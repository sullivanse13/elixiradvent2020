defmodule DayFour do
  @moduledoc false

  def count_valid_from_file(file_name) do
    file_name
    |> File.read!()
    |> read_passports
    |> Enum.count(&valid_passport?/1)
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

  def valid_passport?(passport) when is_map(passport) do
    has_valid_expected_fields?(passport)
  end

  defp has_valid_expected_fields?(passport) do
    [
      {"byr", &valid_byr?/1},
      {"iyr", &valid_iyr?/1},
      {"eyr", &valid_eyr?/1},
      {"pid", &valid_pid?/1},
      {"hcl", &valid_hcl?/1},
      {"ecl", &valid_ecl?/1},
      {"hgt", &valid_hgt?/1}
    ]
    |> Enum.all?(fn x -> run_validation(x, passport) end)
  end

  def run_validation({key, func}, passport) do
    with {:ok, value} <- Map.fetch(passport, key) do
      func.(value)
    else
      _ -> false
    end
  end

  def valid_byr?(byr), do: valid_number?(byr, 1920..2002)
  def valid_iyr?(iyr), do: valid_number?(iyr, 2010..2020)
  def valid_eyr?(eyr), do: valid_number?(eyr, 2020..2030)

  def valid_number?(string_year, range) do
    String.to_integer(string_year) in range
  end

  def valid_hgt?(hgt) do
    case Integer.parse(hgt) do
      {_, ""} -> false
      {inches, "in"} -> inches in 59..76
      {cm, "cm"} -> cm in 150..193
    end
  end

  def valid_ecl?(ecl) do
    ecl in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
  end

  def valid_hcl?(hcl) do
    Regex.match?(~r/#[0-9|a-f]{6}/, hcl)
  end

  def valid_pid?(pid) do
    case Integer.parse(pid) do
      {num, ""} -> String.length(pid) == 9 and num > 0
      _ -> false
    end
  end


end
