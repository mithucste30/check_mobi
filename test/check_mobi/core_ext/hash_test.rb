require 'helper'

describe Hash do
  it 'should cm_symbolize_keys' do
    {'a': 1, "b": 2}.cm_symbolize_keys.must_equal({a: 1, b: 2})
  end
end
