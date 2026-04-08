# Eyepiece

A collection of Rails model mixins for common query patterns: quick text search and brief scopes.

## Installation

Add to your Gemfile:

```ruby
gem "eyepiece"
```

Then run `bundle install`.

## Usage

### QuickSearch

Adds `like` and `mlike` class methods for case-insensitive text search across specified columns.

```ruby
class User < ApplicationRecord
  include Eyepiece::QuickSearch.new(:first_name, :last_name, :email)
end
```

**`like`** - find exactly one record (raises `Eyepiece::TooManyRecordsError` if multiple match):

```ruby
User.like("john")            # searches first_name, last_name, email
User.like("john", "doe")     # matches records containing "john" OR "doe"
```

**`mlike`** - find multiple records:

```ruby
User.mlike("smith")          # returns all matching records
```

### QuickBriefScope

Adds a scope that reselects only the specified columns. Useful for lightweight queries.

```ruby
class User < ApplicationRecord
  include Eyepiece::QuickBriefScope.new(:id, :email, :name)
end

User.brief  # SELECT id, email, name FROM users
```

Custom method name:

```ruby
class User < ApplicationRecord
  include Eyepiece::QuickBriefScope.new(:id, :email, method: :summary)
end

User.summary  # SELECT id, email FROM users
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
