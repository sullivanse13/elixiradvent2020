defmodule DayFourTest do
  use ExUnit.Case
  import DayFour

  @docp """

  [x] count valid passports in file
  [x] CHECK FOR Required fields
    byr (Birth Year)
    iyr (Issue Year)
    eyr (Expiration Year)
    hgt (Height)
    hcl (Hair Color)
    ecl (Eye Color)
    pid (Passport ID)
    cid (Country ID)
  [x] valid of only missing cid (north pole credential)
  [x] Read passport
  [x] Read multiple passports
  """

  test "count valid passports in file" do
    assert count_valid_from_file("priv/day_four_input_test.txt") == 2
  end

  test "count valid passports in input" do
    "valid passorts #{count_valid_from_file("priv/day_four_input.txt")}\n"
    |> IO.puts()
  end

  @passport_one %{
    "ecl" => "gry",
    "pid" => "860033327",
    "eyr" => "2020",
    "hcl" => "#fffffd",
    "byr" => "1937",
    "iyr" => "2017",
    "cid" => "147",
    "hgt" => "183cm"
  }

  @passport_two %{
    "ecl" => "amb",
    "pid" => "028048884",
    "eyr" => "2023",
    "hcl" => "#cfa07d",
    "byr" => "1929",
    "iyr" => "2013",
    "cid" => "350"
  }

  test "validate passport" do
    assert valid_passport?(@passport_one) == true
    assert valid_passport?(@passport_two) == false
    assert valid_passport?(Map.drop(@passport_one, ["cid"])) == true
  end

  test "read passport" do
    test_passport = """
    ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
    byr:1937 iyr:2017 cid:147 hgt:183cm
    """

    assert read_passport(test_passport) == @passport_one
  end

  test "read multiple passport" do
    test_passports = """
    ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
    byr:1937 iyr:2017 cid:147 hgt:183cm

    iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
    hcl:#cfa07d byr:1929
    """

    assert read_passports(test_passports) == [
             @passport_one,
             @passport_two
           ]
  end
end
