class Dice
  attr_reader :count, :type

  def initialize expression
    parts = expression.split('d').map(&:to_i)
    @count = parts.first
    @type = parts.last
  end

  def roll
    count.times.collect { rand 1..type }.sum
  end

  def average limit, bonus = 0
    MixedDice.new([self]).average(limit, bonus)
  end
end

class D20
  def self.roll(advantage_disadvantage = nil)
    case advantage_disadvantage
    when :advantage
      [rand(1..20), rand(1..20)].max
    when :disadvantage
      [rand(1..20), rand(1..20)].min
    else
      rand 1..20
    end
  end
end

class MixedDice
  attr_reader :dice

  def initialize dice
    @dice = dice
  end

  def roll
    dice.sum(&:roll)
  end

  def average limit, bonus
    dice_map = dice.flat_map { |die| Array.new(die.count) { (1..die.type) } }
    addends = [0]

    until dice_map.empty?
      previous = addends
      addends = []
      die = dice_map.pop.to_a
      die.each do |roll|
        previous.each do |addend|
          addends << [roll + addend + bonus, limit].min
        end
      end
    end

    addends.sum / addends.count.to_f
  end
end
