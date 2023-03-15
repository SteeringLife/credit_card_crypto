# frozen_string_literal: true

require_relative './credit_card'

module SubstitutionCipher
  # Caesar cipher
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using caesar cipher
      document = document.to_s
      document.chars.map { |char| shift_char(char, key) }.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caesar cipher
      encrypt(document, -key)
    end

    def self.shift_char(char, key)
      if char.match?(/[A-Za-z]/)
        base = char.ord < 97 ? 65 : 97
        ((char.ord - base + key) % 26 + base).chr
      else
        char
      end
    end
  end

  # Permutation ciphe
  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using a permutation cipher
      document = document.to_s
      srand(key)
      lookup = (0..127).to_a.shuffle(random: Random.new(key))
      document.chars.map { |char| lookup[char.ord].chr }.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      srand(key)
      lookup = (0..127).to_a.shuffle(random: Random.new(key))
      inverse_lookup = lookup.map.with_index.to_h
      document.chars.map { |char| inverse_lookup[char.ord].chr }.join
    end
  end
end
