# GitHub Actions Workflow Documentation

## Overview
This repository uses GitHub Actions to automatically build and deploy the FlutterFlow quiz application in multiple languages. The app already contains all translations in the code - the workflows configure and deploy language-specific versions.

## How Translations Work

### Built-in Translations
All UI text translations are already embedded in `/lib/flutter_flow/internationalization.dart`. The app supports:
- English (en)
- German (de)
- Spanish (es)

The translations were created in FlutterFlow and are part of the codebase. The workflows configure the app for each language and translate dynamic content.

### Dynamic Content Translation
In addition to FlutterFlow's built-in translations, the workflows also translate dynamic app state content that isn't covered by the i18n system:
- Quiz answer options
- Loading screen messages
- Hair types, concerns, and goals
- Diet options and routine descriptions
- Professional referral options
- Plan names and descriptions

This is handled by `translations/app_state_translations.py` which updates the app_state.dart file with language-specific content.

## Workflow Structure

### 1. Main Build Workflow (`main.yml`)
- **Trigger**: Push to `flutterflow` branch
- **Purpose**: Build and deploy the English version to GitHub Pages
- **Deployment**: `gh-pages` branch
- **Key Features**:
  - Fixes Flutter Flow utility compatibility issues
  - Builds with HTML renderer for web compatibility
  - Modifies base href for proper GitHub Pages deployment

### 2. Translation Configuration Workflow (`build-translations.yml`)
- **Trigger**: Manual workflow dispatch with language selection
- **Purpose**: Configure code for each language and push to translation branches
- **What it does**:
  1. Sets the default app language (modifies `setAppLanguage` in HomePage)
  2. Replaces checkout URLs with language-specific versions
  3. Translates dynamic app state content (quiz answers, loading messages, etc.)
  4. Commits changes to translation branches
  5. Does NOT build or deploy (that's handled by deploy workflows)

### 3. German Deployment Workflow (`deploy-german.yml`)
- **Trigger**: 
  - Push to `translation-de-DE` branch
  - Manual workflow dispatch
- **Purpose**: Build and deploy German version from translation branch
- **Deployment**: `gh-pages-de-DE` branch
- **Process**: Same as main.yml but from German translation branch

### 4. Spanish Deployment Workflow (`deploy-spanish.yml`)
- **Trigger**: 
  - Push to `translation-es-ES` branch
  - Manual workflow dispatch
- **Purpose**: Build and deploy Spanish version from translation branch
- **Deployment**: `gh-pages-es-ES` branch
- **Process**: Same as main.yml but from Spanish translation branch
- **Trigger**: 
  - Push to `flutterflow` branch (when lib/**, pubspec.yaml, or assets/** change)
  - Manual workflow dispatch with language selection
- **Purpose**: Configure and deploy German and Spanish versions
- **Manual Trigger Options**:
  - `all` - Build both German and Spanish (default)
  - `de` - Build only German
  - `es` - Build only Spanish
  - `de,es` - Build both (comma-separated)
- **What it does**:
  1. Sets the default app language (modifies `setAppLanguage` in HomePage)
  2. Replaces checkout URLs with language-specific versions
  3. Commits changes to translation branches
  4. Builds and deploys to language-specific subdirectories
- **Deployment**: 
  - German (de) → `/de` subdirectory
  - Spanish (es) → `/es` subdirectory

## Branch Structure

- `flutterflow` - Main development branch (source for all builds)
- `main` - Repository default branch
- `translation-de-DE` - German translation branch
- `translation-es-ES` - Spanish translation branch
- `gh-pages` - GitHub Pages deployment branch (contains all language versions)

## Deployment Structure

```
GitHub Pages (gh-pages branch)
├── / (root) - English version
├── /de - German version
└── /es - Spanish version
```

## URL Replacements

The translation workflows replace the English checkout URL with language-specific versions:
- English: `https://checkout.hairqare.co/buy/hairqare-challenge-save-85-5/`
- German: `https://checkout.hairqare.co/de/buy/hairqare-challenge-save-90-25-de/`
- Spanish: `https://checkout.hairqare.co/es/buy/hairqare-challenge-save-90-25-es/`

## Complete Workflow Process Flow

### Automatic Flow:
1. **Push to flutterflow branch** → Triggers `main.yml`
2. **Main workflow** → Builds English version → Deploys to `gh-pages` branch

### Translation Flow:
1. **Manual trigger** → Run "Build Translations" workflow
2. **Build Translations workflow** → For each selected language:
   - Modifies code to set default language
   - Replaces checkout URLs
   - Commits to translation branch (e.g., `translation-de-DE`)
3. **Push to translation branch** → Triggers language-specific deploy workflow
4. **Deploy workflow** → Builds web app → Deploys to language-specific gh-pages branch:
   - German → `gh-pages-de-DE`
   - Spanish → `gh-pages-es-ES`

## Manual Workflow Execution

To manually trigger translations:
1. Go to Actions tab in GitHub
2. Select "Translate and Deploy All Versions"
3. Click "Run workflow"
4. Enter languages (e.g., `de`, `es`, or `all`)
5. Click "Run workflow"

## Key Configuration Changes Made by Translation Workflow

1. **Language Setting**: Changes `setAppLanguage(context, 'en')` to target language
2. **Checkout URLs**: Replaces English checkout URLs with language-specific ones
3. **App Name**: Updates pubspec.yaml to append language code

## Testing and Verification

After deployment, test each language version:
- English: `https://[your-github-username].github.io/QuizV2/`
- German: `https://[your-github-username].github.io/QuizV2/de/`
- Spanish: `https://[your-github-username].github.io/QuizV2/es/`