require 'helper'

describe CheckMobi::Resources::Prefixes do

  it 'should fetch prefixes' do
    resource = CheckMobi::Resources::Prefixes.new
    response = resource.perform
    response.status_code.must_equal '200'
  end
end