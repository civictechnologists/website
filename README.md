# civictechnologists.org

The website of the Alliance of Civic Technologists:

https://www.civictechnologists.org/

## Contributing to the website

This website is built with Jekyll, which is a Ruby static site builder.

- New blog posts can be created by copying an existing post in `_posts/` and editing the filename and metadata at the top of the file.
- Existing pages can be edited, in HTML and/or markdown. If you want to embed markdown _within_ HTML tags put your content between`<div markdown="1">` and `</div>`.

## Developing the website

This site is set up as a standard Ruby project with Bundler. To get started:

1. Use a Ruby version manager, like rbenv, rvm, or chruby. 
    1. On a Mac, this can be installed with homebrew: `brew install rbenv`. 
    1. Then install the Ruby version specified in `.ruby-version`: `rbenv install $(cat .ruby-version)`
1. Run bundler to install dependencies: `bundle install`
1. Start the jekyll webserver: `bundle exec jekyll serve`
