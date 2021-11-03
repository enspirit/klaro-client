clean:
	rm -rf pkg/*
	rm -rf tmp/*

test:
	bundle exec rake test

################################################################################
### Gem Management
###

pkg:
	bundle exec rake gem

gem: pkg

gem.publish: gem
	gem push `ls -Art pkg/*.gem | tail -n 1`
