def number_of_steps(num)
  return 0 if num == 0

  steps = 0
  reduction = num

  until reduction == 0
    if reduction % 2 == 0
      reduction /= 2
    else
      reduction -= 1
    end
    steps += 1
  end

  steps
end

puts number_of_steps(14)