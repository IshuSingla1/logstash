# encoding: utf-8
require "spec_helper"
require "logstash/util/defaults_printer"

describe LogStash::Util::DefaultsPrinter do
  shared_examples "a defaults printer" do
    it 'the .print method returns a defaults description' do
      expect(actual_block.call).to eq(expected)
    end
  end

  let(:workers)  { 1 }
  let(:expected) { "Settings: User set pipeline workers: #{workers}" }
  let(:settings) { {} }

  describe 'class methods API' do
    let(:actual_block) do
      -> {described_class.print(settings)}
    end

    context 'when the settings hash is empty' do
      let(:expected) { "Settings: " }
      it_behaves_like "a defaults printer"
    end

    context 'when the settings hash has content' do
      let(:worker_queue) { 42 }
      let(:settings) { {:pipeline_workers => workers} }
      it_behaves_like "a defaults printer"
    end
  end

  describe 'instance method API' do
    let(:actual_block) do
      -> {described_class.new(settings).print}
    end

    context 'when the settings hash is empty' do
      let(:expected) { "Settings: " }
      it_behaves_like "a defaults printer"
    end

    context 'when the settings hash has content' do
      let(:workers) { 13 }
      let(:settings) { {:pipeline_workers => workers} }

      it_behaves_like "a defaults printer"
    end
  end
end
