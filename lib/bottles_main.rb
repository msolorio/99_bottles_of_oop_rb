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

  def bottle_number_for(number)
    case number
    when 0
      BottleNumber0
    when 1
      BottleNumber1
    else
      BottleNumber
    end.new(number)
  end

  private

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
    "bottles"
  end

  def pronoun
    "one"
  end

  def quantity
    number.to_s
  end

  def action
    "Take #{pronoun} down and pass it around, "
  end

  def successor
    number - 1
  end
end

class BottleNumber0 < BottleNumber
  def quantity
    "no more"
  end

  def action
    "Go to the store and buy some more, "
  end

  def successor
    99
  end
end

class BottleNumber1 < BottleNumber
  def container
    "bottle"
  end

  def pronoun
    "it"
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
