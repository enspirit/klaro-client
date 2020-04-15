require 'spec_helper'

module Klaro
  class Client
    describe Attachment do

      let(:client) do
        Klaro::Client.new('https://foobar.klaro.cards')
      end

      let(:attachement) {
        Attachment.dress({
          "url" => "/s/image.jpg",
          "thumbnailUrl" => "/s/thumb.jpg"
        }, client)
      }

      it 'helps getting short URLs' do
        expect(attachement.url).to eql("/s/image.jpg")
        expect(attachement.thumbnailUrl).to eql("/s/thumb.jpg")
      end

      it 'helps getting absolute URLs' do
        expect(attachement.absUrl).to eql("https://foobar.klaro.cards/s/image.jpg")
        expect(attachement.absThumbnailUrl).to eql("https://foobar.klaro.cards/s/thumb.jpg")
      end

    end
  end # class Client
end # module Klaro
