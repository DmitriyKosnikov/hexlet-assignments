# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  # BEGIN
  def setup
    @stack = Stack.new
  end
  
  def teardown; end
  
  def test_push
    expected_value = ['Alexey', 'Dmitriy']
    
    @stack.push!('Alexey')
    @stack.push!('Dmitriy')

    assert(@stack.to_a, expected_value)
  end

  def test_pop
    expected_value = 'Second'

    @stack.push!('First')
    @stack.push!('Second')

    assert(@stack.pop!, expected_value)
  end

  def test_empty
    @stack.push!('value')
    
    refute(@stack.empty?)
  end

  def test_clear
    @stack.push!('first')
    @stack.push!('second')
    @stack.push!('third')

    @stack.clear!

    assert(@stack.empty?)
  end

  def test_size
    expected_size = 3
    @stack.push!(1)
    @stack.push!(1)
    @stack.push!(1)

    assert(@stack.size, expected_size)
  end
  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
