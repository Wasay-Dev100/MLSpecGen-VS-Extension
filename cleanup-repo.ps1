# Script to remove unnecessary files from repository
# Run: .\cleanup-repo.ps1

Write-Host "Removing unnecessary files from git..."

# Remove files from git (but keep them locally)
git rm -r --cached .vscode/ 2>$null
git rm -r --cached SRS-Code-Generator/ 2>$null
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
git rm --cached KerasUnseen_top10.csv 2>$null
git rm --cached Tensorembedded_examples.json 2>$null
git rm --cached kerasembedded_examples.json 2>$null
git rm --cached actionable_examples.txt 2>$null
git rm --cached pycontracts_deep.txt 2>$null
git rm --cached pycontracts_doc.txt 2>$null
git rm --cached rcontext.txt 2>$null
git rm --cached Research_Context.txt 2>$null
git rm --cached test.py 2>$null
git rm --cached test_*.py 2>$null
git rm --cached test_wrapper*.py 2>$null
git rm --cached gpt_ragtest.js 2>$null
git rm --cached claude_ragtest.js 2>$null

Write-Host "Files removed from git. Review with: git status"
Write-Host "Then commit with: git commit -m 'Remove unnecessary files, keep only essentials'"
Write-Host "Then push with: git push origin main"




