#!/usr/bin/env python3
"""
Comprehensive String Extraction System
Extracts ALL user-facing strings from Flutter/Dart files for translation tracking
"""

import re
import json
import os
import sys
from pathlib import Path
from typing import Dict, List, Set, Tuple
import hashlib

class StringExtractor:
    def __init__(self):
        self.strings = {}
        self.patterns = [
            # Text widgets
            (r'Text\s*\(\s*[\'"]([^\'"\n]+)[\'"]\s*[,)]', 'text_widget'),
            (r'Text\s*\(\s*["\']((?:[^"\'\\]|\\.)*)["\']\s*[,)]', 'text_widget_escaped'),
            
            # RichText and TextSpan
            (r'text:\s*[\'"]([^\'"\n]+)[\'"]', 'rich_text'),
            (r'TextSpan\s*\(\s*text:\s*[\'"]([^\'"\n]+)[\'"]', 'text_span'),
            
            # Conditional text in ternary operators
            (r'\?\s*[\'"]([^\'"\n]+)[\'"]\s*:\s*[\'"]([^\'"\n]+)[\'"]', 'conditional'),
            
            # String interpolation
            (r'[\'"]\$\{[^}]+\}\s*([^\'"\n]+)[\'"]', 'interpolated'),
            (r'[\'"]([^\'"\n]+)\s*\$\{[^}]+\}[\'"]', 'interpolated_prefix'),
            
            # AppBar titles
            (r'title:\s*[\'"]([^\'"\n]+)[\'"]', 'title'),
            
            # Button text
            (r'(?:child|label):\s*Text\s*\(\s*[\'"]([^\'"\n]+)[\'"]', 'button_text'),
            
            # Snackbar/Dialog text
            (r'content:\s*Text\s*\(\s*[\'"]([^\'"\n]+)[\'"]', 'dialog_text'),
            
            # Tooltip
            (r'tooltip:\s*[\'"]([^\'"\n]+)[\'"]', 'tooltip'),
            
            # Hint text
            (r'hintText:\s*[\'"]([^\'"\n]+)[\'"]', 'hint_text'),
            
            # Label text
            (r'labelText:\s*[\'"]([^\'"\n]+)[\'"]', 'label_text'),
            
            # Error text
            (r'errorText:\s*[\'"]([^\'"\n]+)[\'"]', 'error_text'),
            
            # JSON strings in Dart
            (r'jsonDecode\s*\(\s*[\'"]([^\'"\n]+)[\'"]', 'json_content'),
            (r'"text":\s*"([^"\\n]+)"', 'json_text'),
            (r'"title":\s*"([^"\\n]+)"', 'json_title'),
            (r'"description":\s*"([^"\\n]+)"', 'json_description'),
            (r'"answer":\s*"([^"\\n]+)"', 'json_answer'),
            
            # showSnackBar and showDialog
            (r'showSnackBar\s*\([^)]*Text\s*\(\s*[\'"]([^\'"\n]+)[\'"]', 'snackbar'),
            
            # List items
            (r'[\'"]([^\'"\n]{5,})[\'"]', 'general_string'),
        ]
        
        # Patterns that indicate non-translatable content
        self.exclusion_patterns = [
            r'^https?://',
            r'^[a-zA-Z0-9_]+\.(png|jpg|jpeg|gif|webp|svg)$',
            r'^[a-zA-Z0-9_]+$',  # Single words without spaces (likely identifiers)
            r'^\d+$',  # Numbers only
            r'^#[0-9A-Fa-f]{6}$',  # Hex colors
            r'^[a-z_]+$',  # lowercase identifiers
            r'^\s*$',  # Empty or whitespace only
        ]

    def should_exclude(self, text: str) -> bool:
        """Check if a string should be excluded from translation"""
        # Too short
        if len(text.strip()) < 3:
            return True
            
        # Check exclusion patterns
        for pattern in self.exclusion_patterns:
            if re.match(pattern, text.strip()):
                return True
                
        # Check if it's a path or URL
        if any(x in text for x in ['.com', '.co', 'http', 'assets/', 'lib/', 'images/']):
            return True
            
        return False

    def extract_from_file(self, file_path: Path) -> Dict[str, List[Tuple[str, int, str]]]:
        """Extract all strings from a single file"""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
        except Exception as e:
            print(f"Error reading {file_path}: {e}")
            return {}
        
        file_strings = {}
        lines = content.split('\n')
        
        # Process each pattern
        for pattern, pattern_type in self.patterns:
            matches = re.finditer(pattern, content, re.MULTILINE | re.DOTALL)
            
            for match in matches:
                # Handle conditional patterns with multiple groups
                if pattern_type == 'conditional':
                    texts = [match.group(1), match.group(2)]
                else:
                    texts = [match.group(1)] if match.lastindex >= 1 else []
                
                for text in texts:
                    if text and not self.should_exclude(text):
                        # Find line number
                        pos = match.start()
                        line_num = content[:pos].count('\n') + 1
                        
                        # Get context
                        line_content = lines[line_num - 1] if line_num <= len(lines) else ""
                        
                        # Clean the text
                        clean_text = text.strip().replace('\\n', '\n').replace('\\"', '"').replace("\\'", "'")
                        
                        # Generate unique ID
                        text_id = hashlib.md5(clean_text.encode()).hexdigest()[:8]
                        
                        if clean_text not in file_strings:
                            file_strings[clean_text] = []
                        
                        file_strings[clean_text].append({
                            'line': line_num,
                            'type': pattern_type,
                            'context': line_content.strip()[:100],
                            'id': text_id
                        })
        
        return file_strings

    def extract_from_directory(self, directory: Path) -> Dict[str, Dict]:
        """Extract strings from all Dart files in directory"""
        all_strings = {}
        
        # Find all Dart files
        dart_files = list(directory.rglob('*.dart'))
        
        print(f"Found {len(dart_files)} Dart files")
        
        for file_path in dart_files:
            # Skip generated files and packages
            if any(skip in str(file_path) for skip in ['.dart_tool', 'build/', '.g.dart', 'test/']):
                continue
                
            print(f"Processing: {file_path}")
            file_strings = self.extract_from_file(file_path)
            
            for text, occurrences in file_strings.items():
                if text not in all_strings:
                    all_strings[text] = {
                        'text': text,
                        'files': {},
                        'total_occurrences': 0,
                        'needs_translation': True,
                        'id': occurrences[0]['id']
                    }
                
                file_key = str(file_path.relative_to(directory))
                all_strings[text]['files'][file_key] = occurrences
                all_strings[text]['total_occurrences'] += len(occurrences)
        
        return all_strings

    def analyze_patterns(self, strings: Dict[str, Dict]) -> Dict[str, List[str]]:
        """Analyze strings to find patterns (e.g., similar structure)"""
        patterns = {
            'questions': [],
            'statements': [],
            'cta_buttons': [],
            'descriptions': [],
            'conditional_text': [],
            'statistics': [],
            'time_related': [],
            'emotional': []
        }
        
        for text, data in strings.items():
            text_lower = text.lower()
            
            # Questions
            if '?' in text or text_lower.startswith(('what', 'how', 'why', 'when', 'where', 'do you', 'are you')):
                patterns['questions'].append(text)
            
            # CTAs and buttons
            if any(word in text_lower for word in ['click', 'tap', 'press', 'continue', 'next', 'submit', 'join', 'start', 'begin']):
                patterns['cta_buttons'].append(text)
            
            # Statistics and numbers
            if re.search(r'\d+%|\d+ out of \d+|\d+ days?|\d+ weeks?', text):
                patterns['statistics'].append(text)
            
            # Time-related
            if any(word in text_lower for word in ['day', 'week', 'month', 'minute', 'hour', 'today', 'tomorrow']):
                patterns['time_related'].append(text)
            
            # Emotional/motivational
            if any(word in text_lower for word in ['deserve', 'amazing', 'wonderful', 'congrat', 'excellent', 'outstanding']):
                patterns['emotional'].append(text)
            
            # Conditional (if/then language)
            if any(word in text_lower for word in ['if ', 'when ', 'while ', 'but ', 'however']):
                patterns['conditional_text'].append(text)
            
            # Long descriptions
            if len(text) > 100:
                patterns['descriptions'].append(text)
        
        return patterns

