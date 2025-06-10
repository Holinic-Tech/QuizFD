#!/usr/bin/env python3
"""
Find all conditional and dynamically generated strings in Flutter projects
This catches strings that might be missed in standard translation passes
"""

import re
import json
from pathlib import Path
from typing import Dict, List, Set, Tuple

class ConditionalStringFinder:
    def __init__(self):
        # Patterns that indicate conditional content
        self.conditional_patterns = [
            # Ternary operators with strings
            (r'(\w+)\s*\?\s*[\'"]([^\'"\n]+)[\'"]\s*:\s*[\'"]([^\'"\n]+)[\'"]', 'ternary'),
            
            # If statements with string returns
            (r'if\s*\([^)]+\)\s*{\s*return\s*[\'"]([^\'"\n]+)[\'"]', 'if_return'),
            
            # Switch/case with strings
            (r'case\s+\w+:\s*return\s*[\'"]([^\'"\n]+)[\'"]', 'switch_case'),
            
            # String interpolation with conditionals
            (r'\$\{[^}]*\?\s*[\'"]([^\'"\n]+)[\'"]\s*:\s*[\'"]([^\'"\n]+)[\'"][^}]*\}', 'interpolated_conditional'),
            
            # Builder patterns with conditions
            (r'builder:\s*\([^)]*\)\s*{\s*if[^}]*return\s*Text\s*\(\s*[\'"]([^\'"\n]+)[\'"]', 'builder_conditional'),
            
            # Rich text with conditions
            (r'TextSpan\s*\(\s*text:\s*\w+\s*\?\s*[\'"]([^\'"\n]+)[\'"]\s*:\s*[\'"]([^\'"\n]+)[\'"]', 'rich_text_conditional'),
            
            # Dynamic string building
            (r'String\s+\w+\s*=\s*[\'"]([^\'"\n]+)[\'"]\s*\+[^;]+[\'"]([^\'"\n]+)[\'"]', 'string_concatenation'),
            
            # List/Map with conditional strings
            (r'[\'"]([^\'"\n]+)[\'"]\s*:\s*\w+\s*\?\s*[\'"]([^\'"\n]+)[\'"]\s*:\s*[\'"]([^\'"\n]+)[\'"]', 'map_conditional'),
            
            # Function returns with conditions
            (r'return\s+\w+\s*\?\s*[\'"]([^\'"\n]+)[\'"]\s*:\s*[\'"]([^\'"\n]+)[\'"]', 'conditional_return'),
            
            # setState with string changes
            (r'setState\s*\(\s*\(\)\s*{\s*\w+\s*=\s*[\'"]([^\'"\n]+)[\'"]', 'setState_string'),
        ]
        
        # Common conditional variables that might contain strings
        self.conditional_variables = [
            'age', 'thirties', 'forties', 'twenties',
            'score', 'result', 'status',
            'hairType', 'hairConcern', 'damage',
            'routine', 'goal', 'mindset',
            'gender', 'name', 'location',
            'day', 'week', 'month', 'time',
            'percentage', 'count', 'total',
        ]
        
        # Patterns that indicate dynamic content generation
        self.dynamic_patterns = [
            # Percentage patterns
            r'\d+\.?\d*%\s+of\s+\w+',
            r'\$\{percentage\}%\s+of\s+women',
            
            # Counting patterns
            r'\d+\s+out\s+of\s+\d+',
            r'Only\s+\$?\{?\w*\}?\s+\w+\s+remaining',
            
            # Time-based patterns
            r'in\s+\$?\{?\w*\}?\s+days?',
            r'within\s+\$?\{?\w*\}?\s+(?:days?|weeks?|months?)',
            r'after\s+\$?\{?\w*\}?\s+(?:days?|weeks?)',
            
            # Age-based patterns
            r'in\s+(?:their|your|my)\s+\$?\{?\w*\}?(?:twenties|thirties|forties|50s)',
            
            # Name/personal patterns
            r'(?:Hello|Hi|Welcome|Dear)\s+\$?\{?\w*\}?',
            r'You\s+deserve\s+this,?\s*\$?\{?\w*\}?',
            
            # Score/result patterns
            r"That's\s+an?\s+\$?\{?\w*\}?\s+score",
            r'Your?\s+\$?\{?\w*\}?\s+score\s+is',
        ]

    def find_conditional_strings(self, content: str) -> Dict[str, List[Dict]]:
        """Find all conditional strings in content"""
        findings = {}
        
        # Search for conditional patterns
        for pattern, pattern_type in self.conditional_patterns:
            matches = re.finditer(pattern, content, re.MULTILINE | re.IGNORECASE)
            
            for match in matches:
                # Extract all groups (multiple strings in conditionals)
                for i in range(1, match.lastindex + 1 if match.lastindex else 1):
                    string = match.group(i)
                    if string and len(string.strip()) > 2:
                        if string not in findings:
                            findings[string] = []
                        
                        # Get context
                        start = max(0, match.start() - 50)
                        end = min(len(content), match.end() + 50)
                        context = content[start:end].replace('\n', ' ')
                        
                        findings[string].append({
                            'type': pattern_type,
                            'pattern': pattern,
                            'context': context,
                            'line': content[:match.start()].count('\n') + 1
                        })
        
        return findings

    def find_dynamic_strings(self, content: str) -> Dict[str, List[Dict]]:
        """Find strings that are likely dynamically generated"""
        findings = {}
        
        for pattern in self.dynamic_patterns:
            # Search for the pattern in various string contexts
            string_contexts = [
                f'[\'"]([^\'"\n]*{pattern}[^\'"\n]*)[\'"]',
                f'Text\\s*\\([\'"]([^\'"\n]*{pattern}[^\'"\n]*)[\'"]',
                f'text:\\s*[\'"]([^\'"\n]*{pattern}[^\'"\n]*)[\'"]',
            ]
            
            for context_pattern in string_contexts:
                matches = re.finditer(context_pattern, content, re.MULTILINE | re.IGNORECASE)
                
                for match in matches:
                    string = match.group(1) if match.lastindex else match.group(0)
                    if string and len(string.strip()) > 5:
                        if string not in findings:
                            findings[string] = []
                        
                        findings[string].append({
                            'pattern': pattern,
                            'context': content[max(0, match.start()-50):match.end()+50],
                            'line': content[:match.start()].count('\n') + 1
                        })
        
        return findings

    def analyze_variable_usage(self, content: str) -> Dict[str, List[str]]:
        """Find how conditional variables are used with strings"""
        variable_usage = {}
        
        for var in self.conditional_variables:
            # Find where these variables are used in string contexts
            patterns = [
                f'{var}\\s*==\\s*[\'"]([^\'"\n]+)[\'"]',  # Comparison
                f'{var}\\s*\\.contains\\([\'"]([^\'"\n]+)[\'"]',  # Contains check
                f'\\$\\{{{var}\\}}',  # Interpolation
                f'\\${{[^}}]*{var}[^}}]*}}',  # Complex interpolation
            ]
            
            for pattern in patterns:
                matches = re.finditer(pattern, content, re.IGNORECASE)
                for match in matches:
                    if var not in variable_usage:
                        variable_usage[var] = []
                    
                    context = content[max(0, match.start()-100):match.end()+100]
                    variable_usage[var].append(context)
        
        return variable_usage

    def generate_conditional_patterns_report(self, findings: Dict) -> List[str]:
        """Generate a report of conditional string patterns found"""
        report = []
        
        # Group by pattern type
        pattern_groups = {}
        for string, occurrences in findings.items():
            for occ in occurrences:
                pattern_type = occ.get('type', 'dynamic')
                if pattern_type not in pattern_groups:
                    pattern_groups[pattern_type] = []
                pattern_groups[pattern_type].append(string)
        
        # Generate pattern templates
        report.append("## Conditional String Patterns Found\n")
        
        if 'ternary' in pattern_groups:
            report.append("### Ternary Conditionals")
            report.append("Pattern: `condition ? 'string1' : 'string2'`")
            for s in list(set(pattern_groups['ternary']))[:5]:
                report.append(f"- {s}")
        
        if 'if_return' in pattern_groups:
            report.append("\n### If Statement Returns")
            report.append("Pattern: `if (condition) { return 'string'; }`")
            for s in list(set(pattern_groups['if_return']))[:5]:
                report.append(f"- {s}")
        
        return report

