# Script to add only essential files for the extension
# Run this in PowerShell: .\add-essential-files.ps1

Write-Host "Adding essential files only..."

# Reset staging area
git reset

# Add essential files
git add README.md
git add .gitignore
git add package.json
git add package-lock.json
git add env.example
git add src/
git add resources/

Write-Host "Files staged. Review with: git status"
Write-Host "Then commit with: git commit -m 'Add essential extension files'"
Write-Host "Then push with: git push -u origin main"




