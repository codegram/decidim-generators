#!/bin/bash

set -e

bundle exec rubocop
echo "My Dummy Component" | bundle exec bin/decidim-generators engine my_component
cd decidim-module-my_component && bundle exec rubocop
