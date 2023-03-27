# frozen_string_literal: true

require 'rbnacl'
require 'base64'

# ModernSymmetricCipher encrypt and decrypt
module ModernSymmetricCipher
  def self.generate_new_key
    # TODO: Return a new key as a Base64 string
    key = RbNaCl::Random.random_bytes(RbNaCl::SecretBox.key_bytes)
    Base64.strict_encode64(key)
  end

  def self.encrypt(document, key)
    # TODO: Return an encrypted string
    #       Use base64 for ciphertext so that it is sendable as text
    doc_str = document.to_s
    key_bytes = Base64.strict_decode64(key)
    ciphertext = RbNaCl::SimpleBox.from_secret_key(key_bytes).encrypt(doc_str)
    Base64.strict_encode64(ciphertext)
  end

  def self.decrypt(encrypted_cc, key)
    # TODO: Decrypt from encrypted message above
    #       Expect Base64 encrypted message and Base64 key
    key_bytes = Base64.strict_decode64(key.to_s)
    ciphertext = Base64.strict_decode64(encrypted_cc)
    RbNaCl::SimpleBox.from_secret_key(key_bytes).decrypt(ciphertext)
  end
end
