# Huginn.io [![Build Status](https://travis-ci.org/dsander/huginn.io.svg?branch=master)](https://travis-ci.org/dsander/huginn.io) [![Coverage Status](https://coveralls.io/repos/github/dsander/huginn.io/badge.svg?branch=add-travis)](https://coveralls.io/github/dsander/huginn.io?branch=add-travis) [![Code Climate](https://codeclimate.com/github/dsander/huginn.io/badges/gpa.svg)](https://codeclimate.com/github/dsander/huginn.io)

## Import Agent Gems and Agents from Huginn into Huginn.io

* Copy `.env.example` to `.env`
* Get a [GitHub API Key](https://github.com/settings/tokens) and put it in `.env`
* Have Huginn installed and configured in `../huginn` relative to the root path of this repository
* Run `rake db:seed`

## Import Agent Gems and Agents from precomputed JSON

When `rake db:seed` is called with the `AGENT_JSON` environment variable set to a valid URI the JSON data will be used to import the agents

```
AGENT_JSON=https://dl.dropboxusercontent.com/u/62784372/agents.json rake db:seed
``
