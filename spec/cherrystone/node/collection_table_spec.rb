# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Cherrystone::Node::CollectionTable do

  let(:collection) {
    [1, 2, 3]
  }
  let(:root_node) {
    described_class.new(:root, collection)
  }

  it 'has a collection' do
    expect(root_node.collection).to eq collection
  end

  it 'implements collection_action' do
    root_node.collection_action :import, '/import_path', modal: true
    expect(root_node.find(:collection_action)).to be_present
    expect(root_node.find(:collection_action).payload).to eq title: :import, url: '/import_path'
    expect(root_node.find(:collection_action).options).to eq modal: true
  end

  it 'implements batch_action' do
    root_node.batch_action :delete, confirm: true
    expect(root_node.find(:batch_action)).to be_present
    expect(root_node.find(:batch_action).payload).to eq name: :delete
    expect(root_node.find(:batch_action).options).to eq confirm: true
  end

  it 'implements row_action' do
    root_node.row_action do |record|
      "/some_url/#{record.id}"
    end

    expect(root_node.find(:row_action)).to be_present
    expect(root_node.find(:row_action).call(double(id: 42))).to eq '/some_url/42'
  end

  it 'implements related_links' do
    root_node.related_links do |record|
      link :edit, "/foos/#{record.id}/edit"
      link :destroy, "/foos/#{record.id}", method: :delete, confirm: true
    end

    expect(root_node.find(:related_links)).to be_present
    links = root_node.find(:related_links).call(double(id: 42))
    expect(links).to be_present
    expect(links.children.count).to eq 2
    expect(links.find_all(:link).count).to eq 2

    expect(links.find_all(:link)[0].payload).to eq title: :edit, url: '/foos/42/edit'
    expect(links.find_all(:link)[0].options).to be_blank
    expect(links.find_all(:link)[1].payload).to eq title: :destroy, url: '/foos/42'
    expect(links.find_all(:link)[1].options).to eq method: :delete, confirm: true
  end

  it 'implements filter' do
    root_node.filter :user, :dropdown, default: 123
    expect(root_node.children.length).to eq 1
    expect(root_node.find(:filter).payload).to eq name: :user, type: :dropdown
    expect(root_node.find(:filter).options).to eq default: 123
  end

  it 'implements filter_preset' do
    root_node.filter_preset :all, foo: :bar
    expect(root_node.children.length).to eq 1
    expect(root_node.find(:filter_preset).payload).to eq name: :all
    expect(root_node.find(:filter_preset).options).to eq foo: :bar
  end

  it 'implements column' do
    root_node.column :name, format: :upcase
    root_node.column :something do |record|
      record.hello
    end

    expect(root_node.children.count).to eq 2
    expect(root_node.find_all(:column)[0].payload).to eq :name
    expect(root_node.find_all(:column)[0].options).to eq format: :upcase

    expect(root_node.find_all(:column)[1].payload).to eq :something
    expect(root_node.find_all(:column)[1].call(double(hello: 'Yay'))).to eq 'Yay'
  end

end
