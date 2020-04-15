# frozen_string_literal: true

require 'spec_helper'

module Klaro
  class Client
    describe Resource do

      describe "symbolize_keys" do

        it 'symbolizes keys on a Hash' do
          expect(symbolize_keys("a" => 12, :b => 13)).to eql({ a: 12, b: 13 })
        end

      end

    end
  end
end
