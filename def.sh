#!/bin/bash

FUNC_FILE=~/.bash_funcs

if [ ! -f "$FUNC_FILE" ]; then
echo "Setting up default function file: ${FUNC_FILE}"
echo "Don't forget to source it from .bashrc or equivalent!"

cat > $FUNC_FILE <<'EOF'
# used by def.sh to save and source custom bash functions

# don't change this one ;)
def() { source ~/cbin/def.sh "$@"; }
export -f def

# custom functions
EOF

fi

if [ "$#" -lt "2" ]; then
  echo "Usage: def <function name> <command>"
  echo
  sed '1,/# custom functions/d' ~/.bash_funcs | grep -v "export -f" | sort
  # don't exit here; this script is re-sourced when it is run,
  # so that would kill any terminal that used it
else
  echo "${1}() { ${@:2}; }" >> $FUNC_FILE
  echo "export -f ${1}" >> $FUNC_FILE
  source $FUNC_FILE
fi

