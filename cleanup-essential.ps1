# Cleanup script to keep only essential files for extension
Write-Host "Removing unnecessary files from git repository..."

# Remove directories
git rm -r --cached .vscode/ 2>$null
git rm -r --cached SRS-Code-Generator/ 2>$null
git rm -r --cached resources/ 2>$null

# Remove documentation files
git rm --cached EXTENSION_DESCRIPTION.md 2>$null
git rm --cached EXTENSION_SUMMARY.md 2>$null
git rm --cached Extension_Thesis_Explanation.md 2>$null
git rm --cached FEEDBACK_LOOP_INTEGRATION.md 2>$null
git rm --cached FIXES_APPLIED.md 2>$null
git rm --cached FUTURE_WORK_PRIORITY.md 2>$null
git rm --cached GITHUB_FILES_GUIDE.md 2>$null
git rm --cached MULTI_MODEL_SUPPORT.md 2>$null
git rm --cached REPOSITORY_STRUCTURE_PLAN.md 2>$null
git rm --cached ROADMAP.md 2>$null
git rm --cached SHORT_DESCRIPTION.md 2>$null
git rm --cached VENV_LIBRARIES.md 2>$null
git rm --cached VERSIONING_STRATEGY.md 2>$null
git rm --cached ESSENTIAL_FILES_LIST.md 2>$null
git rm --cached GIT_PUSH_INSTRUCTIONS.md 2>$null
git rm --cached cleanup-repo.ps1 2>$null
git rm --cached cleanup-essential.ps1 2>$null

# Remove data files
git rm --cached KerasUnseen_top10.csv 2>$null
git rm --cached Tensorembedded_examples.json 2>$null
git rm --cached actionable_examples.txt 2>$null
git rm --cached pycontracts_deep.txt 2>$null
git rm --cached pycontracts_doc.txt 2>$null
git rm --cached rcontext.txt 2>$null
git rm --cached Research_Context.txt 2>$null

# Remove test files
git rm --cached test.py 2>$null
git rm --cached test_keras_violation*.py 2>$null
git rm --cached test_wrapper*.py 2>$null
git rm --cached gpt_ragtest.js 2>$null
git rm --cached claude_ragtest.js 2>$null

Write-Host ""
Write-Host "Cleanup complete! Files removed from git (but kept locally)."
Write-Host ""
Write-Host "Remaining essential files:"
Write-Host "  - README.md"
Write-Host "  - .gitignore"
Write-Host "  - package.json"
Write-Host "  - package-lock.json"
Write-Host "  - env.example"
Write-Host "  - src/ (all source code)"
Write-Host "  - kerasembedded_examples.json"
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Review: git status"
Write-Host "  2. Commit: git commit -m 'Keep only essential files needed to run extension'"
Write-Host "  3. Push: git push origin main"




