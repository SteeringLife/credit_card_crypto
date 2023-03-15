# frozen_string_literal: true

require_relative './credit_card'
require 'matrix'

# DoubleTranspositionCipher
module DoubleTranspositionCipher
  def self.encrypt(document, key)
    document = document.to_s
    # 1. find number of rows/cols such that matrix is almost square
    size = Math.sqrt(document.length).ceil
    rows = (document + ' ' * (size**2 - document.length)).chars.each_slice(size).to_a
    # 2. break plaintext into evenly sized blocks
    cols = rows.transpose
    # 3. sort rows in predictably random way using key as seed
    rows.shuffle!(random: Random.new(key))
    # 4. sort columns of each row in predictably random way
    cols.each { |col| col.shuffle!(random: Random.new(key)) }
    # 5. return joined cyphertext
    cols.transpose.join
  end

  def self.decrypt(ciphertext, key)
    # 1. find number of rows/cols such that matrix is almost square
    size = Math.sqrt(ciphertext.length).ceil
    cols = ciphertext.split('\"').reject { |s| s.strip == '' }
    # 2. sort columns of each row in predictably random way
    cols.each { |col| col.gsub!(/\s/, '').chars.shuffle!(random: Random.new(key)) }
    # 3. sort rows in predictibly random way using key as seed
    rows = cols.each_slice(size).to_a
    rows.shuffle!(random: Random.new(key))
    # 4. return joined plaintext
    rows.transpose.flatten.join.gsub(/\s+$/, '')
  end
end
