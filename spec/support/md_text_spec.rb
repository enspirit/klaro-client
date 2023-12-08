require 'spec_helper'

module Klaro
  class Client
    module Support
      describe MdText do

        it 'works for summary' do
          got = MdText.new("hello\nworld", :summary).to_html
          expect(got).to eql("<p>hello<br />\nworld</p>")
        end

        it 'works for details' do
          got = MdText.new("hello\nworld", :details).to_html
          expect(got).to eql("<p>hello\nworld</p>")
        end

        it 'does not render dangerous html' do
          got = MdText.new("hello<script>var x;</script>", :details).to_html
          expect(got).to eql("<p>hello<!-- raw HTML omitted -->var x;<!-- raw HTML omitted --></p>")
        end

        it 'does not accept style tags' do
          got = MdText.new("hello<style>display: none;</style>", :details).to_html
          expect(got).to eql("<p>hello<!-- raw HTML omitted -->display: none;<!-- raw HTML omitted --></p>")
        end

      end
    end
  end
end
