require 'helper'
require_relative '../../../lib/check_mobi/core_ext/string'

describe String do

  it 'should respond to cm_underscore' do
    'TheSampleClass'.must_respond_to(:cm_underscore)
    'TheSampleClass'.must_respond_to(:cm_underscore!)
  end

  it 'should cm_underscore a class string name' do
    'TheSampleClass'.cm_underscore.must_equal 'the_sample_class'
    'TheSampleClass'.cm_underscore!.must_equal 'the_sample_class'
  end

  it 'should put / on namespacing' do
    'SuperTop::Parent::TheSampleClass'.cm_underscore.must_equal 'super_top/parent/the_sample_class'
  end

  it 'should preserve /' do
    'SuperTop/Parent/TheSampleClass'.cm_underscore.must_equal 'super_top/parent/the_sample_class'
  end

  it 'should replace - with _' do
    'Super-Top/Parent/The-Sample-Class'.cm_underscore.must_equal 'super_top/parent/the_sample_class'
  end
end
