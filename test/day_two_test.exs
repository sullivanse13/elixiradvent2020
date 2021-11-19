defmodule DayTwoTest do
  use ExUnit.Case
  import DayTwo


  #
  # _ parse line
  # _ parse range in line
  # _ count required letter in password
  # _ check if count is in range
  #

  test "parse line" do
    assert parse_line("1-3 a: abcde") == {1..3, "a", "abcde"}
  end

  test "count required" do
    assert count_required("a", "abcde") == 1
    assert count_required("c", "acbcdec") == 3
  end

  test "is valid password" do
    assert is_valid_password({1..3, "a", "abcde"})
    refute is_valid_password({1..3, "b", "cdefg"})
  end

  test "count valid in list" do
    list = ["1-3 a: abcde",
      "1-3 b: cdefg",
      "2-9 c: ccccccccc"]

    assert count_valid_passwords(list) == 2
  end

  test "count from file" do
    assert count_valid_passwords("priv/day_two_input_test.txt") == 2
  end

  test "from input" do
    IO.puts("\nvalid password count: #{count_valid_passwords("priv/day_two_input.txt")}\n")
  end



end
