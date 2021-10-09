Teamable 
========
[![RuboCop Github Action](https://github.com/kiqr/teamable/actions/workflows/rubocop.yml/badge.svg)](https://github.com/kiqr/teamable/actions/workflows/rubocop.yml)
[![RSpec](https://github.com/kiqr/teamable/actions/workflows/rspec.yml/badge.svg)](https://github.com/kiqr/teamable/actions/workflows/rspec.yml)
[![codecov](https://codecov.io/gh/kiqr/teamable/branch/main/graph/badge.svg?token=UZMGXQKJRL)](https://codecov.io/gh/kiqr/teamable)
[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE.md)

**Teamable** expects a `User` model to be present and authenticatable before being installed. It also expects your application to respond properly to `current_user` and `user_signed_in?`. [Authenticatable](https://github.com/kiqr/authenticatable) is recommended, but this gem should also work great with [Devise](https://github.com/heartcombo/devise). 