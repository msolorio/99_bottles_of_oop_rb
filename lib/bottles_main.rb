class Bottles
  def song
    verses(99, 0)
  end

  def verses(upper, lower)
    upper.downto(lower).map { |number| verse(number) }.join("\n")
  end

  def verse(number)
    bottle_number = bottle_number_for(number)
    next_bottle_number = bottle_number_for(bottle_number.successor)

    "#{bottle_number} of beer on the wall, ".capitalize +
    "#{bottle_number} of beer.\n" +
    bottle_number.action +
    "#{next_bottle_number.quantity} #{next_bottle_number.container} of beer on the wall.\n"
  end

  private

  def bottle_number_for(number)
    if number == 0
      BottleNumber0
    else
      BottleNumber
    end.new(number)
  end

  def container(number)
    BottleNumber.new(number).container
  end

  def pronoun(number)
    BottleNumber.new(number).pronoun
  end

  def quantity(number)
    BottleNumber.new(number).quantity
  end

  def action(number)
    BottleNumber.new(number).action
  end

  def successor(number)
    BottleNumber.new(number).successor
  end
end

class BottleNumber
  attr_reader :number

  def initialize(number)
    @number = number
  end

  def to_s
    "#{quantity} #{container}"
  end

  def container
    if number == 1
      "bottle"
    else
      "bottles"
    end
  end

  def pronoun
    if number == 1
      "it"
    else
      "one"
    end
  end

  def quantity
    if number == 0
      "no more"
    else
      number.to_s
    end
  end

  def action
    if number == 0
      "Go to the store and buy some more, "
    else
      "Take #{pronoun} down and pass it around, "
    end
  end

  def successor
    if number == 0
      99
    else
      number - 1
    end
  end
end

class BottleNumber0 < BottleNumber
  def quantity
    "no more"
  end
end

=begin
number  
99 ---> '99'
...
3 ----> '3'
2 ----> '2'
1 ----> '1'
0 ----> 'no more'
=end
