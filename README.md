# Hanuman

[![Circle CI](https://circleci.com/gh/cesare/hanuman.svg?style=svg)](https://circleci.com/gh/cesare/hanuman)

TBD

## Prerequisites for development

* Ruby 2.1.x or later
* PostgreSQL

## Setup

### Provider IDs and Secrets

Create `config/settings/development.local.yml` like this:

```yaml
providers:
  # Register your application with https://github.com/settings/applications
  github:
    key: YOUR_GITHUB_CLIENT_ID
    secret: YOUR_GITHUB_CLIENT_SECRET
```

### Create database.yml

Create the file, or

```bash
$ cp config/database.yml.sample config/database.yml
```
