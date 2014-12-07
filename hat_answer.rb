cats = Array.new(100, false)

(1..100).each do |round|
    cat_index = round - 1
    while cat_index < 100
        cats[cat_index] != cats[cat_index]
        cat_index += round
    end
end

cats.each_with_index do |cat, index|
    puts index + 1 if cat
end
