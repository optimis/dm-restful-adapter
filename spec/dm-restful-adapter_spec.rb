require File.dirname(__FILE__) + '/spec_helper'

require 'dm-core/spec/shared/adapter_spec'

describe DataMapper::Adapters::RestfulAdapter do
  let!(:adapter) { DataMapper.setup(:default, :adapter => 'restful') }
  let!(:repository) { DataMapper.repository(:default) }
  let!(:heffalump) {
    class ::Heffalump
      include DataMapper::Resource

      property :id,        Serial
      property :color,     String
      property :num_spots, Integer
      property :striped,   Boolean
    end


    # create all tables and constraints before each spec
    if @repository.respond_to?(:auto_migrate!)
      Heffalump.auto_migrate!
    end
  }
  let!(:failing_heffalump) {
    class FailingHeffalump < ::Heffalump
      storage_names[:default] = 'failing_heffalumps'
      def self.name; 'FailingHeffalump'; end
    end
  }

  before { DataMapper.finalize }

  def self.described_type
    described_class
  end

  it_should_behave_like 'An Adapter'

  describe '#create' do
    context 'success' do
      it 'returns number of records successfully created' do
        heffalump = ::Heffalump.new(:color => 'red')
        adapter.create([heffalump]).should == 1
      end
    end

    context 'error' do
      it 'returns 0 if no records are successfully created' do
        DataMapper.finalize

        failing_heffalump = FailingHeffalump.new(:color => 'red')
        adapter.create([failing_heffalump]).should == 0
      end
    end
  end

  describe '#update' do
    context 'success' do
      it 'returns number of records successfully saved' do
        RemoteHeffalumpModel.create(:color => 'red')
        heffalump = Heffalump.all.first
        props = {heffalump.model.properties.detect { |prop| prop.name == :color} => 'blue'}
        heffalump.color = 'blue'
        adapter.update(props, [heffalump]).should == 1
      end
    end

    context 'error' do
      it 'returns 0 if no records are successfully saved' do
        RemoteHeffalumpModel.create(:color => 'red')
        failing_heffalump = FailingHeffalump.all.first
        props = {failing_heffalump.model.properties.detect { |prop| prop.name ==:color} => 'blue'}
        adapter.update(props, [failing_heffalump]).should == 0
      end
    end
  end

  describe '#delete' do
    context 'success' do
      it 'returns number of records successfully saved' do
        RemoteHeffalumpModel.create(:color => 'red')
        heffalump = Heffalump.all.first
        adapter.delete([heffalump]).should == 1
      end
    end

    context 'error' do
      it 'returns 0 if no records are successfully saved' do
        RemoteHeffalumpModel.create(:color => 'red')
        failing_heffalump = FailingHeffalump.all.first
        adapter.delete([failing_heffalump]).should == 0
      end
    end

  end
end
