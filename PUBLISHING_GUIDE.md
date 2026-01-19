# Publishing to VS Code Extension Marketplace

This guide walks you through publishing your ML Contract Violation Detector extension to the VS Code Extension Marketplace.

## Prerequisites

1. **Microsoft Account**: You need a Microsoft account (can use GitHub account)
2. **Azure DevOps Organization**: Create a free organization at https://dev.azure.com
3. **Personal Access Token (PAT)**: Generate one for publishing extensions

## Step 1: Create Azure DevOps Organization

1. Go to https://dev.azure.com
2. Sign in with your Microsoft account
3. Create a new organization (or use existing)
4. Note your organization name (e.g., `your-org-name`)

## Step 2: Generate Personal Access Token (PAT)

1. In Azure DevOps, click your profile icon → **Security**
2. Click **Personal access tokens** → **+ New Token**
3. Configure:
   - **Name**: `VS Code Extension Publishing`
   - **Organization**: Select your organization
   - **Expiration**: Set appropriate duration (e.g., 1 year)
   - **Scopes**: Select **Custom defined**
   - **Marketplace**: Select **Manage** (full access)
4. Click **Create**
5. **Copy the token immediately** (you won't see it again!)

## Step 3: Install VS Code Extension Manager (vsce)

```bash
npm install -g @vscode/vsce
```

## Step 4: Update package.json

Before publishing, update your `package.json`:

### Required Changes:

1. **Publisher Name**: Replace `"your-publisher-name"` with your actual publisher ID
   - This will be your Azure DevOps organization name or a custom ID
   - Must be lowercase, alphanumeric, and hyphens only
   - Example: `"publisher": "your-username"` or `"publisher": "ml-contracts"`

2. **Repository URL** (recommended):
   ```json
   "repository": {
     "type": "git",
     "url": "https://github.com/your-username/your-repo.git"
   }
   ```

3. **License** (required):
   ```json
   "license": "MIT"
   ```

4. **Icon** (recommended):
   ```json
   "icon": "icon.png"
   ```
   - Create a 128x128 PNG icon
   - Place it in the root directory

5. **Keywords** (recommended):
   ```json
   "keywords": [
     "machine-learning",
     "ml",
     "contracts",
     "pycontracts",
     "tensorflow",
     "keras",
     "pytorch",
     "api-violations",
     "rag",
     "linting"
   ]
   ```

6. **Gallery Banner** (optional but recommended):
   ```json
   "galleryBanner": {
     "color": "#1e1e1e",
     "theme": "dark"
   }
   ```

## Step 5: Create LICENSE File

Create a `LICENSE` file in the root directory. For MIT License:

```
MIT License

Copyright (c) 2024 [Your Name]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## Step 6: Create Extension Icon (Optional but Recommended)

1. Create a 128x128 PNG image
2. Name it `icon.png`
3. Place it in the root directory
4. Update `package.json` to reference it

## Step 7: Login to vsce

```bash
vsce login <your-publisher-name>
```

When prompted, enter your Personal Access Token (PAT) from Step 2.

**Alternative**: You can also set the token as an environment variable:
```bash
# Windows PowerShell
$env:VSCE_PAT="your-personal-access-token"

# Linux/Mac
export VSCE_PAT="your-personal-access-token"
```

## Step 8: Package Your Extension

Before publishing, package it to test:

```bash
vsce package
```

This creates a `.vsix` file. You can install it locally to test:
- In VS Code: `Extensions` → `...` → `Install from VSIX...`

## Step 9: Publish Your Extension

### First Time Publishing:

```bash
vsce publish
```

This will:
1. Package your extension
2. Upload it to the marketplace
3. Make it available for installation

### Updating an Existing Extension:

```bash
# Update version in package.json first (e.g., 0.1.0 → 0.1.1)
vsce publish
```

**Version Format**: Use semantic versioning (e.g., `1.0.0`, `1.0.1`, `1.1.0`)

## Step 10: Verify Publication

1. Go to https://marketplace.visualstudio.com/vscode
2. Search for your extension name
3. Your extension should appear in the results

## Important Notes

### Environment Variables

Your extension uses `process.env.OPENAI_API_KEY`. Users will need to:
1. Set this in their system environment variables, OR
2. Use a `.env` file (if you add dotenv support)
3. Configure it in VS Code settings (if you add settings support)

**Consider adding**: A VS Code setting for the API key so users can configure it directly in VS Code.

### Required Files Checklist

Before publishing, ensure you have:
- [x] `package.json` with correct publisher name
- [ ] `LICENSE` file
- [ ] `README.md` (you have this)
- [ ] `icon.png` (128x128, recommended)
- [ ] All source files in `src/`
- [ ] `kerasembedded_examples.json` (required by your extension)
- [ ] `.gitignore` properly configured
- [ ] No hardcoded API keys or secrets

### Files to Exclude from Package

The `.vscodeignore` file (if it exists) or `vsce` will automatically exclude:
- `node_modules/` (unless needed)
- `.git/`
- Test files
- Development files

Create a `.vscodeignore` file if you need to exclude additional files:

```
.vscode/**
.vscode-test/**
src/**
.gitignore
.env
.env.local
*.vsix
ml-contract-outputs/**
test_*.py
*.log
```

**Note**: Only include files needed for the extension to run. The `out/` folder with bundled code should be included.

## Troubleshooting

### Error: "Extension name not found"
- Make sure you've logged in: `vsce login <publisher-name>`
- Verify your publisher name matches in `package.json`

### Error: "Access Denied"
- Check your PAT has "Manage" scope for Marketplace
- Regenerate PAT if needed

### Error: "Invalid publisher"
- Publisher name must be lowercase, alphanumeric, hyphens only
- Must match your Azure DevOps organization or be registered

### Extension too large
- Use `.vscodeignore` to exclude unnecessary files
- Don't include `node_modules/` unless absolutely necessary
- Bundle your code (you're already doing this with esbuild)

## Post-Publication

1. **Share your extension**: Share the marketplace URL
2. **Monitor feedback**: Check reviews and issues
3. **Update regularly**: Fix bugs and add features
4. **Version updates**: Always bump version in `package.json` before publishing updates

## Marketplace URL Format

Once published, your extension will be available at:
```
https://marketplace.visualstudio.com/items?itemName=<publisher-name>.<extension-name>
```

Example:
```
https://marketplace.visualstudio.com/items?itemName=ml-contracts.ml-contract-extension
```

## Additional Resources

- [VS Code Extension Publishing Guide](https://code.visualstudio.com/api/working-with-extensions/publishing-extension)
- [vsce CLI Documentation](https://github.com/microsoft/vscode-vsce)
- [Extension Manifest Reference](https://code.visualstudio.com/api/references/extension-manifest)



