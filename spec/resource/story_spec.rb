require 'spec_helper'

module Klaro
  class Client
    describe Story do

      let(:story) {
        Story.dress({ description: "Hello **world**, how are you!!\nI'm fine, for myself\nand you?" })
      }

      describe "title" do
        it 'returns the first line of the story description' do
          expect(story.title.to_html).to eql("<p>Hello <strong>world</strong>, how are you!!</p>")
        end
      end

      describe "summary" do
        it 'returns all but the first line of the story description' do
          expect(story.summary.to_html).to eql("<p>I&#39;m fine, for myself<br>\nand you?</p>")
        end
      end

      let(:client) do
        Klaro::Client.new('https://foobar.klaro.cards')
      end

      describe "download_and_relocate_images" do
        it 'works' do
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
end
