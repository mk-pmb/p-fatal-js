#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-


function why () {
  export LANG{,UAGE}=en_US.UTF-8  # make error messages search engine-friendly
  local SELFPATH="$(readlink -m "$BASH_SOURCE"/..)"
  cd -- "$SELFPATH" || return $?

  local TESTNAME='"why" test'
  local MODULES=(
    perish
    p-fatal
    )
  local STAGE= MOD= ERR_CNT=0
  for MOD in "${MODULES[@]}"; do
    for STAGE in early late; do
      test_why "$STAGE" "$MOD"
    done
  done

  [ "$ERR_CNT" == 0 ] || return 4$(
    echo "-ERR $TESTNAME failed $ERR_CNT tests." >&2)
  echo "+OK $TESTNAME passed"
}


function test_why () {
  local RQR_WHEN="$1"; shift
  local RQR_NAME="$1"; shift
  export REQUIRE_LATE=
  export REQUIRE_EARLY=
  export REQUIRE_"${RQR_WHEN^^}"="$RQR_NAME"

  local LOG_EXP="$RQR_NAME.$RQR_WHEN.log"
  local LOG_ACT="tmp.$RQR_NAME.$RQR_WHEN.$(date +%y%m%d-%H%M%S)-$$.log"

  nodejs -r esm why.js |& sed -rf <(echo '
    /^\s*at /s~(:[0-9]+){2}\)$~:…:…)~
    ') | sed -rf <(echo '
    : read_all
    $!{N;b read_all}
    s~(\n\s*at (\S+ \(|))/\S+/~\1…/~g
    s~((\n\s*at [^\n]+){3}\n\s*at |$\
      )[^\n]+(\n\s*at [^\n]+)*~\1…~g
    ') >"$LOG_ACT"
  if diff -sU 9002 -- "$LOG_EXP" "$LOG_ACT"; then
    rm -- "$LOG_ACT"
    return 0
  fi
  echo
  echo "-ERR $TESTNAME failed for $LOG_EXP" >&2
  (( ERR_CNT += 1 ))
}










[ "$1" == --lib ] && return 0; why "$@"; exit $?
