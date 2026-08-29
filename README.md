# jinja2.mojo

[![mojoshelf](https://mojoshelf.org/badge/jinja2-mojo.svg)](https://mojoshelf.org/tins/jinja2-mojo) [![mojo nightly](https://mojoshelf.org/badge/jinja2-mojo/nightly.svg)](https://mojoshelf.org/tins/jinja2-mojo)

> 💬 **Community:** questions, ideas, and show-and-tell live in [GitHub Discussions](https://github.com/millfolio/millfolio/discussions).

A Mojo implementation of the **Jinja2 subset used by chat templates** —
render LLM prompt templates (messages loops, conditionals, filters) without
Python in the loop.

## Install as a mojoshelf tin

Published on [mojoshelf](https://mojoshelf.org/tins/jinja2-mojo) as `jinja2-mojo`:

```sh
pixi shelf add jinja2-mojo     # pixi mode (git source dependency)
shelf add jinja2-mojo          # or as a git submodule
```

Maintainers release new versions with `shelf publish` from the repo root
(see [getting started](https://mojoshelf.org/getting-started)).

## Test

```sh
pixi run test
```
