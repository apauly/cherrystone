# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Cherrystone::Node::Base do

  let(:node_class) { described_class }
  let(:root_node) { node_class.new(:root) }

  it 'has default node class configured' do
    root_node.title 'Yay!'
    expect(root_node.find(:title)).to be_a(Cherrystone::Node::Base)
  end

  it 'has basic methods' do
    root_node.title 'Yay!'
    root_node.render_partial 'some_partial', foo: :bar

    expect(root_node.find(:title).payload).to eq 'Yay!'
    expect(root_node.find(:render_partial).payload).to eq 'some_partial'
    expect(root_node.find(:render_partial).options).to eq foo: :bar
  end

  context 'settings' do
    let(:node_class) do
      Class.new(described_class) do
        settings :show_footer
      end
    end

    it 'has settings' do
      root_node.show_footer
      expect(root_node.show_footer?).to eq true

      root_node.show_footer false
      expect(root_node.show_footer?).to eq false

      root_node.show_footer true
      expect(root_node.show_footer?).to eq true
    end
  end

end
