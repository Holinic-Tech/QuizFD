#!/bin/bash

echo "GitHub Actions Workflow Cleanup Script"
echo "======================================"
echo ""

# Check if we're in the right directory
if [ ! -d ".github/workflows" ]; then
    echo "Error: .github/workflows directory not found!"
    echo "Please run this script from the repository root."
    exit 1
fi

echo "Current workflow files:"
ls -la .github/workflows/
echo ""

echo "Recommended workflow structure:"
echo "1. main.yml - Main English build (KEEP)"
echo "2. translate-and-deploy.yml - Consolidated translation workflow (KEEP)"
echo "3. translate-de.yml - Legacy German workflow (REMOVE)"
echo "4. translate-es.yml - Legacy Spanish workflow (REMOVE)"
echo ""

read -p "Do you want to remove the legacy translation workflows? (y/n): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Removing legacy workflows..."
    
    if [ -f ".github/workflows/translate-de.yml" ]; then
        git rm .github/workflows/translate-de.yml
        echo "✓ Removed translate-de.yml"
    fi
    
    if [ -f ".github/workflows/translate-es.yml" ]; then
        git rm .github/workflows/translate-es.yml
        echo "✓ Removed translate-es.yml"
    fi
    
    echo ""
    echo "Legacy workflows removed. You can now commit these changes:"
    echo "  git add ."
    echo "  git commit -m 'Remove legacy translation workflows in favor of consolidated workflow'"
    echo ""
    echo "The new consolidated workflow (translate-and-deploy.yml) handles both languages efficiently."
else
    echo "Cleanup cancelled. No changes made."
fi

echo ""
echo "Current workflow status:"
ls -la .github/workflows/