RUBY_IMAGE := ruby:2.7.3

clean:
	rm -rf pkg/*
	rm -rf tmp/*

test: 
	docker run --rm -t -v $(PWD)/:/app -w /app $(RUBY_IMAGE) bash -c "bundle install && bundle exec rake test"

################################################################################
### Gem Management
###

gem: clean
	docker run -t --rm -v $(PWD)/:/app -w /app $(RUBY_IMAGE) bash -c "bundle install && bundle exec rake gem"

gem.publish: gem
	docker run -t --rm -v $(PWD)/:/app -w /app -e GEM_HOST_API_KEY=${GEM_HOST_API_KEY} $(RUBY_IMAGE) bash -c "gem push `ls -Art pkg/*.gem | tail -n 1`"
	