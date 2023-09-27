gem "minitest", "~> 5.4"
require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/bottles_main.rb"

class VerseFake
  def self.lyrics(number)
    "This is verse #{number}.\n"
  end
end

class CountdownSongTest < Minitest::Test
  def test_a_verse
    expected = "This is verse 543.\n"
    assert_equal(expected, CountdownSong.new(verse_template: VerseFake).verse(543))
  end

  def test_a_few_verses
    expected =
      "This is verse 2.\n" +
      "\n" +
      "This is verse 1.\n" +
      "\n" +
      "This is verse 0.\n"
    assert_equal(expected, CountdownSong.new(verse_template: VerseFake).verses(2, 0))
  end

  def test_song
    expected =
      "This is verse 42.\n" +
      "\n" +
      "This is verse 41.\n" +
      "\n" +
      "This is verse 40.\n" +
      "\n" +
      "This is verse 39.\n" +
      "\n" +
      "This is verse 38.\n"

    assert_equal(expected, CountdownSong.new(verse_template: VerseFake, max: 42, min: 38).song)
  end
end

class BottleVerseTest < Minitest::Test
  def test_verse_general_rule_upper_bound
    expected =
      "99 bottles of beer on the wall, " +
      "99 bottles of beer.\n" +
      "Take one down and pass it around, " +
      "98 bottles of beer on the wall.\n"
    assert_equal(expected, BottleVerse.lyrics(99))
  end

  def test_verse_general_rule_lower_bound
    expected =
      "3 bottles of beer on the wall, " +
      "3 bottles of beer.\n" +
      "Take one down and pass it around, " +
      "2 bottles of beer on the wall.\n"
    assert_equal(expected, BottleVerse.lyrics(3))
  end

  def test_verse_7
    expected =
      "7 bottles of beer on the wall, " +
      "7 bottles of beer.\n" +
      "Take one down and pass it around, " +
      "1 six-pack of beer on the wall.\n"
    assert_equal(expected, BottleVerse.lyrics(7))
  end

  def test_verse_6
    expected =
      "1 six-pack of beer on the wall, " +
      "1 six-pack of beer.\n" +
      "Take one down and pass it around, " +
      "5 bottles of beer on the wall.\n"
    assert_equal(expected, BottleVerse.lyrics(6))
  end

  def test_verse_2
    expected =
      "2 bottles of beer on the wall, " +
      "2 bottles of beer.\n" +
      "Take one down and pass it around, " +
      "1 bottle of beer on the wall.\n"
    assert_equal(expected, BottleVerse.lyrics(2))
  end

  def test_verse_1
    expected =
      "1 bottle of beer on the wall, " +
      "1 bottle of beer.\n" +
      "Take it down and pass it around, " +
      "no more bottles of beer on the wall.\n"
    assert_equal(expected, BottleVerse.lyrics(1))
  end

  def test_verse_0
    expected =
      "No more bottles of beer on the wall, " +
      "no more bottles of beer.\n" +
      "Go to the store and buy some more, " +
      "99 bottles of beer on the wall.\n"
    assert_equal(expected, BottleVerse.lyrics(0))
  end
end

class BottleNumberTest < Minitest::Test
  def test_returns_correct_class_for_given_number
    # 0, 1, 6 are special cases
    assert BottleNumber0, BottleNumber.for(0).class
    assert BottleNumber1, BottleNumber.for(1).class
    assert BottleNumber6, BottleNumber.for(6).class

    # other numbers get default BottleNumber class
    assert BottleNumber, BottleNumber.for(42).class
  end
end
