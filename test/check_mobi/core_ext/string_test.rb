require 'helper'
require_relative '../../../lib/check_mobi/core_ext/string'

describe String do

  it 'should respond to underscore' do
    'TheSampleClass'.must_respond_to(:underscore)
    'TheSampleClass'.must_respond_to(:underscore!)
  end

  it 'should underscore a class string name' do
    'TheSampleClass'.underscore.must_equal 'the_sample_class'
    'TheSampleClass'.underscore!.must_equal 'the_sample_class'
  end

  it 'should put / on namespacing' do
    'SuperTop::Parent::TheSampleClass'.underscore.must_equal 'super_top/parent/the_sample_class'
  end

  it 'should preserve /' do
    'SuperTop/Parent/TheSampleClass'.underscore.must_equal 'super_top/parent/the_sample_class'
  end

  it 'should replace - with _' do
    'Super-Top/Parent/The-Sample-Class'.underscore.must_equal 'super_top/parent/the_sample_class'
  end
end