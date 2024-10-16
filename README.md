# GitHub patcher

This repository is for scripts that apply fixes to GitHub repositories.
It relies on the [gh][] command-line interface to fork repositories and
submit pull requests.

To create a new patcher, open a new directory and copy an existing patcher.
Edit the script to set the branch name, patching commands and commit message.
For simple PR message bodies, use `-b`. For longer, use `-F` and provide a
Markdown file.

To operate, use `./patch <GH-ORG>/<REPO>`.


[gh]: https://github.com/cli/cli
