defmodule DayTwo do
  @moduledoc false


  def count_valid_passwords_position(file) do
    file
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(fn line -> String.split(line, ~r/-|:? /) end)
    |> Enum.count(&is_valid_positional/1)
  end

  def is_valid_positional([low, high, required, string]) do
    [low,high]
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(fn x -> x-1 end)
    |> Enum.map(fn position -> String.at(string, position) end)
    |> Enum.count(fn char -> char == required end)
    |> Kernel.==(1)
  end

  def parse_line_range(line) do
    [range_start, range_end, letter, password] = String.split(line, ~r/-|:? /)

    {String.to_integer(range_start)..String.to_integer(range_end), letter, password}
  end

  def count_required_range(required, password) do
    password
    |> String.codepoints
    |> Enum.count(fn x -> x == required end)
  end

  def is_valid_password_range({range, required, password}) do
    range
    |> Enum.member?(count_required_range(required, password))
  end


  def count_valid_passwords_range(file) when is_binary(file) do
    file
    |> File.read!()
    |> String.split("\n")
    |> count_valid_passwords_range()
  end


  def count_valid_passwords_range(list) when is_list(list) do
    list
    |> Enum.map(&parse_line_range/1)
    |> Enum.count(&is_valid_password_range/1)
  end

end
