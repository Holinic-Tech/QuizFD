#!/usr/bin/env python3
"""
Comprehensive String Tracking System
This system tracks all translatable strings across the entire codebase,
their locations, and translation status for complete coverage monitoring.
"""

import re
import json
import sys
import os
from pathlib import Path
from typing import Dict, List, Tuple, Set
from datetime import datetime

class StringTracker:
    """Track all translatable strings and their locations in the codebase"""
    
    def __init__(self):
        self.strings_found = {}  # {string: [locations]}
        self.translated_strings = set()
        self.untranslated_strings = set()
        self.conditional_strings = {}  # {string: conditional_context}
        self.translation_patterns = {}
        
    def extract_strings_from_file(self, file_path: Path) -> List[Dict]:
        """Extract all translatable strings from a file with context"""
        strings = []
        
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
        except Exception as e:
            print(f"Error reading {file_path}: {e}")
            return strings
        
        lines = content.split('\n')
        
        # Patterns for different string types
        patterns = [
            # JSON strings in app_state.dart
            (r'\"answer\":\s*\"([^\"]+)\"', 'json_answer'),
            (r'\"title\":\s*\"([^\"]+)\"', 'json_title'),
            (r'\"description\":\s*\"([^\"]+)\"', 'json_description'),
            (r'\"AnswerTitle\":\s*\"([^\"]+)\"', 'json_answer_title'),
            (r'\"AnswerDescription\":\s*\"([^\"]+)\"', 'json_answer_description'),
            
            # Widget text strings
            (r'Text\s*\(\s*[\'\"](.*?)[\'\"]\s*[\),]', 'widget_text'),
            (r'text:\s*[\'\"](.*?)[\'\"]\s*[,\)]', 'widget_text_property'),
            
            # Conditional strings in ternary operators
            (r'\?\s*[\'\"](.*?)[\'\"]\s*:', 'conditional_ternary'),
            (r':\s*[\'\"](.*?)[\'\"]\s*[;,\)]', 'conditional_else'),
            
            # TextSpan children
            (r'TextSpan\s*\(\s*text:\s*[\'\"](.*?)[\'\"]\s*[\),]', 'text_span'),
            
            # AppLocalizations strings (already translated)
            (r'AppLocalizations\.of\(context\)!\.(\w+)', 'localized'),
            
            # Direct string literals
            (r'[\'\"]((?:[A-Z][a-z]+(?:\s+[a-z]+)*)|(?:[A-Z][a-z]*(?:\s+[A-Z][a-z]*)*)|(?:\w+(?:\s+\w+)*\s*[?!.]))[\'\"]\s*[,;\)]', 'string_literal'),
        ]
        
        for line_num, line in enumerate(lines, 1):
            line_stripped = line.strip()
            
            # Skip comments and imports
            if line_stripped.startswith('//') or line_stripped.startswith('import'):
                continue
                
            for pattern, string_type in patterns:
                matches = re.finditer(pattern, line)
                for match in matches:
                    string_content = match.group(1)
                    
                    # Filter out non-user-facing strings
                    if self._is_user_facing_string(string_content, string_type):
                        strings.append({
                            'text': string_content,
                            'type': string_type,
                            'file': str(file_path),
                            'line': line_num,
                            'context': line_stripped,
                            'is_translated': self._is_german_text(string_content)
                        })
        
        return strings
    
    def _is_user_facing_string(self, text: str, string_type: str) -> bool:
        """Determine if a string is user-facing and needs translation"""
        
        # Skip technical strings
        technical_patterns = [
            r'^[a-z_]+[A-Z][a-zA-Z]*$',  # camelCase variables
            r'^[A-Z_]+$',  # CONSTANTS
            r'^[a-z_]+$',  # snake_case
            r'^\w+\.\w+$',  # object.property
            r'^https?://',  # URLs
            r'^[a-z]+://|\.com|\.co|\.de',  # URLs and domains
            r'^\d+$',  # Numbers only
            r'^[a-f0-9-]{8,}$',  # IDs/hashes
            r'^[{}[\]()]+$',  # Brackets only
            r'^[\s]*$',  # Whitespace only
        ]
        
        for pattern in technical_patterns:
            if re.match(pattern, text):
                return False
        
        # Skip very short strings unless they're obvious UI text
        if len(text) < 3 and text not in ['Yes', 'No', 'OK']:
            return False
            
        # Skip if it's already a localized call
        if string_type == 'localized':
            return False
            
        # Include strings that look like user-facing text
        user_facing_patterns = [
            r'^[A-Z].*[.!?]$',  # Sentences
            r'^[A-Z].*\s+.*$',  # Multi-word capitalized
            r'^\d+.*\s+.*$',  # Starts with number but has words
            r'^.*[?!]$',  # Ends with question/exclamation
            r'emoji|💜|🙌|😢|😥|🤩|✨|🌿|🤗|🫧|🤓|😌',  # Contains emojis
        ]
        
        for pattern in user_facing_patterns:
            if re.search(pattern, text):
                return True
                
        # Include if it contains common UI words
        ui_words = [
            'continue', 'next', 'back', 'submit', 'cancel', 'save', 'done',
            'start', 'finish', 'skip', 'close', 'yes', 'no', 'error', 'success',
            'loading', 'please', 'wait', 'hair', 'routine', 'challenge',
            'goal', 'problem', 'issue', 'care', 'treatment', 'product'
        ]
        
        text_lower = text.lower()
        for word in ui_words:
            if word in text_lower:
                return True
        
        return False
    
    def _is_german_text(self, text: str) -> bool:
        """Check if text appears to be in German"""
        german_indicators = [
            'ich', 'du', 'sie', 'wir', 'ihr', 'der', 'die', 'das', 'und', 'oder',
            'mit', 'für', 'von', 'zu', 'auf', 'in', 'an', 'bei', 'nach', 'über',
            'gegen', 'ohne', 'durch', 'um', 'vor', 'hinter', 'unter', 'neben',
            'zwischen', 'während', 'trotz', 'wegen', 'statt', 'anstatt',
            'ä', 'ö', 'ü', 'ß', 'haare', 'haar', 'routine', 'pflege',
            'behandlung', 'produkt', 'shampoo', 'conditioner', 'maske'
        ]
        
        text_lower = text.lower()
        for indicator in german_indicators:
            if indicator in text_lower:
                return True
        
        return False
    
    def scan_directory(self, directory: Path) -> Dict:
        """Scan entire directory for translatable strings"""
        print(f"🔍 Scanning {directory} for translatable strings...")
        
        dart_files = list(directory.rglob('*.dart'))
        total_strings = []
        
        for dart_file in dart_files:
            if 'test' in str(dart_file) or '.git' in str(dart_file):
                continue
                
            strings = self.extract_strings_from_file(dart_file)
            total_strings.extend(strings)
            
            if strings:
                print(f"  📄 {dart_file.relative_to(directory)}: {len(strings)} strings")
        
        # Categorize strings
        translated = [s for s in total_strings if s['is_translated']]
        untranslated = [s for s in total_strings if not s['is_translated']]
        
        # Group by type
        by_type = {}
        for string in total_strings:
            string_type = string['type']
            if string_type not in by_type:
                by_type[string_type] = []
            by_type[string_type].append(string)
        
        # Group by file
        by_file = {}
        for string in total_strings:
            file_path = string['file']
            if file_path not in by_file:
                by_file[file_path] = []
            by_file[file_path].append(string)
        
        results = {
            'total_strings': len(total_strings),
            'translated_strings': len(translated),
            'untranslated_strings': len(untranslated),
            'translation_coverage': (len(translated) / len(total_strings) * 100) if total_strings else 100,
            'by_type': by_type,
            'by_file': by_file,
            'all_strings': total_strings,
            'scan_timestamp': datetime.now().isoformat()
        }
        
        return results
    
    def generate_report(self, results: Dict, output_file: Path = None) -> str:
        """Generate a comprehensive translation report"""
        
        report = f"""
# Translation Coverage Report
Generated: {results['scan_timestamp']}

## Summary
- **Total Strings Found**: {results['total_strings']}
- **Translated Strings**: {results['translated_strings']}
- **Untranslated Strings**: {results['untranslated_strings']}
- **Translation Coverage**: {results['translation_coverage']:.1f}%

## Strings by Type
"""
        
        for string_type, strings in results['by_type'].items():
            translated_count = sum(1 for s in strings if s['is_translated'])
            untranslated_count = len(strings) - translated_count
            coverage = (translated_count / len(strings) * 100) if strings else 100
            
            report += f"\n### {string_type}\n"
            report += f"- Total: {len(strings)}\n"
            report += f"- Translated: {translated_count}\n"
            report += f"- Untranslated: {untranslated_count}\n"
            report += f"- Coverage: {coverage:.1f}%\n"
        
        # Show untranslated strings
        untranslated = [s for s in results['all_strings'] if not s['is_translated']]
        if untranslated:
            report += "\n## Untranslated Strings\n"
            for string in untranslated[:20]:  # Show first 20
                report += f"\n### File: {string['file']} (Line {string['line']})\n"
                report += f"**Type**: {string['type']}\n"
                report += f"**Text**: `{string['text']}`\n"
                report += f"**Context**: `{string['context']}`\n"
            
            if len(untranslated) > 20:
                report += f"\n... and {len(untranslated) - 20} more untranslated strings.\n"
        
        # Files with highest translation needs
        report += "\n## Files Requiring Translation\n"
        file_stats = {}
        for file_path, strings in results['by_file'].items():
            untranslated_count = sum(1 for s in strings if not s['is_translated'])
            if untranslated_count > 0:
                file_stats[file_path] = {
                    'total': len(strings),
                    'untranslated': untranslated_count,
                    'coverage': ((len(strings) - untranslated_count) / len(strings) * 100)
                }
        
        # Sort by untranslated count
        sorted_files = sorted(file_stats.items(), key=lambda x: x[1]['untranslated'], reverse=True)
        
        for file_path, stats in sorted_files[:10]:  # Top 10 files
            report += f"\n### {file_path}\n"
            report += f"- Total strings: {stats['total']}\n"
            report += f"- Untranslated: {stats['untranslated']}\n"
            report += f"- Coverage: {stats['coverage']:.1f}%\n"
        
        if output_file:
            with open(output_file, 'w', encoding='utf-8') as f:
                f.write(report)
            print(f"📊 Report saved to {output_file}")
        
        return report
    
    def save_tracking_data(self, results: Dict, output_file: Path):
        """Save detailed tracking data as JSON for future reference"""
        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump(results, f, indent=2, ensure_ascii=False)
        print(f"💾 Tracking data saved to {output_file}")

def main():
    import argparse
    
    parser = argparse.ArgumentParser(description='Track all translatable strings in the codebase')
    parser.add_argument('directory', help='Directory to scan')
    parser.add_argument('--output', '-o', help='Output file for report')
    parser.add_argument('--json', help='JSON file for detailed data')
    
    args = parser.parse_args()
    
    directory = Path(args.directory)
    if not directory.exists():
        print(f"Error: Directory {directory} does not exist")
        sys.exit(1)
    
    tracker = StringTracker()
    results = tracker.scan_directory(directory)
    
    # Generate report
    output_file = Path(args.output) if args.output else None
    report = tracker.generate_report(results, output_file)
    
    if not args.output:
        print(report)
    
    # Save JSON data
    if args.json:
        tracker.save_tracking_data(results, Path(args.json))
    
    # Print summary
    print(f"\n✅ Scan complete!")
    print(f"📊 Coverage: {results['translation_coverage']:.1f}%")
    print(f"🔤 Total strings: {results['total_strings']}")
    print(f"✅ Translated: {results['translated_strings']}")
    print(f"❌ Untranslated: {results['untranslated_strings']}")

if __name__ == "__main__":
    main()