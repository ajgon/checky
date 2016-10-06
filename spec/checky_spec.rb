# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Checky do
  let!(:command) { instance_double('dummy_command') }

  before do
    allow(command).to receive(:which).and_return("/test/#{command}")
    allow(described_class).to receive(:run).and_return("#{command} v1.2.3 rev. f23a54bc")
  end

  context 'binary' do
    it 'matches' do
      expect(described_class.check do
        binary command
      end).to be_truthy
    end

    it 'does not match' do
      allow(command).to receive(:which).and_return(nil)

      expect(described_class.check do
        binary command
      end).to be_falsey
    end
  end

  context 'version' do
    it 'matches' do
      expect(described_class.check do
        version '~> 1.0'
        binary command
      end).to be_truthy
    end

    it 'does not match' do
      expect(described_class.check do
        binary command
        version '~> 2.0'
      end).to be_falsey
    end
  end

  context 'fail_hard' do
    it 'fails' do
      expect do
        described_class.check do
          binary command
          version '~> 2.0'
          fail_hard
        end
      end.to raise_error Checky::ValidationError
    end

    it 'does not fail' do
      expect do
        described_class.check do
          binary command
          version '~> 1.0'
          fail_hard
        end
      end.not_to raise_error
    end
  end
end
