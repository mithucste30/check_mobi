require 'helper'

describe Hash do
  it 'should symbolize_keys' do
    {'a': 1, "b": 2}.symbolize_keys.must_equal({a: 1, b: 2})
  end
end