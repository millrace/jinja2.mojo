"""Backward-compat shim: the code moved into the `jinja2` package.

Consumers on `-I …/jinja2.mojo/src` keep importing `from template import
Template`; new code should prefer `from jinja2 import Template`.
"""

from jinja2.template import Template, RenderResult
