require_relative '../credit_card'
require 'minitest/autorun'

# Feel free to replace the contents of cards with data from your own yaml file
card_details = [
  { num: '4916603231464963',
    exp: 'Mar-30-2020',
    name: 'Soumya Ray',
    net: 'Visa' },
  { num: '6011580789725897',
    exp: 'Sep-30-2020',
    name: 'Nick Danks',
    net: 'Visa' },
  { num: '5423661657234057',
    exp: 'Feb-30-2020',
    name: 'Lee Chen',
    net: 'Mastercard' }
]

cards = card_details.map do |c|
  CreditCard.new(c[:num], c[:exp], c[:name], c[:net])
end

describe 'Test hashing requirements' do
  describe 'Test regular hashing' do
    describe 'Check hashes are consistently produced' do
      # TODO: Check that each card produces the same hash if hashed repeatedly
      it 'should produce the same hash' do
        cards.each do |card|
          hash = card.hash
          _(hash).wont_be_nil
          _(10.times.all? { card.hash == hash }).must_equal true
        end
      end
    end

    describe 'Check for unique hashes' do
      # TODO: Check that each card produces a different hash than other cards
      it 'should produce a different hash' do
        cards.combination(2).each do |card1, card2|
          _(card1.hash).wont_be_nil
          _(card2.hash).wont_be_nil
          _(card1.hash).wont_equal card2.hash
        end
      end
    end
  end

  describe 'Test cryptographic hashing' do
    describe 'Check hashes are consistently produced' do
      # TODO: Check that each card produces the same hash if hashed repeatedly
      it 'should produce the same hash' do
        cards.each do |card|
          hash = card.hash_secure
          _(hash).wont_be_nil
          _(10.times.all? { card.hash_secure == hash }).must_equal true
        end
      end
    end

    describe 'Check for unique hashes' do
      # TODO: Check that each card produces a different hash than other cards
      it 'should produce a different hash' do
        cards.combination(2).each do |card1, card2|
          _(card1.hash_secure).wont_be_nil
          _(card2.hash_secure).wont_be_nil
          _(card1.hash_secure).wont_equal card2.hash_secure
        end
      end
    end

    describe 'Check regular hash not same as cryptographic hash' do
      # TODO: Check that each card's hash is different from its hash_secure
      it 'should produce a different hash' do
        cards.each do |card|
          _(card.hash).wont_be_nil
          _(card.hash).wont_equal card.hash_secure
        end
      end
    end
  end
end
