# frozen_string_literal: true

require_relative './credit_card'
require 'matrix'

# DoubleTranspositionCipher
module DoubleTranspositionCipher
  def self.get_size(text)
    Math.sqrt(text.length).ceil
  end

  def self.smear(arr, key)
    arr.shuffle(random: Random.new(key))
  end

  def self.recover(arr, key)
    keys = Array.new(arr.length) { |i| i + 1 }
    arr.sort_by { |keys_ele| keys.shuffle(random: Random.new(key))[arr.index(keys_ele)] }
  end

  def self.encrypt(document, key)
    document = document.to_s
    # 1. find number of rows/cols such that matrix is almost square
    size = get_size document
    # 2. break plaintext into evenly sized blocks
    rows = (document + ' ' * (size**2 - document.length)).chars.each_slice(size).to_a
    # 3. sort rows in predictably random way using key as seed
    rows_shuffle = smear(rows, key)
    # 4. sort columns of each row in predictably random way
    cols = rows_shuffle.transpose
    cols_shuffle = smear(cols, key)
    # 5. return joined cyphertext
    cols_shuffle.transpose.join
  end

  def self.decrypt(ciphertext, key)
    # 1. find number of rows/cols such that matrix is almost square
    size = get_size ciphertext
    cols = (ciphertext + ' ' * (size**2 - ciphertext.length)).chars.each_slice(size).to_a
    # 2. sort columns of each row in predictably random way
    cols_original = recover(cols, key)
    # 3. sort rows in predictibly random way using key as seed
    rows = cols_original.transpose
    original_rows = recover(rows, key)
    # 4. return joined plaintext
    original_rows.transpose.join.strip
  end
end
