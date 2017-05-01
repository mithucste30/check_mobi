require 'helper'

describe ClassWithAttributes do

  describe 'it should set attributes properly' do
    before do
      class Parent
        include ClassWithAttributes
        attributes :a, :b, :c
        readonly_attributes :d, :e, :f
        attribute :g, default: []
        attribute :h, default: Time.new
        readonly_attribute :i, default: String.new
      end

      class ChildA < Parent
        attribute :j, default: %w(A B C)
      end

      class AnotherClass
        include ClassWithAttributes
        attribute :k, default: 'value_of_k'
      end

      class ClassWithoutAttributes
        attr_accessor :l

        def initialize(l)
          @l = l
        end
      end
    end

    it 'should set attr_accessors' do
      p = Parent.new
      p.must_respond_to(:a)
      p.must_respond_to(:a=)
      p.must_respond_to(:b)
      p.must_respond_to(:b=)
      p.must_respond_to(:c)
      p.must_respond_to(:c=)
    end

    it 'should set attr_readers' do
      p = Parent.new
      p.must_respond_to(:d)
      p.wont_respond_to(:d=)
      p.must_respond_to(:e)
      p.wont_respond_to(:e=)
      p.must_respond_to(:f)
      p.wont_respond_to(:f=)
    end

    it 'should set default attributes' do
      p = Parent.new
      p.must_respond_to(:g)
      p.must_respond_to(:g=)
      p.g.must_equal []
      p.h.must_be_instance_of Time
    end

    it 'should set default readonly attributes' do
      p = Parent.new
      p.must_respond_to(:i)
      p.wont_respond_to(:i=)
      p.i.must_be_instance_of String
    end

    it 'should initialize properly with attributes' do
      p = Parent.new(a: 1, b: 'init_b', d: 'init_d', g: Hash.new, i: Object.new)
      p.a.must_equal 1
      p.b.must_equal 'init_b'
      p.d.must_equal nil
      p.g.must_be_instance_of Hash
      p.i.must_be_instance_of String
    end

    it 'should update attributes properly' do
      p = Parent.new(a: 1, b: 'init_b', d: 'init_d', g: Hash.new, i: Object.new)
      p.update_attributes(a: 3, b: 'updated_b', d: 'updated_d', g: Time.new, i: Array.new)
      p.a.must_equal 3
      p.b.must_equal 'updated_b'
      p.d.must_equal nil
      p.g.must_be_instance_of Time
      p.i.must_be_instance_of String
    end
  end

  describe 'it should build' do
    before do
      class AnotherParent
        include ClassWithAttributes
        attributes :a, :b, :c, :f
        readonly_attributes :d
        attribute :h, default: Hash.new
        readonly_attribute :i, default: String.new
      end

      class ChildA < AnotherParent
        attribute :j, default: %w(A B C)
      end

      class AnotherClass
        include ClassWithAttributes
        attribute :k, default: 'value_of_k'
      end

      class ClassWithoutAttributes
        attr_accessor :l

        def initialize(l)
          @l = l
        end
      end
    end

    it 'hash properly' do
      child_a = ChildA.new
      another_class_object = AnotherClass.new
      class_without_attributes = ClassWithoutAttributes.new('not gonna converted to hash')
      value_of_f = [another_class_object, another_class_object]
      p = AnotherParent.new(a: child_a, b: another_class_object, c: class_without_attributes, f: value_of_f)
      output_hash = p.to_hash
      expected_hash = {
        a: {j: %w(A B C)},
        b: {k: 'value_of_k'},
        c: class_without_attributes,
        f: [{k: 'value_of_k'}, {k: 'value_of_k'}],
        d: nil,
        h: {},
        i: ''
      }

      output_hash.must_equal expected_hash
    end
  end

end