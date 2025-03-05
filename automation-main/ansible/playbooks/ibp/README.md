IBP Ansible Playbooks
=====================

This repository includes all of the shared Ansible playbooks that are used by
Integrated Business Planning (IBP) environments.

Use of pre-commit
-----------------

[pre-commit](https://pre-commit.com) is used in this repository to make sure
that all commits that are made meet the coding standards/style and that it is
enforced. CI will also enforce the exact same standards.

For macOS using Homebrew:

```
brew install pre-commit
```

Then to install the Git hook:

```
pre-commit install
```

If you need to one-time cleanup a bunch of files or if you had not installed
pre-commit and CI failed, please run:

```
pre-commit run --all-files
git add .
git commit -m "Lint all files"
```

This should be done as an exception, to reduce the amount of commits that touch
a large number of files with stylistic changes vs changes of substance.

