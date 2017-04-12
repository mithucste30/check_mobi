require 'helper'

describe CheckMobi::Response do
  before do
    @responsehandler = CheckMobi::Response.new
  end

  it 'should respond to status' do
    @responsehandler.must_respond_to :status
  end

  it 'should respond to status=' do
    @responsehandler.must_respond_to :status=
  end

  it 'should respond to body' do
    @responsehandler.must_respond_to :body
  end

  it 'should respond to body=' do
    @responsehandler.must_respond_to :body=
  end

  it 'should respond to is_successful' do
    @responsehandler.must_respond_to :is_successful
  end

  it 'should respond to errors' do
    @responsehandler.must_respond_to :errors
  end

  it 'errors should be a array' do
    @responsehandler.errors.must_be_instance_of Array
  end

end