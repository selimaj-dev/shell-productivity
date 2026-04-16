function postpr {
    # Save current branch
    $current_branch = git symbolic-ref --short HEAD

    if ($current_branch -eq "master") {
        Write-Host "You are already on master!"
        return
    }

    # Switch to master
    git checkout master
    if ($LASTEXITCODE -ne 0) { return }

    # Pull latest changes
    git pull origin master
    if ($LASTEXITCODE -ne 0) { return }

    # Delete previous branch locally
    git branch -d $current_branch
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to delete branch $current_branch. Maybe unmerged changes?"
    }

    Write-Host "Switched to master, pulled latest, and deleted branch $current_branch"
}

function gpr {
    param($branch)

    git checkout -b $branch
    if ($LASTEXITCODE -ne 0) { return }

    git push origin $branch
    if ($LASTEXITCODE -ne 0) { return }

    git checkout master
    git branch -D $branch
}

function gc {
    param([string]$msg)
    git commit -am "$msg"
}

function ga {
    git add -A
}

function gp {
    git pull
}
