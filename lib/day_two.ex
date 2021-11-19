defmodule DayTwo do
  @moduledoc false


  def parse_line(line) do
    [range_start, range_end, letter, password] = String.split(line, ~r/-|:? /)

    {String.to_integer(range_start)..String.to_integer(range_end), letter, password}
  end

  def count_required(required, password) do
    password
    |> String.codepoints
    |> Enum.count(fn x -> x == required end)
  end

  def is_valid_password({range, required, password}) do
    range
    |> Enum.member?(count_required(required, password))
  end


  def count_valid_passwords(file) when is_binary(file) do
    file
    |> File.read!()
    |> String.split("\n")
    |> count_valid_passwords()
  end


  def count_valid_passwords(list) when is_list(list) do
    list
    |> Enum.map(&parse_line/1)
    |> Enum.count(&is_valid_password/1)
  end

end
