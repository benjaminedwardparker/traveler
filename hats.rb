class Cat
  attr_accessor :cat_number,
                :hat
  def initialize(count)
    @cat_number = count
    @hat = true
  end

  def switch_hat
    if @hat == true
      @hat = false
    else
      @hat = true
    end
  end

end

cats = []

100.times do |count|
  cat = Cat.new(count + 1)
  cats << cat
end

n = 2

99.times do |count|
  cats.each do |cat|
    if (cat.cat_number % n) == 0
      cat.switch_hat
    end
  end
  n += 1
end

cats.each do |cat|
  puts "cat number #{cat.cat_number}"
  puts "Hat on? #{cat.hat}"
end
