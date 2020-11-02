# papermillR

R bindings for Papermill.

This package was _roughly_ equivalent to what is now [scrapbook](https://github.com/nteract/scrapbook) which allows you to record values into a notebook for programmatic access.

This is now deprecated, and you can use R notebooks with papermill directly [as well as many other languages](https://github.com/nteract/papermill/blob/d5299b0f2705d7a9175c377aa2a2f812c83239e3/papermill/translators.py#L543-L550).

## Install

Install using `devtools`

```r
devtools::install_github("nteract/papermillr")
```

## Use

```
keys = letters[1:5]
values = as.list(1:5)
pm_record(keys, values)
```
