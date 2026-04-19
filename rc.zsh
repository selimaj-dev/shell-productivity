# Silently remove any conflicting aliases
unalias postpr 2>/dev/null
unalias gpr 2>/dev/null
unalias gc 2>/dev/null
unalias ga 2>/dev/null
unalias gp 2>/dev/null
unalias oc 2>/dev/null

# --- Functions ---

postpr() {
  # Save current branch
  local current_branch
  current_branch=$(git symbolic-ref --short HEAD)

  if [[ "$current_branch" == "master" ]]; then
    echo "You are already on master!"
    return 1
  fi

  # Switch to master
  git checkout master || return 1

  # Pull latest changes
  git pull origin master || return 1

  # Delete previous branch locally
  git branch -d "$current_branch" || echo "Failed to delete branch $current_branch. Maybe unmerged changes?"

  echo "Switched to master, pulled latest, and deleted branch $current_branch"
}

gpr() {
  git checkout -b $1
  git push origin $1
  git checkout master
  git branch -D $1
}

gc() {
  git commit -am $1
}

ga() {
  git add -A
}

gp() {
  git pull
}


oc() {
  opencode
}
