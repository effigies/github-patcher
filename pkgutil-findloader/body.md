This PR removes [pkgutil.find_loader()][] and replaces it with [importlib.util.find_spec()][]. `find_loader` was deprecated in Python 3.12 and will be removed in 3.14. `find_spec` has been present since Python 3.4.

Both functions return `None` if the module loader cannot be found. For its use in this project, this is sufficient and no translation of the return value is needed.

[pkgutil.find_loader()]: https://docs.python.org/3/library/pkgutil.html#pkgutil.get_loader
[importlib.util.find_spec()]: https://docs.python.org/3/library/importlib.html#importlib.util.find_spec
