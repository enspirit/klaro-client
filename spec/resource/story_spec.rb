require 'spec_helper'

module Klaro
  class Client
    describe Story do

      let(:client) do
        Klaro::Client.new('https://foobar.klaro.cards')
      end

      it 'extract images' do
        stub_story(1)
        story = client.story(1)
        expect(story).to be_a(Client::Story)
        expect(story.specification).to eql(<<~MD)
          Hello ![Image Label](/s/somehash.jpeg?n=foobar.jpg)
        MD

        folder = Path.backfind(".[Gemfile]")/'tmp'
        relocated = story.download_and_relocate_images(folder.parent, folder, client)
        expect(relocated).to be_a(Client::Story)
        expect(relocated == story).to be(false)
        expect(relocated.specification).to eql(<<~MD)
          Hello ![Image Label](/tmp/news/15/foobar.jpg)
        MD
        expect(Path(Dir.pwd + '/tmp/news/15/foobar.jpg').exists?).to be(true)
      end
    end
  end
end
