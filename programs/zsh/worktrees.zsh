_zroot() {
  git rev-parse --path-format=absolute --git-common-dir | sed 's|/\.git$||'
}

_zw() {
  local root="$(_zroot)"
  local wt="$root/.claude/worktrees/$1"
  if [[ -d "$wt" ]]; then
    cd "$wt"
  else
    git fetch origin
    git worktree add "$wt" -b "$1" origin/main 2>/dev/null || \
      git worktree add "$wt" "$1"
    cd "$wt"
  fi
}