def main():
    extractor = StringExtractor()
    
    # Get project root
    project_root = Path.cwd()
    if len(sys.argv) > 1:
        project_root = Path(sys.argv[1])
    
    print(f"Extracting strings from: {project_root}")
    print("=" * 80)
    
    # Extract all strings
    all_strings = extractor.extract_from_directory(project_root)
    
    # Analyze patterns
    patterns = extractor.analyze_patterns(all_strings)
    
    # Create translation catalog
    catalog = {
        'metadata': {
            'total_strings': len(all_strings),
            'extraction_date': str(Path.cwd()),
            'project_root': str(project_root)
        },
        'strings': all_strings,
        'patterns': {k: len(v) for k, v in patterns.items()}
    }
    
    # Save catalog
    catalog_path = project_root / 'translations' / 'string_catalog.json'
    catalog_path.parent.mkdir(exist_ok=True)
    
    with open(catalog_path, 'w', encoding='utf-8') as f:
        json.dump(catalog, f, indent=2, ensure_ascii=False)
    
    # Generate report
    print(f"\n📊 String Extraction Report")
    print(f"Total unique strings found: {len(all_strings)}")
    print(f"\n📂 Strings by pattern type:")
    for pattern_type, strings_list in patterns.items():
        if len(strings_list) > 0:
            print(f"  - {pattern_type}: {len(strings_list)}")
    
    # Show examples
    print(f"\n📝 Example strings found:")
    for i, (text, data) in enumerate(list(all_strings.items())[:10]):
        print(f"{i+1}. \"{text[:60]}{'...' if len(text) > 60 else ''}\"")
        print(f"   Files: {', '.join(data['files'].keys())}")
        print(f"   Occurrences: {data['total_occurrences']}")
    
    # Create missing translations report
    missing_report_path = project_root / 'translations' / 'missing_translations.md'
    with open(missing_report_path, 'w', encoding='utf-8') as f:
        f.write("# Missing Translations Report\n\n")
        f.write(f"Total strings requiring translation: {len(all_strings)}\n\n")
        
        for pattern_type, strings in patterns.items():
            if strings:
                f.write(f"## {pattern_type.replace('_', ' ').title()}\n\n")
                for s in strings[:20]:  # First 20 of each type
                    f.write(f"- `{s}`\n")
                if len(strings) > 20:
                    f.write(f"- ... and {len(strings) - 20} more\n")
                f.write("\n")
    
    print(f"\n✅ String catalog saved to: {catalog_path}")
    print(f"✅ Missing translations report saved to: {missing_report_path}")
    
    return catalog

if __name__ == "__main__":
    main()