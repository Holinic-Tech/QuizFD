#!/usr/bin/env python3
"""
Translation Coverage Verification Script
Checks for any untranslated English strings in the app_state.dart file
"""

import re
import sys
from pathlib import Path

def find_english_strings(file_path):
    """Find potential English strings that might need translation"""
    
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Common patterns for English text
    patterns = [
        # Sentences with spaces (but exclude German/Spanish)
        r'"[A-Z][a-z]+\s+[a-z]+(?:\s+[a-z]+)*"',
        r"'[A-Z][a-z]+\s+[a-z]+(?:\s+[a-z]+)*'",
        # Question words
        r'"\b(?:What|Where|When|Why|How|Do|Does|Is|Are|Can|Could|Would|Should)\b[^"]*"',
        # Common English words that shouldn't appear
        r'"\b(?:Yes|No|Maybe|Please|Thank you|Hello|Goodbye|Welcome)\b"',
        r'"\b(?:Continue|Next|Previous|Back|Submit|Cancel|Save|Delete)\b"',
        # Time references
        r'"\b(?:Today|Tomorrow|Yesterday|Week|Month|Year|Day|Hour|Minute)\b"',
    ]
    
    # Exclusions - patterns that are OK
    exclusions = [
        r'jsonDecode',
        r'fromSerializableMap',
        r'https?://',
        r'assets\.hairqare\.co',
        r'cdn\.',
        r'picsum\.photos',
        r'pixabay\.com',
        # German words that might match patterns
        r'Hallo Welt',
        r'Antwort \d+',
        r'Heat styling',  # This is a product name, kept in English
        # Field names
        r'"image"',
        r'"answer"',
        r'"title"',
        r'"description"',
        r'"id"',
        r'"type"',
    ]
    
    findings = []
    line_number = 0
    
    for line in content.split('\n'):
        line_number += 1
        
        # Skip if line contains exclusions
        if any(re.search(excl, line, re.IGNORECASE) for excl in exclusions):
            continue
        
        # Check each pattern
        for pattern in patterns:
            matches = re.findall(pattern, line)
            for match in matches:
                # Additional filtering
                if len(match) > 5 and not any(excl in match for excl in ['http', 'www', '.com', '.co']):
                    findings.append({
                        'line': line_number,
                        'text': match,
                        'context': line.strip()[:100]
                    })
    
    return findings

def check_specific_issues(file_path):
    """Check for specific known translation issues"""
    
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    issues = []
    
    # Check for Spanish text in German file
    spanish_patterns = [
        'El aceite',
        'El agua de',
        'Los productos',
        'No lavar',
        'es el mejor',
        'hace crecer',
    ]
    
    for pattern in spanish_patterns:
        if pattern in content:
            # Find line number
            lines = content.split('\n')
            for i, line in enumerate(lines):
                if pattern in line:
                    issues.append({
                        'type': 'Spanish text found',
                        'line': i + 1,
                        'text': pattern,
                        'context': line.strip()[:100]
                    })
    
    # Check for dollar signs (should be euros)
    dollar_matches = re.findall(r'\$\d+', content)
    if dollar_matches:
        lines = content.split('\n')
        for i, line in enumerate(lines):
            if '$' in line and any(m in line for m in dollar_matches):
                issues.append({
                    'type': 'Dollar sign found',
                    'line': i + 1,
                    'text': line.strip(),
                    'context': 'Should use € for German'
                })
    
    return issues

def main():
    if len(sys.argv) < 2:
        print("Usage: python verify_coverage.py <path_to_app_state.dart>")
        sys.exit(1)
    
    file_path = Path(sys.argv[1])
    
    if not file_path.exists():
        print(f"Error: File {file_path} not found")
        sys.exit(1)
    
    print("🔍 Checking translation coverage...\n")
    
    # Find potential English strings
    english_findings = find_english_strings(file_path)
    
    # Check specific issues
    specific_issues = check_specific_issues(file_path)
    
    # Report findings
    if not english_findings and not specific_issues:
        print("✅ No untranslated English strings found!")
        print("✅ Translation coverage appears to be 100%")
    else:
        print("⚠️  Potential translation issues found:\n")
        
        if english_findings:
            print("📝 Possible English strings:")
            for finding in english_findings[:10]:  # Show first 10
                print(f"  Line {finding['line']}: {finding['text']}")
                print(f"    Context: {finding['context']}")
            
            if len(english_findings) > 10:
                print(f"\n  ... and {len(english_findings) - 10} more")
        
        if specific_issues:
            print("\n⚠️  Specific issues:")
            for issue in specific_issues:
                print(f"  {issue['type']} at line {issue['line']}")
                print(f"    Context: {issue['context']}")
    
    print(f"\n📊 Summary:")
    print(f"  - Total potential English strings: {len(english_findings)}")
    print(f"  - Specific issues found: {len(specific_issues)}")
    
    # Exit with error code if issues found
    sys.exit(1 if (english_findings or specific_issues) else 0)

if __name__ == "__main__":
    main()