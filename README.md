# civictechnologists.org

The website of the Alliance of Civic Technologists:

https://www.civictechnologists.org/

## Contributing to the website

This website is built with Jekyll, which is a Ruby static site builder.

- New blog posts can be created by copying an existing post in `_posts/` and editing the filename and metadata at the top of the file.
- Existing pages can be edited, in HTML and/or markdown. If you want to embed markdown _within_ HTML tags put your content between`<div markdown="1">` and `</div>`.

### Making changes via GitHub, for less-technical authors/editors

With a GitHub account, you can make edits to existing posts/pages or create new pages/posts entirely through the GitHub website interface.

#### Simple edits to an existing file

1. Find the file either by searching for text or by navigating within the file browser. View the file by clicking on it.
1. Click the small Pencil icon for "Edit this file". This should bring up an editor. Make your changes.
1. Click the "Commit changes..." button. This will bring up a modal to describe the change in the name of the Commit, and to choose a Branch name; you can use the default generated branch name (do not use the `main` branch option)
1. Create a Pull Request. This will notify the website maintainer to review your changes and merge them into the `main` branch which will update the live website.

<img src="/DOCS/images/file-edit.jpg" alt="Image of GitHub file browser showing a file with a Pencil icon next to it. Clicking the Pencil icon will bring up an editor for the file.">

<img src="/DOCS/images/file-add.jpg" alt="Image of GitHub file browser show Add file which will create a new file.">

<img src="/DOCS/images/commit-modal.jpg" alt="Image of GitHub form for authoring a new Commit on a new Branch.">

#### Making multiple edits to multiple existing files or adding new files

Making more complex edits requires some conceptual understanding of how Git and GitHub work.

- A **Commit** is a set of file changes. When making changes through the GitHub website you can only change one file at a time; that means that to add or edit multiple files via the GitHub website, you will need to make multiple Commits.
- A **Branch** is a collection of Commits (imagine a bucket). The `main` Branch of a project is a special Branch that corresponds to the live website. When proposing changes, you will create a new Branch with your new Commits in it.
- A **Pull Request** is a GitHub feature that makes it easy to review the contents of a Branch and decide whether to dump the Commits from one Branch into a different Branch. In this scenario, you are proposing to dump the edits in your Commits in your Branch _into_ the `main` Branch of the website. When a Pull Request is reviewed by a maintainer, they will choose whether to merge it or give feedback or request changes.

Those are the concepts. To make the actual changes you will:

1. Follow the directions as if this is a simple edit by making a single change and opening a Pull Request.
1. Click the blue-highlighted Branch name at the top of your Pull Request. This will open the File Browser _within the Branch you created in the previous step_.
1. Make additional edits and changes in the same manner as before, but when given the option, create the Commits _all on that same Branch_. You should see all of the commits and changes within your singular Pull Request.

<img src="/DOCS/images/pr-branch-link.jpg" alt="Image of a GitHub Pull Request explaining that to open the File Browser on the Pull Request's branch, click the Branch name link at the top of the Pull Request.">

## Developing the website

This site is set up as a standard Ruby project with Bundler. To get started:

1. Use a Ruby version manager, like rbenv, rvm, or chruby.
    1. On a Mac, this can be installed with homebrew: `brew install rbenv`.
    1. Then install the Ruby version specified in `.ruby-version`: `rbenv install $(cat .ruby-version)`
1. Run bundler to install dependencies: `bundle install`
1. Start the jekyll webserver: `bundle exec jekyll serve`
