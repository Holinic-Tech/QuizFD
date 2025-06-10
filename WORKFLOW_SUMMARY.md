# GitHub Actions Workflow Summary

## Overview
This repository has 4 workflows that handle building and deploying the quiz in English, German, and Spanish.

## Workflows

### 1. `main.yml` - Deploy English Version
- **Triggers on**: Push to `flutterflow` branch (or manual)
- **Builds from**: `flutterflow` branch
- **Deploys to**: `gh-pages` branch

### 2. `build-translations.yml` - Create Translations
- **Triggers on**: Push to `flutterflow` branch or manual with language selection
- **What it does**:
  1. Sets default language (de/es)
  2. Replaces checkout URLs with language-specific ones
  3. **Translates app state content** (quiz answers, loading messages, etc.)
  4. Pushes changes to `translation-de-DE` and/or `translation-es-ES` branches

### 3. `deploy-german.yml` - Deploy German Version
- **Triggers on**: Push to `translation-de-DE` branch (or manual)
- **Builds from**: `translation-de-DE` branch
- **Deploys to**: `gh-pages-de-DE` branch
- **Process**: Identical to main.yml

### 4. `deploy-spanish.yml` - Deploy Spanish Version
- **Triggers on**: Push to `translation-es-ES` branch (or manual)
- **Builds from**: `translation-es-ES` branch
- **Deploys to**: `gh-pages-es-ES` branch
- **Process**: Identical to main.yml

## Workflow Chain

### Automatic Flow (on push to flutterflow):
1. `main.yml` runs → Builds English → Deploys to `gh-pages`
2. `build-translations.yml` runs → Creates translations → Pushes to translation branches
3. `deploy-german.yml` runs → Builds German → Deploys to `gh-pages-de-DE`
4. `deploy-spanish.yml` runs → Builds Spanish → Deploys to `gh-pages-es-ES`

### Manual Triggers:
- Each workflow can be triggered manually from the Actions tab
- Build translations allows selecting specific languages

## Final Output
- **English**: `gh-pages` branch
- **German**: `gh-pages-de-DE` branch
- **Spanish**: `gh-pages-es-ES` branch

All three versions are automatically built when you push to the `flutterflow` branch!