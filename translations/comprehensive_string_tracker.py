#!/usr/bin/env python3
"""
Comprehensive String Tracking System for Flutter Projects
Tracks all strings including those in generated code, conditional blocks, and rich text
"""

import re
import json
import os
from pathlib import Path
from typing import Dict, List, Set, Tuple
import hashlib
from datetime import datetime

class ComprehensiveStringTracker:
    def __init__(self):
        # Known English patterns from the examples provided
        self.known_english_patterns = [
            # Conditional text patterns
            r'damaged hair and breakage',
            r'in their\s+(?:twenties|thirties|forties)',
            r'experience less',
            r'within \d+ days',
            
            # CTA patterns
            r'Continue',
            r'Join the .* Challenge',
            r'Hurry Up',
            r'Only \d+ seats? remaining',
            
            # Result/dashboard patterns
            r"That's an? \w+ score",
            r'\d+ out of \d+ women',
            r'said their .* stopped',
            r'Probability to fix',
            
            # Motivational patterns
            r'You deserve',
            r'say goodbye to',
            r'No more frustration',
            
            # Conditional advice patterns
            r'With the right routine',
            r"if you are still struggling",
            r"you're missing important",
            
            # Goal patterns
            r'Stronger, more resilient',
            r'style daily without guilt',
            
            # Rich text conditions
            r'damaged hair',
            r'breakage',
            r'density',
            r'hair loss',
            r'split ends',
        ]
        
        # String categories for better organization
        self.categories = {
            'ui_elements': {
                'patterns': [r'Continue', r'Next', r'Back', r'Submit', r'Cancel', r'Save'],
                'strings': []
            },
            'dashboard': {
                'patterns': [r'score', r'result', r'probability', r'congratulation'],
                'strings': []
            },
            'conditional_content': {
                'patterns': [r'if ', r'when ', r'while ', r'but '],
                'strings': []
            },
            'rich_text': {
                'patterns': [r'RichText', r'TextSpan', r'text:'],
                'strings': []
            },
            'statistics': {
                'patterns': [r'\d+%', r'\d+ out of \d+', r'\d+ days?', r'within \d+'],
                'strings': []
            },
            'motivational': {
                'patterns': [r'deserve', r'congrat', r'excellent', r'outstanding', r'amazing'],
                'strings': []
            },
            'hair_specific': {
                'patterns': [r'hair', r'scalp', r'damage', r'breakage', r'split ends'],
                'strings': []
            }
        }
        
        # Translation status tracking
        self.translation_status = {
            'de': {},
            'es': {}
        }

    def find_strings_with_patterns(self, content: str) -> Dict[str, List[Dict]]:
        """Find strings matching known patterns"""
        found_strings = {}
        
        # Search for each known English pattern
        for pattern in self.known_english_patterns:
            matches = re.finditer(pattern, content, re.IGNORECASE)
            for match in matches:
                # Get surrounding context
                start = max(0, match.start() - 100)
                end = min(len(content), match.end() + 100)
                context = content[start:end]
                
                # Extract the full string containing this pattern
                full_string = self.extract_full_string(content, match.start(), match.end())
                
                if full_string and len(full_string) > 3:
                    if full_string not in found_strings:
                        found_strings[full_string] = []
                    
                    found_strings[full_string].append({
                        'pattern': pattern,
                        'context': context,
                        'position': match.start()
                    })
        
        return found_strings

    def extract_full_string(self, content: str, start: int, end: int) -> str:
        """Extract the full string containing the matched pattern"""
        # Look for string boundaries
        quote_chars = ["'", '"', '`']
        
        # Find the opening quote
        open_pos = start
        while open_pos > 0:
            if content[open_pos] in quote_chars:
                break
            open_pos -= 1
        
        # Find the closing quote
        close_pos = end
        quote_char = content[open_pos] if open_pos >= 0 else '"'
        while close_pos < len(content):
            if content[close_pos] == quote_char:
                break
            close_pos += 1
        
        # Extract the string
        if open_pos >= 0 and close_pos < len(content):
            return content[open_pos + 1:close_pos]
        
        return ""

    def analyze_flutter_widgets(self, content: str) -> Dict[str, List[str]]:
        """Analyze Flutter widget patterns for strings"""
        widget_strings = {}
        
        # Common Flutter text patterns
        patterns = {
            'Text widgets': r'Text\s*\(\s*["\']([^"\']+)["\']\s*[,)]',
            'RichText': r'RichText\s*\([^)]*text:\s*["\']([^"\']+)["\']',
            'TextSpan': r'TextSpan\s*\([^)]*text:\s*["\']([^"\']+)["\']',
            'Conditional': r'\?\s*["\']([^"\']+)["\']\s*:\s*["\']([^"\']+)["\']',
            'String interpolation': r'["\']([^"\']*\$\{[^}]+\}[^"\']*)["\'"]',
            'Button text': r'(?:child|label):\s*Text\s*\(\s*["\']([^"\']+)["\']',
            'AppBar title': r'title:\s*["\']([^"\']+)["\']',
            'Tooltip': r'tooltip:\s*["\']([^"\']+)["\']',
            'SnackBar': r'SnackBar\s*\([^)]*content:\s*Text\s*\(\s*["\']([^"\']+)["\']',
        }
        
        for widget_type, pattern in patterns.items():
            matches = re.finditer(pattern, content, re.MULTILINE | re.DOTALL)
            widget_strings[widget_type] = []
            
            for match in matches:
                # Handle multiple groups (like conditional)
                for i in range(1, match.lastindex + 1 if match.lastindex else 1):
                    text = match.group(i)
                    if text and len(text.strip()) > 2:
                        widget_strings[widget_type].append(text)
        
        return widget_strings

    def create_translation_map(self, strings: Dict[str, any]) -> Dict[str, Dict[str, str]]:
        """Create a translation map structure for found strings"""
        translation_map = {
            'en': {},
            'de': {},
            'es': {}
        }
        
        for string in strings:
            # Generate a unique key
            key = hashlib.md5(string.encode()).hexdigest()[:8]
            
            translation_map['en'][key] = string
            translation_map['de'][key] = f"[DE] {string}"  # Placeholder
            translation_map['es'][key] = f"[ES] {string}"  # Placeholder
        
        return translation_map

    def generate_tracking_report(self, all_strings: Dict) -> str:
        """Generate a comprehensive tracking report"""
        report = [
            "# String Translation Tracking Report",
            f"\nGenerated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}",
            "\n## Summary",
            f"- Total unique strings found: {len(all_strings)}",
            "\n## Strings by Category",
        ]
        
        # Categorize strings
        for category, data in self.categories.items():
            category_strings = []
            for string in all_strings:
                if any(re.search(pattern, string, re.IGNORECASE) for pattern in data['patterns']):
                    category_strings.append(string)
            
            if category_strings:
                report.append(f"\n### {category.replace('_', ' ').title()}")
                report.append(f"Found {len(category_strings)} strings:")
                for s in category_strings[:10]:  # Show first 10
                    report.append(f"- `{s}`")
                if len(category_strings) > 10:
                    report.append(f"- ... and {len(category_strings) - 10} more")
        
        # Add examples of patterns found
        report.append("\n## Pattern Examples Found")
        report.append("\n### Conditional Text Blocks")
        report.append("- Pattern: `damaged hair and breakage in their [age], experience less [issue]`")
        report.append("- Pattern: `[percentage]% of women with [condition] saw [result]`")
        
        report.append("\n### Rich Text Conditions")
        report.append("- Pattern: `if [condition] then show '[text]' else show '[alternative]'`")
        
        report.append("\n### CTA Buttons")
        report.append("- Pattern: `[Action] the [number]-Day [Type] Challenge`")
        
        return "\n".join(report)

    def create_translation_config(self, all_strings: Dict) -> Dict:
        """Create a configuration file for managing translations"""
        config = {
            'version': '1.0',
            'last_updated': datetime.now().isoformat(),
            'languages': ['en', 'de', 'es'],
            'strings': {},
            'patterns': {
                'conditional_blocks': [
                    {
                        'pattern': 'damaged hair and breakage in their {age}, experience less {issue} within {days} days',
                        'variables': ['age', 'issue', 'days'],
                        'translations': {
                            'de': 'geschädigtes Haar und Haarbruch in ihren {age}, erleben weniger {issue} innerhalb von {days} Tagen',
                            'es': 'cabello dañado y rotura en sus {age}, experimentan menos {issue} en {days} días'
                        }
                    }
                ],
                'cta_patterns': [
                    {
                        'pattern': 'Join the {days}-Day {type} Challenge',
                        'variables': ['days', 'type'],
                        'translations': {
                            'de': 'Nimm an der {days}-Tage {type} Challenge teil',
                            'es': 'Únete al Reto de {days} Días {type}'
                        }
                    }
                ]
            }
        }
        
        # Add all found strings
        for idx, string in enumerate(all_strings):
            string_id = f"str_{idx:04d}"
            config['strings'][string_id] = {
                'en': string,
                'de': '',  # To be filled
                'es': '',  # To be filled
                'context': all_strings[string].get('context', ''),
                'category': self.categorize_string(string),
                'needs_translation': True
            }
        
        return config

    def categorize_string(self, string: str) -> str:
        """Categorize a string based on its content"""
        string_lower = string.lower()
        
        for category, data in self.categories.items():
            if any(re.search(pattern, string_lower) for pattern in data['patterns']):
                return category
        
        return 'general'

