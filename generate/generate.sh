#!/bin/bash

# Replace {{ github-repository-placeholder }} with {{github-repository}} in cliff.toml
sed -i '' 's/{{github-repository-placeholder}}/https:\/\/github.com\/{{github-username}}\/{{github-repository}}/g' cliff.toml

# Create remote repository and link it to local repository
gh repo create {{github-username}}/{{github-repository}} --public

# Execute release-plz init
release-plz init

# Generate Codecov token and open settings page
codecov_url="https://app.codecov.io/github/{{github-username}}/{{github-repository}}/settings/"
if command -v xdg-open &> /dev/null; then
    xdg-open "$codecov_url"
elif command -v open &> /dev/null; then
    open "$codecov_url"
else
    echo "Please visit $codecov_url to set up Codecov"
fi

# Link Mergify
mergify_url="https://dashboard.mergify.com/integrations/github?repository={{github-username}}/{{github-repository}}&login={{github-username}}"
if command -v xdg-open &> /dev/null; then
    xdg-open "$mergify_url"
elif command -v open &> /dev/null; then
    open "$mergify_url"
else
    echo "Please visit $mergify_url to set up Mergify"
fi
