# Quick Reference: uv + ruff Workflow

## Commands

### Dependency Management

```bash
uv sync --extra dev        # Install all dependencies (with dev tools)
uv sync                    # Install only production dependencies
uv.lock                    # ✓ Commit this file for reproducible builds
```

### Code Quality

#### Check without fixing

```bash
make lint
# or
uv run ruff check src/
uv run ruff format --check src/
```

#### Fix and format automatically

```bash
make check
# or
uv run ruff check --fix src/
uv run ruff format src/
```

### Testing

```bash
make test
# or
uv run pytest src/ -v           # Verbose output
uv run pytest src/ -v --cov     # With coverage
```

### One-line Validation

```bash
make lint && make test
# CI/CD: uv sync --extra dev && make lint && make test
```

## Configuration Files

| File | Purpose |
|------|---------|
| `pyproject.toml` | Python project metadata, ruff/pytest config |
| `uv.lock` | Locked dependency versions (reproducible builds) |
| `Makefile` | Task automation: sync, lint, check, test |

## Files Modified

1. **pyproject.toml**
   - Updated Python version requirement: >=3.9
   - Fixed ruff configuration
   - Organized dependencies

2. **Makefile**
   - Added: `make sync`, `make lint`, `make check`, `make test`
   - Python targets use `uv run` for consistency

3. **src/test_example.py**
   - Removed deprecated UTF-8 encoding declaration
   - Fixed import sorting
   - Modernized string formatting

## Default Targets

```bash
make              # builds public/index.html and public/quickcheck.pdf (via pandoc)
make check        # format and fix code
make lint         # check code style (no fixes)
make test         # run pytest suite
make sync         # initialize/update dependencies
make clean        # remove build artifacts (public/)
```

## Troubleshooting

**"pytest: command not found"** → Run `make sync` first, then use `make test` or
`uv run pytest`

**Dependencies out of sync** → Run `uv sync --extra dev` to update `uv.lock`

**Ruff warnings after editing** → Run `make check` to auto-fix most issues

## Integration Tips

### Pre-commit hook

```bash
#!/bin/bash
make lint
```

### GitHub Actions

```yaml
- name: Lint and test
  run: uv sync --extra dev && make lint && make test
```
