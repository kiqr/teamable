Teamable 
========
[![RuboCop Github Action](https://github.com/kiqr/teamable/actions/workflows/rubocop.yml/badge.svg)](https://github.com/kiqr/teamable/actions/workflows/rubocop.yml)
[![RSpec](https://github.com/kiqr/teamable/actions/workflows/rspec.yml/badge.svg)](https://github.com/kiqr/teamable/actions/workflows/rspec.yml)
[![codecov](https://codecov.io/gh/kiqr/teamable/branch/main/graph/badge.svg?token=UZMGXQKJRL)](https://codecov.io/gh/kiqr/teamable)
[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE.md)

Teamable enables role based multi-user accounts (teams/organizations) that let you share resources within a group of users. Teams are represented by the `Account` model. Teamable will require all users that signs up within your application to create an account. An account can have multiple users associated with it and a user can have multiple accounts. You can think of accounts as a common name for *teams* or *organizations*.

Every user can have one personal account they're admin of, which allows our code to work the same way whether we're adding resources privately for a user or for a team/organization.

When a user signs in for the first time, they will be redirected to `new_account_path` and prompted to create their first personal or team account.

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

Installation
------------

Add the following line to Gemfile:

```ruby
gem "teamable", "~> 1.0"
```

and run `bundle install` from your terminal to install it.

Getting started
---------------

**Teamable** expects a `User` model to be present and authenticatable before being installed. It also expects your application to respond properly to `current_user` and `user_signed_in?`. An authentication gem like [Authenticatable](https://github.com/kiqr/authenticatable) is recommended, but this gem should also work great with [Devise](https://github.com/heartcombo/devise), other gems or a custom solution. 
