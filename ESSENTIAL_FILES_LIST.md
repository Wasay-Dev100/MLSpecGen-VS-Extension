# Essential Files for Extension to Run

## ✅ REQUIRED Files:

1. **package.json** - Extension manifest (defines extension, commands, dependencies)
2. **package-lock.json** - Dependency lock file (ensures exact versions)
3. **src/** - All source code (extension.js, services, rag, utils, webview)
4. **kerasembedded_examples.json** - Required by embeddedData.js (the 79 Keras examples)
5. **README.md** - Documentation (helpful for users)
6. **.gitignore** - Git configuration (excludes .env, node_modules, etc.)
7. **env.example** - Template for environment variables (shows what's needed)

## ❌ NOT Required (but currently in repo):

- `resources/` - Not directly used (data is embedded in embeddedData.js)
- All `.md` documentation files (EXTENSION_*.md, etc.) - Nice to have but not needed to run
- Test files (test_*.py) - Not needed to run extension
- CSV files - Not needed to run extension
- `.vscode/` - IDE settings, not needed
- `SRS-Code-Generator/` - Separate project

## Summary

**Minimum to run extension:**
- package.json
- package-lock.json  
- src/
- kerasembedded_examples.json
- env.example (for setup instructions)

**Nice to have:**
- README.md (documentation)
- .gitignore (git config)




