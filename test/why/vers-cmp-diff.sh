#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-


function vers_cmp_diff_cli_init () {
  export LANG{,UAGE}=en_US.UTF-8  # make error messages search engine-friendly
  local SELFPATH="$(readlink -m -- "$BASH_SOURCE"/..)"
  cd -- "$SELFPATH" || return $?
  local BEST_DIFF="$(which colordiff diff |& grep -m 1 -Pe '^/')"
  local SUB= BFN= PREV= CRNT= NEXT=
  for SUB in expect.*/ ; do
    [ -L "${SUB%/}" ] && continue
    BFN="$(find "$SUB" -mindepth 2 -maxdepth 2 -type f \
      -name '*.log' -printf '%f\n' | sort -Vu)"
    for BFN in $BFN; do
      PREV=
      CRNT=
      for NEXT in "$SUB"*/"$BFN" ''; do
        PREV="$CRNT"
        CRNT="$NEXT"
        [ -n "$PREV" ] || continue
        [ -n "$CRNT" ] || continue
        [ -L "$PREV" ] && [ -L "$CRNT" ] && continue
        $BEST_DIFF -sU 2 -- "$PREV" "$CRNT" | sed -re '$s~$~\n~'
      done
    done
  done
}










vers_cmp_diff_cli_init "$@"; exit $?
