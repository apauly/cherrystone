# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Cherrystone::Node::AttributesNode do

  let(:root_node) {
    described_class.new(:root)
  }

  it 'can append a grid' do
    root_node.grid foo: :bar do
      title 'Something'
    end

    expect(root_node.find(:grid).options).to eq foo: :bar
    expect(root_node.find(:grid).children.count).to eq 1
    expect(root_node.find(:grid).find(:title)).to be_present
    expect(root_node.find(:grid).children.first.payload).to eq 'Something'
  end

  context '#field' do
    it 'can add fields' do
      root_node.field label: :foo do |record|
        record.name
      end
      root_node.field :something, key: :value

      expect(root_node.children.length).to eq 2
      expect(root_node.find_all(:field).length).to eq 2
      expect(root_node.find(:field).options).to eq label: :foo
      expect(root_node.find(:field).call(double(name: 'Yay'))).to eq 'Yay'
      expect(root_node.find_all(:field).last.payload).to eq :something
      expect(root_node.find_all(:field).last.options).to eq key: :value
    end
  end

end
