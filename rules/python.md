# Python

Used for research scripts and SDKs, not services. Keep it small.

- `pyproject.toml` is the single source of metadata. `uv` for envs and locking.
- Type hints on every signature. `from __future__ import annotations`. `collections.abc` types in signatures.
- Ruff for lint and format. mypy or pyright in strict mode when the codebase is bigger than a script.
- Dataclasses or Pydantic over dicts for structured data. pathlib over os.path. f-strings.
- Specific exceptions only. No bare `except`. Context managers for resources.
- pytest, fixtures over setup/teardown, `parametrize` for data-driven cases.
- `__init__.py` files stay minimal.
