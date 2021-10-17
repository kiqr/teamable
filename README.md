Teamable 
========
[![RuboCop Github Action](https://github.com/kiqr/teamable/actions/workflows/rubocop.yml/badge.svg)](https://github.com/kiqr/teamable/actions/workflows/rubocop.yml)
[![RSpec](https://github.com/kiqr/teamable/actions/workflows/rspec.yml/badge.svg)](https://github.com/kiqr/teamable/actions/workflows/rspec.yml)
[![codecov](https://codecov.io/gh/kiqr/teamable/branch/main/graph/badge.svg?token=UZMGXQKJRL)](https://codecov.io/gh/kiqr/teamable)
[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE.md)

Teamable enables role based multi-user accounts (teams/organizations). Teams are represented by the `Account` model. An account can have multiple users associated with it and a user can have multiple accounts. You can think of accounts as a common name for **teams** or **organizations**.

Every user can have one personal account they're admin of, which allows our code to work the same way whether we're adding resources privately for a user or for a team/organization. When a user signs in for the first time, they will be redirected to `new_account_path` and prompted to create their first personal or team account.

### Team resources

**We recommend** you to scope all user resources under accounts instead of users. For example, in an application containing projects, the `Project` model could be declared like this:

```ruby
class Project < ApplicationRecord
  # belongs_to :user <- don't do this.
  belongs_to :account # personal or team account.
end
```

or if you're combining teamable with [acts_as_tenant](https://github.com/ErwinM/acts_as_tenant):

```ruby
class Project < ApplicationRecord
  acts_as_tenant(:account)
end
```

### Switching between accounts

When building your customized account switcher, redirect your user to `switch_account_path`. 

```ruby
current_user.accounts.each do |account|
 button_to account.name, switch_account_path(account), method: :patch
end
```

Installation
------------

Add the following line to Gemfile:

```ruby
gem "teamable", github: "kiqr/teamable" # Use Github repo to use alpha release.
```

and run `bundle install` from your terminal to install it.

Getting started
---------------

**Teamable** expects a `User` model to be present and authenticatable before being installed. It also expects your application to respond properly to `current_user` and `user_signed_in?`. An authentication gem like [Authenticatable](https://github.com/kiqr/authenticatable) is recommended, but this gem should also work great with [Devise](https://github.com/heartcombo/devise), other gems or a custom solution. 

#### Run the install generator

Our next step is to run the install generator. To run the installer run the following command:

```console
$ rails g teamable:install
```

This will generate two models, `Member` & `Account` with configuration for teamable, migration files and `teamable` routes. It will also inject the `Teamable::Models::User` concern into your `User`-model. The output should be something similar to:

```console
foo@bar:~$ rails g teamable:install
      insert  app/models/user.rb
      create  app/models/account.rb
      create  app/models/member.rb
      create  db/migrate/20211010111722_teamable_create_accounts.rb
      create  db/migrate/20211010111723_teamable_create_members.rb
       route  teamable "organizations"
```

Contributing
------------
If you are interested in reporting/fixing issues and contributing directly to the code base, please see [CONTRIBUTING.md](CONTRIBUTING.md) for more information on what we're looking for and how to get started.

Versioning
----------
This library aims to adhere to [Semantic Versioning 2.0.0](http://semver.org/). Violations
of this scheme should be reported as bugs. Specifically, if a minor or patch
version is released that breaks backward compatibility, that version should be
immediately yanked and/or a new version should be immediately released that
restores compatibility. Breaking changes to the public API will only be
introduced with new major versions. As a result of this policy, you can (and
should) specify a dependency on this gem using the [Pessimistic Version
Constraint](http://guides.rubygems.org/patterns/#pessimistic-version-constraint) with two digits of precision. For example:

```ruby
gem "teamable", "~> 1.0"
```

License
-------
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
