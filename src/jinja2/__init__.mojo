"""`jinja2` — a Mojo implementation of the Jinja2 subset for chat templates.

Public API, re-exported so consumers can `from jinja2 import Template, Value,
parse_json`. Internal modules (lexer, parser, ast, eval, strftime) stay
importable as `jinja2.<module>` but are not part of the stable surface.
"""

from jinja2.template import Template
from jinja2.value import (
    Value,
    values_equal,
    VUNDEF,
    VNONE,
    VBOOL,
    VINT,
    VFLOAT,
    VSTR,
    VLIST,
    VMAP,
    VCALL,
)
from jinja2.json import parse_json, to_json, bytes_to_string, string_to_bytes
