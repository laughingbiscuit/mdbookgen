#!/bin/sh

set -e

# clean
rm -rf target/
mkdir -p target/

# initialise the mdbook and include mermaidjs
(cd target/ && \
  mdbook init --theme --force
  sed -i 's/<\/body>/$LIBS\n<\/body>/' theme/index.hbs
  LIBS='
    <script type="module">
      import mermaid from "https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs";
      mermaidAPI.initialize({
        theme: "neutral",
      });
    </script>' envsubst < theme/index.hbs > theme/index.hbs.new
    mv theme/index.hbs.new theme/index.hbs
)

# split into pages and generate SUMMARY
rm -rf target/src/*
cp notepad.md target/src
(cd target/src && \
  csplit -s -f "notepad-" -b "%02d.md" -z notepad.md '/# .*/' '{*}' && \
  rm notepad.md

  echo "# Summary" > SUMMARY.md
  echo "" >> SUMMARY.md
  for FILE in $(ls . | grep -v "SUMMARY.md"); do
    # rename file removing whitespace and #
    NEW_FILE=`echo $(head -n 1 $FILE) | sed 's/^# //' | sed 's/ //g' | sed 's/$/.md/'`
    mv $FILE $NEW_FILE

    echo "- [$(head -n1 $NEW_FILE | sed 's/^# //')](./$NEW_FILE)" >> SUMMARY.md
  done
)

# add static assets
cp static/* target/src/
