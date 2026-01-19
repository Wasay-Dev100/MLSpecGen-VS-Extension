# Instructions to Push Essential Files to GitHub

The dialog box issue is likely Windows Credential Manager. Here's how to proceed:

## Essential Files to Add

Only these files are needed to run the extension:

1. **README.md** - Documentation
2. **.gitignore** - Git ignore rules (already has .env excluded)
3. **package.json** - Extension manifest
4. **package-lock.json** - Dependency lock file
5. **env.example** - Environment variable template (NOT .env)
6. **src/** - All source code
7. **resources/** - Data files (embeddings, examples, docs)

## Steps to Push

### Option 1: Use PowerShell Script
```powershell
.\add-essential-files.ps1
git commit -m "Add essential extension files"
git push -u origin main
```

### Option 2: Manual Commands
```powershell
# Reset staging
git reset

# Add only essential files
git add README.md
git add .gitignore
git add package.json
git add package-lock.json
git add env.example
git add src/
git add resources/

# Commit
git commit -m "Add essential extension files"

# Push (approve any credential dialogs)
git push -u origin main
```

## Important Notes

✅ **API Key**: Already fixed - uses `process.env.OPENAI_API_KEY`  
✅ **.env file**: Already in .gitignore - won't be pushed  
✅ **env.example**: Template file - safe to push  

## If Credential Dialog Appears

When you push, Windows may ask for GitHub credentials:
- **Username**: Your GitHub username
- **Password**: Use a Personal Access Token (not your password)
  - Generate at: https://github.com/settings/tokens
  - Select `repo` scope

Or use SSH instead:
```powershell
git remote set-url origin git@github.com:Wasay-devops/MLSpecGen-VS-Extension.git
```




