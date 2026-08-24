"""Unit tests for the jinja2.mojo template engine.

Covers the JSON/value helpers plus end-to-end rendering of the template
features the chat templates rely on: variable substitution, if/elif/else,
for loops, `set`, the `tojson` filter, and template-authored
`raise_exception`. Run via `pixi run test`.
"""

from jinja2.json import parse_json, to_json
from jinja2.value import Value, values_equal
from jinja2.template import Template


def _check(cond: Bool, msg: String) raises:
    if not cond:
        raise Error("FAIL: " + msg)
    print("ok:", msg)


def _render(source: String, ctx_json: String) raises -> String:
    """Compile `source` and render it against a JSON-object context."""
    var tmpl = Template.compile(source)
    return tmpl.render(parse_json(ctx_json), 0)


def main() raises:
    # ── value/json helpers ────────────────────────────────────────────────
    var v = parse_json('{"b":1,"a":2}')
    _check(to_json(v, 0) == '{"b": 1, "a": 2}', "tojson preserves key order")
    _check(
        to_json(parse_json('"h<i>"'), 0) == '"h\\u003ci\\u003e"',
        "tojson html-escape",
    )
    _check(values_equal(Value.int(1), Value.bool(True)), "1 == True")

    # ── variable substitution ─────────────────────────────────────────────
    _check(
        _render("Hello {{ name }}!", '{"name":"World"}') == "Hello World!",
        "var substitution",
    )

    # ── if / else ─────────────────────────────────────────────────────────
    var cond = "{% if x %}yes{% else %}no{% endif %}"
    _check(_render(cond, '{"x":true}') == "yes", "if true branch")
    _check(_render(cond, '{"x":false}') == "no", "if false (else) branch")

    # ── elif ──────────────────────────────────────────────────────────────
    var grade = (
        "{% if n == 1 %}one{% elif n == 2 %}two{% else %}many{% endif %}"
    )
    _check(_render(grade, '{"n":2}') == "two", "elif branch")
    _check(_render(grade, '{"n":9}') == "many", "elif else branch")

    # ── for loop ──────────────────────────────────────────────────────────
    _check(
        _render(
            "{% for i in items %}{{ i }}{% endfor %}", '{"items":["a","b","c"]}'
        )
        == "abc",
        "for loop over list",
    )
    # for over a list of dicts with member access + a separator
    var msgs = (
        "{% for m in messages %}{{ m['role'] }}:{{ m['content'] }};{% endfor %}"
    )
    _check(
        _render(
            msgs,
            '{"messages":[{"role":"user","content":"hi"},{"role":"bot","content":"yo"}]}',
        )
        == "user:hi;bot:yo;",
        "for loop over list of dicts",
    )

    # ── set ───────────────────────────────────────────────────────────────
    _check(_render("{% set g = 'hi' %}{{ g }}", "{}") == "hi", "set assignment")

    # ── tojson filter ─────────────────────────────────────────────────────
    _check(
        _render("{{ o | tojson }}", '{"o":{"k":1}}') == '{"k": 1}',
        "tojson filter",
    )

    # ── raise_exception surfaces as a render error ────────────────────────
    var raised = False
    try:
        _ = _render("{{ raise_exception('boom') }}", "{}")
    except e:
        raised = True
    _check(raised, "raise_exception propagates")

    print("ALL UNIT TESTS PASSED")
