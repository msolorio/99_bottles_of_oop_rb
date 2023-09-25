class Bottles
  def song
    verses(99, 0)
  end

  def verses(upper, lower)
    upper.downto(lower).map { |number| verse(number) }.join("\n")
  end

  def verse(number)
    BottleVerse.new(number).lyrics
  end
end

class BottleVerse
  attr_reader :number

  def initialize(number)
    @number = number
  end

  def lyrics
    bottle_number = BottleNumber.for(number)

    "#{bottle_number} of beer on the wall, ".capitalize +
    "#{bottle_number} of beer.\n" +
    bottle_number.action +
    "#{bottle_number.successor} of beer on the wall.\n"
  end
end

class BottleNumber
  attr_reader :number

  # ----------------------------------------------------
  # follows open/closed principle
  # dynamically deriving the class name
  # con: since class names aren't referenced directly, programmer may decide to delete a class
  # con: uses exception for control flow
  # def self.for(number)
  #   begin
  #     const_get("BottleNumber#{number}")
  #   rescue NameError
  #     BottleNumber
  #   end.new(number)
  # end

  # ----------------------------------------------------
  # using the inherited hook
  # When a subclass is created from BottleNumber, the inherited hook is called
  def self.registry
    @registry ||= [self]
  end

  def self.register(candidate)
    registry.prepend(candidate)
  end

  def self.inherited(candidate)
    register(candidate)
  end

  def self.for(number)
    registry.find { |candidate| candidate.handles?(number) }.new(number)
  end

  # ----------------------------------------------------
  # maintains a registry of classes to check. Classes register themselves.
  # Is open for extension, creates instances of classes who's names it doesn't know
  # def self.registry
  #   @registry ||= [self]
  # end

  # def self.register(candidate)
  #   registry.prepend(candidate)
  # end

  # def self.for(number)
  #   registry.find { |candidate| candidate.handles?(number) }.new(number)
  # end

  # ----------------------------------------------------
  # maintains a registry of classes to check. Each class keeps track of if it should be chosen
  # BottleNumber superclass must always be last on the list
  # def self.registry
  #   [
  #     BottleNumber0,
  #     BottleNumber1,
  #     BottleNumber6,
  #   ].push(BottleNumber)
  # end

  # def self.for(number)
  #   registry.find { |candidate| candidate.handles?(number) }.new(number)
  # end

  # ----------------------------------------------------
  # creates hash that defaults to BottleNumber for failed key lookups and creates an instance
  # def self.for(number)
  #   Hash.new(BottleNumber).merge(
  #     0 => BottleNumber0,
  #     1 => BottleNumber1,
  #     6 => BottleNumber6,
  #   )[number].new(number)
  # end

  # ----------------------------------------------------
  # def self.for(number)
  #   case number
  #   when 0
  #     BottleNumber0
  #   when 1
  #     BottleNumber1
  #   when 6
  #     BottleNumber6
  #   else
  #     BottleNumber
  #   end.new(number)
  # end

  def self.handles?(number)
    true
  end

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
    BottleNumber.for(number - 1)
  end
end

class BottleNumber0 < BottleNumber
  BottleNumber.register(self)

  def self.handles?(number)
    number == 0
  end

  def quantity
    "no more"
  end

  def action
    "Go to the store and buy some more, "
  end

  def successor
    BottleNumber.for(99)
  end
end

class BottleNumber1 < BottleNumber
  BottleNumber.register(self)

  def self.handles?(number)
    number == 1
  end

  def container
    "bottle"
  end

  def pronoun
    "it"
  end
end

class BottleNumber6 < BottleNumber
  BottleNumber.register(self)

  def self.handles?(number)
    number == 6
  end

  def quantity
    "1"
  end

  def container
    "six-pack"
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
