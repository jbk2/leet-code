# @param {Integer} n
# @return {String[]}
def fizz_buzz(n)
  (1..n).map do |el|
    case
    when (el % 3 == 0) && (el % 5 == 0) then "FizzBuzz"
    when (el % 3 == 0) then "Fizz"
    when (el % 5 == 0) then "Buzz"
    else el.to_s
    end  
  end
end

puts fizz_buzz(3)