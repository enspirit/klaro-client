require 'spec_helper'

module Klaro
  class Client
    describe Story do

      let(:client) do
        Klaro::Client.new('https://foobar.klaro.cards')
      end

      def story(extra = {})
        Story.dress({
          identifier: 127,
          title: "Hello **world**, how are you!!\nI'm fine, for myself\nand you?",
          specification: "Here **we** go!\ncariage [returns](http://returns.org) do not br\n\nbut doubles do p",
        }.merge(extra), client)
      end

      describe "to_url" do
        it 'returns a dashed title' do
          expect(story.to_url).to eql("127-hello-world-how-are-you")
        end

        it 'allows removing the id' do
          expect(story.to_url(false)).to eql("hello-world-how-are-you")
        end

        it 'removes accents' do
          expect(story(title: "Héhéhé ààà").to_url(false)).to eql("hehehe-aaa")
        end
      end

      describe "title" do
        it 'returns the first line of the story title' do
          expect(story.title.to_html).to eql("<p>Hello <strong>world</strong>, how are you!!</p>")
        end
      end

      describe "summary" do
        it 'returns all but the first line of the story title' do
          expect(story.summary.to_html).to eql("<p>I'm fine, for myself<br />\nand you?</p>")
        end
      end

      describe "specification" do
        it 'returns the specification' do
          expect(story.specification.to_html).to eql(%Q{<p>Here <strong>we</strong> go!\ncariage <a target="_blank" href="http://returns.org">returns</a> do not br</p>\n<p>but doubles do p</p>})
          expect(story.details.to_html).to eql(story.specification.to_html)
        end
      end

      describe "cover_attachement" do
        it 'returns the attachment marked as such when it exists' do
          s = story({
            attachments: [
              { id: 1, isCover: false },
              { id: 2, isCover: true }
            ]
          })
          expect(s.cover_attachment).not_to be_nil
          expect(s.cover_attachment.id).to eql(2)
        end
        it 'returns the first attachment when no one but forced' do
          s = story({
            attachments: [
              { id: 1, isCover: false },
              { id: 2, isCover: false }
            ]
          })
          expect(s.cover_attachment).to be_nil
          expect(s.cover_attachment(true).id).to eql(1)
        end
      end

      describe "linked_cards" do
        it 'works' do
          stub_story(1)
          story = client.story(1)
          expect(story.linked_cards.each.size).to eql(1)
          story.linked_cards.each do |s|
            expect(s).to be_a(Client::Story)
          end
        end
      end

      describe "download_and_relocate_images" do
        it 'works' do
          stub_story(1)
          stub_download_file
          story = client.story(1)
          expect(story).to be_a(Client::Story)
          expect(story.specification.to_s).to eql(<<~MD)
            Hello ![Image Label](/s/somehash.jpeg?n=foobar.jpg)
          MD

          folder = Path.backfind(".[Gemfile]")/'tmp'
          relocated = story.download_and_relocate_images(folder.parent, folder, client)
          expect(relocated).to be_a(Client::Story)
          expect(relocated == story).to be(false)
          expect(relocated.specification.to_s).to eql(<<~MD)
            Hello ![Image Label](/tmp/news/15/foobar.jpg)
          MD
          expect(Path(Dir.pwd + '/tmp/news/15/foobar.jpg').exists?).to be(true)
        end
      end

    end
  end
end
