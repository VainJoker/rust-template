# Replace {{github-repository-placeholder}} with {{github-repository}} in cliff.toml
(Get-Content -Path cliff.toml) -replace '<<github-repository-placeholder>>', 'https://github.com/{{github-username}}/{{github-repository}}' | Set-Content -Path cliff.toml

# Create remote repository and link it to local repository
gh repo create {{github-username}}/{{github-repository}} --public

# Execute release-plz init
release-plz init

# Generate Codecov token and open settings page
$codecov_url = "https://app.codecov.io/github/{{github-username}}/{{github-repository}}/settings/"
Start-Process $codecov_url

Write-Host "Please complete the Codecov setup in the opened browser window."
Write-Host "Press Enter when you've finished setting up Codecov..."
Read-Host

# Link Mergify
$mergify_url = "https://dashboard.mergify.com/workflow-automation?repository={{github-repository}}&login={{github-username}}"
Start-Process $mergify_url

Write-Host "Please complete the Mergify setup in the opened browser window."
Write-Host "Press Enter when you've finished setting up Mergify..."
Read-Host

Write-Host "Setup process completed."
