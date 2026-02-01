# Thoughts on Random Number Generators - QuickCheck

This is part 2 in the series on Random numbers. The series contains:

- [Random Number Generators in bash scripts](https://frankhjung.github.io/article-random-bash)
- [Random Number Generators to test code](https://frankhjung.github.io/article-random-quickcheck/)
- [Random Number Generators in simulation](https://frankhjung.github.io/article-random-simulation)

See also <https://frankhjung.blogspot.com/>.

## Render to HTML

To render an HTML or PDF version of this article, run:

```bash
make quickcheck.html
make quickcheck.pdf
```

Or simply run `make` to build both.

This will generate documents into the `public` directory, which is used to
publish rendered pages.

## Java JUnit-QuickCheck Examples

The Git project contains full API documentation and source code for examples
using both traditional JUnit tests and QuickCheck style tests. The code example
is a program to count words from STDIN like the
[wc(1)](https://linux.die.net/man/1/wc) command.

## Python Hypothesis Examples

Some examples using [Hypothesis](https://hypothesis.readthedocs.io/en/latest/).

To use strategies, try:

```python
from hypothesis.strategies import lists, integers

integers().example()
Out[2]: 8448

lists(integers(), min_size=5, max_size=10).example()
Out[3]: [22, -108, 6137, -15222, -6307496272059922727, -125, -4, -30, 20459]
```

The `example` method should only be used interactively.

### Set up environment with UV

Initialise the project environment with all dependencies:

```bash
uv sync --extra dev
```

This installs all project dependencies including development tools (pytest,
ruff, hypothesis, etc.) as defined in `pyproject.toml`.

### Validate Code

Format and lint code:

```bash
make check
```

Or to just check without modifying:

```bash
make lint
```

### Run Test Code

```bash
make test
```

To get runtime statistics:

```bash
uv run pytest -v --hypothesis-show-statistics src/test_example.py
```

#### Results

We have forced an error, so you can see what it produces.

```text
$ pytest -v --hypothesis-show-statistics src/test_example.py

============================= test session starts ==============================
platform linux -- Python 3.7.5rc1, pytest-5.0.0, py-1.8.0, pluggy-0.13.0 -- /home/frank/documents/articles/quickcheck/venv/bin/python3
cachedir: .pytest_cache
hypothesis profile 'default' -> database=DirectoryBasedExampleDatabase('/home/frank/documents/articles/quickcheck/.hypothesis/examples')
metadata: {'Python': '3.7.5rc1', 'Platform': 'Linux-5.2.0-3-amd64-x86_64-with-debian-bullseye-sid', 'Packages': {'pytest': '5.0.0', 'py': '1.8.0', 'pluggy': '0.13.0'}, 'Plugins': {'hypothesis': '4.40.1', 'metadata': '1.8.0', 'cov': '2.7.1', 'html': '1.21.1'}, 'JAVA_HOME': '/usr/lib/jvm/default-java'}
rootdir: /home/frank/documents/articles/quickcheck
plugins: hypothesis-4.40.1, metadata-1.8.0, cov-2.7.1, html-1.21.1
collecting ... collected 4 items

src/test_example.py::test_email PASSED                                   [ 25%]
src/test_example.py::test_sorting_list_of_integers PASSED                [ 50%]
src/test_example.py::test_shuffle_is_noop FAILED                         [ 75%]
src/test_example.py::test_alphanumeric PASSED                            [100%]

============================== 1 xfailed, 3 passed ===============================
```
