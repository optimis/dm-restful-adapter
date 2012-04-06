require File.dirname(__FILE__) + '/spec_helper'

require 'dm-core/spec/shared/adapter_spec'

describe DataMapper::Adapters::RestfulAdapter do
  before :all do
    @adapter = DataMapper.setup(:default, :adapter => 'restful')
  end

  def self.described_type
    described_class
  end

  it_should_behave_like 'An Adapter'
end
