"""Backward-compat shim: the code moved into the `jinja2` package.

Consumers on `-I …/jinja2.mojo/src` keep importing `from json import
parse_json`; new code should prefer `from jinja2 import parse_json`. (The
standalone community `json` package is a different module — which one a
`from json import …` resolves to depends on `-I` order, exactly as before.)
"""

from jinja2.json import (
    parse_json,
    to_json,
    bytes_to_string,
    string_to_bytes,
    _b,
)
