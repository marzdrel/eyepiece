.PHONY: test build release clean console

## Run tests
test:
	bundle exec rspec

## Start IRB console with gem loaded
console:
	bundle exec irb -r eyepiece

## Build gem into pkg/ directory
build:
	bundle exec rake build

## Release gem to RubyGems (builds, tags, and pushes)
release:
	bundle exec rake release

## Remove built gem packages
clean:
	bundle exec rake clobber
