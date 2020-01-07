require 'rubygems'
require 'bundler'
Bundler.setup(:default)
require 'active_support/core_ext/object/with_options'
require 'money-rails'

Money.rounding_mode = BigDecimal::ROUND_UP

class Record
  def test
    with_options foo: 'bar' do
      helper(Money.new(10, 'USD'))
    end
  end

  private

  def method_missing(method_name, money)
    expected = Money.new(10, 'USD')
    return if expected == money

    puts "Failure: got #{money.inspect}, expected #{expected.inspect}"
  end
end

Record.new.test
