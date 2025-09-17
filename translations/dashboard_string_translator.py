#!/usr/bin/env python3
"""
Dashboard String Translator
Handles hardcoded strings in dashboard widgets that don't use FFLocalizations
"""

import re
import argparse
from pathlib import Path
from typing import Dict, List, Tuple

DASHBOARD_TRANSLATIONS = {
    'de': {
        # Dashboard widget strings
        "That's an outstanding score!": "Das ist ein hervorragender Wert!",
        "You deserve this,": "Du hast das verdient,",
        "You deserve this": "Du hast das verdient",
        "Join the 14-Day Haircare Challenge": "Nimm an der 14-Tage Haarpflege-Challenge teil",
        "START MY CHALLENGE": "MEINE CHALLENGE STARTEN",
        "RESERVE MY SEAT": "MEINEN PLATZ RESERVIEREN",
        
        # Focus strings
        "Hair loss": "Haarausfall",
        "Split ends": "Spliss",
        "Scalp issues": "Kopfhautprobleme",
        "Damaged hair": "Geschädigte Haare",
        "Mixed issues": "Gemischte Probleme",
        
        # Main trigger strings
        "Stress": "Stress",
        "Hormones": "Hormone",
        "Product buildup": "Produktablagerungen",
        "Environmental factors": "Umweltfaktoren",
        "Unknown causes": "Unbekannte Ursachen",
        
        # Plan focus strings
        "Reduce hair fall": "Haarausfall reduzieren",
        "Repair damage": "Schäden reparieren",
        "Soothe scalp": "Kopfhaut beruhigen",
        "Strengthen hair": "Haare stärken",
        "Overall improvement": "Allgemeine Verbesserung",
        
        # Additional dashboard text
        "Women with similar profiles achieved": "Frauen mit ähnlichen Profilen erreichten",
        "reduction in": "Reduzierung von",
        "improvement in": "Verbesserung in",
        "hair health": "Haargesundheit",
        "within 14 days": "innerhalb von 14 Tagen",
        
        # Personal plan text
        "Your personal plan addresses:": "Dein persönlicher Plan behandelt:",
        "Main trigger:": "Hauptauslöser:",
        "Focus:": "Fokus:",
        
        # Countdown timer
        "Your spot expires in": "Dein Platz verfällt in",
        "minutes": "Minuten",
        "seconds": "Sekunden",
    },
    'es': {
        # Dashboard widget strings
        "That's an outstanding score!": "¡Es una puntuación excelente!",
        "You deserve this,": "Te mereces esto,",
        "You deserve this": "Te mereces esto",
        "Join the 14-Day Haircare Challenge": "Únete al Reto de Cuidado Capilar de 14 Días",
        "START MY CHALLENGE": "EMPEZAR MI RETO",
        "RESERVE MY SEAT": "RESERVAR MI PLAZA",
        
        # Focus strings
        "Hair loss": "Caída del cabello",
        "Split ends": "Puntas abiertas",
        "Scalp issues": "Problemas del cuero cabelludo",
        "Damaged hair": "Cabello dañado",
        "Mixed issues": "Problemas mixtos",
        
        # Main trigger strings
        "Stress": "Estrés",
        "Hormones": "Hormonas",
        "Product buildup": "Acumulación de productos",
        "Environmental factors": "Factores ambientales",
        "Unknown causes": "Causas desconocidas",
        
        # Plan focus strings
        "Reduce hair fall": "Reducir caída",
        "Repair damage": "Reparar daños",
        "Soothe scalp": "Calmar cuero cabelludo",
        "Strengthen hair": "Fortalecer cabello",
        "Overall improvement": "Mejora general",
        
        # Additional dashboard text
        "Women with similar profiles achieved": "Mujeres con perfiles similares lograron",
        "reduction in": "reducción en",
        "improvement in": "mejora en",
        "hair health": "salud capilar",
        "within 14 days": "en 14 días",
        
        # Personal plan text
        "Your personal plan addresses:": "Tu plan personal aborda:",
        "Main trigger:": "Desencadenante principal:",
        "Focus:": "Enfoque:",
        
        # Countdown timer
        "Your spot expires in": "Tu plaza expira en",
        "minutes": "minutos",
        "seconds": "segundos",
    }
}

def translate_dashboard_strings(content: str, lang: str) -> Tuple[str, List[Tuple[str, str]]]:
    """Translate dashboard specific strings."""
    translations = DASHBOARD_TRANSLATIONS.get(lang, {})
    replacements = []
    
    # Sort by length to ensure longer strings are replaced first
    sorted_translations = sorted(translations.items(), key=lambda x: len(x[0]), reverse=True)
    
    for english, translated in sorted_translations:
        # Count occurrences before replacement
        count = content.count(english)
        if count > 0:
            # Replace the string
            content = content.replace(english, translated)
            replacements.append((english, translated))
    
    return content, replacements

def translate_file(file_path: Path, lang: str) -> Tuple[str, List[Tuple[str, str]]]:
    """Translate a single file."""
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Apply dashboard translations
    new_content, replacements = translate_dashboard_strings(content, lang)
    
    return new_content, replacements

def main():
    parser = argparse.ArgumentParser(description='Translate dashboard strings')
    parser.add_argument('file_paths', nargs='+', help='Paths to files to translate')
    parser.add_argument('--lang', default='de', choices=['de', 'es'], help='Target language')
    parser.add_argument('--dry-run', action='store_true', help='Show changes without writing')
    
    args = parser.parse_args()
    
    total_replacements = []
    
    for file_path_str in args.file_paths:
        file_path = Path(file_path_str)
        if not file_path.exists():
            print(f"Warning: {file_path} does not exist")
            continue
            
        print(f"\nProcessing {file_path}...")
        new_content, replacements = translate_file(file_path, args.lang)
        
        if replacements:
            print(f"  Found {len(replacements)} strings to translate:")
            for eng, trans in replacements:
                print(f"    '{eng}' → '{trans}'")
            total_replacements.extend(replacements)
            
            if not args.dry_run:
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(new_content)
                print(f"  ✅ Updated {file_path}")
        else:
            print("  No translatable strings found")
    
    print(f"\nTotal: {len(total_replacements)} translations made")

if __name__ == "__main__":
    main()