# Simple Notebook

Split a single markdown file by heading, convert into an
`mdbook` project with mermaidjs included.

Just write the contents of your notes in `notepad.md`.

If there is a `static/` directory with images etc, it will be included.

If you want to live-edit the notepad, you can do so in `target/src`, but make sure you copy your changes before running `gen.sh` or 
they will be lost.

This project is `POSIX` compliant, of course.

Tested in `alpine:3.18` with `mdbook` `0.4.40`, `envsubst` from `gettext-0.21.1-r7` and `csplit` from `coreutils-9.3-r2`.