def main():
    finder = ConditionalStringFinder()
    
    # Define the examples of missed strings
    known_missed_strings = [
        "damaged hair and breakage",
        "in their thirties",
        "experience less",
        "within 14 days",
        "That's an outstanding score!",
        "9 out of 10 women",
        "Only 6 seats remaining",
        "You deserve this,",
        "Probability to fix your damaged hair in 14 days:",
    ]
    
    print("🔍 Searching for Conditional and Dynamic Strings")
    print("=" * 80)
    
    # Since we only have app_state.dart, let's create a comprehensive detection system
    all_conditional_strings = {}
    
    # Add the known missed strings
    print("\n📋 Known Missed Conditional Strings:")
    for string in known_missed_strings:
        all_conditional_strings[string] = {
            'status': 'known_missed',
            'needs_translation': True
        }
        print(f"  - {string}")
    
    # Define patterns for finding similar strings
    print("\n🎯 Patterns to Search For:")
    
    # 1. Percentage patterns
    percentage_patterns = [
        r'\d+(?:\.\d+)?%\s+of\s+(?:women|men|people|users)',
        r'(?:shows?|indicates?|proves?)\s+that\s+\d+(?:\.\d+)?%',
    ]
    
    # 2. Time-based conditionals
    time_patterns = [
        r'in\s+(?:their|your|my)\s+(?:twenties|thirties|forties|fifties|60s|70s)',
        r'within\s+\d+\s+(?:days?|weeks?|months?)',
        r'after\s+(?:the\s+)?(?:challenge|program|routine)',
    ]
    
    # 3. Score/result conditionals
    score_patterns = [
        r"That's\s+an?\s+(?:outstanding|excellent|good|average|poor)\s+score",
        r'Your?\s+(?:score|result|match)\s+is\s+\d+',
        r'\d+\s+out\s+of\s+\d+\s+(?:women|men|people)',
    ]
    
    # 4. Motivational/personal
    personal_patterns = [
        r'You\s+deserve',
        r'(?:Hello|Hi|Welcome),?\s+\w+',
        r'Join\s+the\s+\d+-Day',
        r'Only\s+\d+\s+\w+\s+remaining',
    ]
    
    # 5. Conditional advice
    advice_patterns = [
        r'With\s+the\s+right\s+(?:routine|approach|method)',
        r'But\s+if\s+you\s+(?:are\s+)?still',
        r"you're\s+missing\s+(?:important|crucial|key)",
        r"That's\s+why\s+(?:nothing|it)",
    ]
    
    # Create a comprehensive list of potential conditional strings
    potential_strings = {
        # Age-based variations
        "in their twenties": "in ihren Zwanzigern",
        "in their forties": "in ihren Vierzigern",
        "in their fifties": "in ihren Fünfzigern",
        "in your 20s": "in deinen 20ern",
        "in your 40s": "in deinen 40ern",
        
        # Score variations
        "That's an excellent score!": "Das ist ein ausgezeichneter Wert!",
        "That's a good score!": "Das ist ein guter Wert!",
        "That's an average score.": "Das ist ein durchschnittlicher Wert.",
        
        # Percentage variations
        "85% of women": "85% der Frauen",
        "95% of women": "95% der Frauen",
        "research shows that": "Untersuchungen zeigen, dass",
        
        # Time variations
        "within 7 days": "innerhalb von 7 Tagen",
        "within 21 days": "innerhalb von 21 Tagen",
        "within 30 days": "innerhalb von 30 Tagen",
        "after the program": "nach dem Programm",
        
        # Urgency variations
        "Only 3 seats remaining": "Nur noch 3 Plätze verfügbar",
        "Only 10 seats remaining": "Nur noch 10 Plätze verfügbar",
        "Limited time offer": "Zeitlich begrenztes Angebot",
        
        # Personal variations
        "You deserve this, [Name]": "Du hast das verdient, [Name]",
        "Welcome, [Name]": "Willkommen, [Name]",
        "Hello [Name]": "Hallo [Name]",
        
        # Conditional results
        "said their hair improved": "sagten, dass sich ihr Haar verbesserte",
        "noticed less breakage": "bemerkten weniger Haarbruch",
        "saw new growth": "sahen neues Wachstum",
    }
    
    # Save the comprehensive conditional string mapping
    output_dir = Path('translations')
    output_dir.mkdir(exist_ok=True)
    
    conditional_strings_file = output_dir / 'conditional_strings_mapping.json'
    with open(conditional_strings_file, 'w', encoding='utf-8') as f:
        json.dump({
            'description': 'Conditional and dynamic strings that need translation',
            'patterns': {
                'percentage': percentage_patterns,
                'time_based': time_patterns,
                'score_based': score_patterns,
                'personal': personal_patterns,
                'advice': advice_patterns
            },
            'known_strings': known_missed_strings,
            'potential_strings': potential_strings,
            'instructions': 'Add any new conditional strings found in the app to this file'
        }, f, indent=2, ensure_ascii=False)
    
    print(f"\n✅ Created conditional strings mapping: {conditional_strings_file}")
    
    # Generate a report
    report = [
        "# Conditional Strings Report",
        "",
        "## Summary",
        f"- Known missed strings: {len(known_missed_strings)}",
        f"- Potential conditional strings: {len(potential_strings)}",
        "",
        "## Pattern Categories",
        "",
        "### 1. Age-based Conditionals",
        "- `in their [age group]`",
        "- `in your [age]s`",
        "",
        "### 2. Score/Result Conditionals", 
        "- `That's a/an [quality] score!`",
        "- `[percentage]% of [group]`",
        "- `[number] out of [total]`",
        "",
        "### 3. Time-based Conditionals",
        "- `within [number] days`",
        "- `after the [event]`",
        "",
        "### 4. Personal/Dynamic Text",
        "- `You deserve this, [Name]`",
        "- `Hello/Welcome [Name]`",
        "",
        "### 5. Urgency/Scarcity",
        "- `Only [number] [items] remaining`",
        "- `Hurry up!`",
        "",
        "## Next Steps",
        "1. Search for these patterns in all Flutter files",
        "2. Add found strings to conditional_strings_mapping.json",
        "3. Update robust_translation_system.py with translations",
        "4. Test with different user conditions/states"
    ]
    
    report_file = output_dir / 'conditional_strings_report.md'
    with open(report_file, 'w', encoding='utf-8') as f:
        f.write('\n'.join(report))
    
    print(f"✅ Created conditional strings report: {report_file}")
    
    print("\n📝 To find more conditional strings:")
    print("1. Search for ternary operators: ? 'string1' : 'string2'")
    print("2. Search for if statements returning strings")
    print("3. Search for switch/case with string returns")
    print("4. Search for string interpolation: ${variable}")
    print("5. Search for dynamic builders and setState calls")

if __name__ == "__main__":
    main()