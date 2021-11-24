defmodule DayFour do
  @moduledoc false

  def count_valid_from_file(file_name) do
    file_name
    |> File.read!()
    |> read_passports
    |> Enum.count(&valid_passport?/1)
  end

  def valid_passport?(passport) when is_map(passport) do
    ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
    |> Enum.all?(fn required -> Map.has_key?(passport, required) end)
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
