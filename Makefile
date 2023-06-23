bundle:
	bundle install

package: bundle
	bundle exec rake package

tests: bundle
	bundle exec rake test

gem.push:
	ls pkg/klaro-client-*.gem | xargs gem push