def main():
    tracker = ComprehensiveStringTracker()
    
    # For now, work with what we have
    print("🔍 Comprehensive String Tracking System")
    print("=" * 80)
    
    # Since we only have app_state.dart, let's create a comprehensive tracking system
    # that can be extended when more files are available
    
    # Read app_state.dart
    app_state_path = Path('lib/app_state.dart')
    if app_state_path.exists():
        with open(app_state_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Find strings with patterns
        pattern_strings = tracker.find_strings_with_patterns(content)
        widget_strings = tracker.analyze_flutter_widgets(content)
        
        print(f"\n📊 Found {len(pattern_strings)} strings matching known English patterns")
        print(f"📱 Found strings in {len(widget_strings)} widget types")
    
    # Create tracking configuration
    all_strings = {}  # Combine all found strings
    
    # Generate comprehensive tracking files
    tracking_dir = Path('translations/tracking')
    tracking_dir.mkdir(exist_ok=True)
    
    # 1. Pattern-based string finder
    with open(tracking_dir / 'string_patterns.json', 'w') as f:
        json.dump({
            'english_patterns': tracker.known_english_patterns,
            'categories': tracker.categories,
            'extraction_rules': {
                'flutter_widgets': list(widget_strings.keys()) if 'widget_strings' in locals() else [],
                'conditional_blocks': ['ternary operators', 'if statements', 'switch cases'],
                'rich_text': ['TextSpan with conditions', 'RichText with multiple spans']
            }
        }, f, indent=2)
    
    # 2. Translation tracking spreadsheet format
    tracking_data = []
    for category, patterns in tracker.categories.items():
        tracking_data.append({
            'category': category,
            'patterns': patterns['patterns'],
            'example_strings': patterns['strings'][:5] if patterns['strings'] else [],
            'translation_status': {
                'de': 'pending',
                'es': 'pending'
            }
        })
    
    with open(tracking_dir / 'translation_tracking.json', 'w') as f:
        json.dump(tracking_data, f, indent=2)
    
    # 3. Create a template for adding new strings
    template = {
        'instructions': 'Add new strings found in the Flutter app here',
        'example_entry': {
            'id': 'unique_string_id',
            'english': 'Original English text',
            'german': 'German translation',
            'spanish': 'Spanish translation',
            'location': 'Where this string appears (file:line)',
            'type': 'ui_element|dashboard|conditional|rich_text|etc',
            'context': 'Additional context about usage'
        },
        'strings': {
            'continue_button': {
                'english': 'Continue',
                'german': 'Weiter',
                'spanish': 'Continuar',
                'location': 'Multiple locations',
                'type': 'ui_element'
            },
            'dashboard_score': {
                'english': "That's an outstanding score!",
                'german': 'Das ist ein hervorragender Wert!',
                'spanish': '¡Es una puntuación excelente!',
                'location': 'Dashboard result display',
                'type': 'dashboard'
            },
            'conditional_damage': {
                'english': '91.2% of women who struggle with damaged hair and breakage in their thirties, experience less breakage and more density within 14 days',
                'german': '91,2% der Frauen, die mit geschädigtem Haar und Haarbruch in ihren Dreißigern kämpfen, erleben weniger Haarbruch und mehr Dichte innerhalb von 14 Tagen',
                'spanish': 'El 91.2% de las mujeres que luchan con el cabello dañado y la rotura en sus treinta, experimentan menos rotura y más densidad en 14 días',
                'location': 'Rich text conditional block',
                'type': 'conditional_content'
            }
        }
    }
    
    with open(tracking_dir / 'string_template.json', 'w') as f:
        json.dump(template, f, indent=2)
    
    print("\n✅ Created comprehensive tracking system:")
    print(f"  - {tracking_dir}/string_patterns.json - Pattern definitions")
    print(f"  - {tracking_dir}/translation_tracking.json - Translation status tracking")
    print(f"  - {tracking_dir}/string_template.json - Template for adding new strings")
    
    print("\n📝 Next steps:")
    print("1. Add all English strings from your Flutter app to string_template.json")
    print("2. The patterns in string_patterns.json will help find similar strings")
    print("3. Use translation_tracking.json to monitor translation progress")
    print("4. Update robust_translation_system.py with the translations from string_template.json")

if __name__ == "__main__":
    main()