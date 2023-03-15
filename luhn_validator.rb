# frozen_string_literal: true

# LuhnValidator validate through Luhn Algorithm
module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)

    # TODO: use the integers in nums_a to validate its last check digit
    sum = 0
    nums_a.reverse.each_with_index do |num, i|
      sum += if i.odd?
               num * 2 > 9 ? num * 2 - 10 + 1 : num * 2
             else
               num
             end
    end

    (sum % 10).zero?
  end
end
