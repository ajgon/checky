# frozen_string_literal: true
require 'spec_helper'

RSpec.describe CoreExt do
  context 'Object' do
    context 'blank?' do
      it 'nil' do
        expect(nil.blank?).to be_truthy
      end

      it '{}' do
        expect({}.blank?).to be_truthy
      end

      it '[]' do
        expect([].blank?).to be_truthy
      end

      it '\'\'' do
        expect(''.blank?).to be_truthy
      end

      it 'false' do
        expect(false.blank?).to be_truthy
      end

      it 'true' do
        expect(true.blank?).to be_falsey
      end

      it 'x' do
        expect('x'.blank?).to be_falsey
      end

      it '[1]' do
        expect([1].blank?).to be_falsey
      end

      it '{ a: 0 }' do
        expect({ a: 0 }.blank?).to be_falsey
      end

      it '0' do
        expect(0.blank?).to be_falsey
      end
    end

    context 'present?' do
      it 'nil' do
        expect(nil.present?).to be_falsey
      end

      it '{}' do
        expect({}.present?).to be_falsey
      end

      it '[]' do
        expect([].present?).to be_falsey
      end

      it '\'\'' do
        expect(''.present?).to be_falsey
      end

      it 'false' do
        expect(false.present?).to be_falsey
      end

      it 'true' do
        expect(true.present?).to be_truthy
      end

      it 'x' do
        expect('x'.present?).to be_truthy
      end

      it '[1]' do
        expect([1].present?).to be_truthy
      end

      it '{ a: 0 }' do
        expect({ a: 0 }.present?).to be_truthy
      end

      it '0' do
        expect(0.present?).to be_truthy
      end
    end

    context 'presence' do
      it 'nil' do
        expect(nil.presence).to be_nil
      end

      it '{}' do
        expect({}.presence).to be_nil
      end

      it '[]' do
        expect([].presence).to be_nil
      end

      it '\'\'' do
        expect(''.presence).to be_nil
      end

      it 'false' do
        expect(false.presence).to be_nil
      end

      it 'true' do
        expect(true.presence).to eq true
      end

      it 'x' do
        expect('x'.presence).to eq 'x'
      end

      it '[1]' do
        expect([1].presence).to eq [1]
      end

      it '{ a: 0 }' do
        expect({ a: 0 }.presence).to eq(a: 0)
      end

      it '0' do
        expect(0.presence).to eq 0
      end
    end
  end

  context 'String' do
    context 'which' do
      it 'file exists' do
        allow(ENV).to receive(:[]).and_return('/test')
        allow(File).to receive(:exist?).and_return(true)
        allow(File).to receive(:executable?).and_return(true)
        expect('dummy_command'.which).to eq '/test/dummy_command'
      end

      it 'file does not exist' do
        allow(File).to receive(:exist?).and_return(false)
        expect('dummy_command'.which).to be_nil
      end
    end

    context 'underscore' do
      it 'LoremIpsum' do
        expect('LoremIpsum'.underscore).to eq 'lorem_ipsum'
      end

      it 'ABCD' do
        expect('ABCD'.underscore).to eq 'abcd'
      end
    end

    context 'classify' do
      it 'lorem_ipsum' do
        expect('lorem_ipsum'.classify).to eq 'LoremIpsum'
      end
    end

    context 'satisfies_requirement?' do
      it 'match' do
        expect('1.3.12'.satisfies_requirement?('~> 1.3.0')).to be_truthy
      end

      it 'does not match' do
        expect('2.3.12'.satisfies_requirement?('~> 1.3.0')).to be_falsey
      end
    end
  end
end
