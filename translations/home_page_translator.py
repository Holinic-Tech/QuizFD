#!/usr/bin/env python3
"""
Special translator for home page strings including complex conditional strings.
"""

import re
import argparse
from pathlib import Path
from typing import Dict, List, Tuple

# Home page specific translations
HOME_PAGE_TRANSLATIONS = {
    'de': {
        # Question strings with conditionals
        "Do you already know exactly": "Weißt du bereits genau",
        "what's triggering your hair fall or thinning?": "was deinen Haarausfall oder dünner werdendes Haar auslöst?",
        "how you can tame your frizz and dryness?": "wie du Frizz und Trockenheit in den Griff bekommst?",
        "what's behind your scalp irritation or dandruff issues?": "was hinter deinen Kopfhautreizungen oder Schuppenproblemen steckt?",
        "how you can save your hair from further damage?": "wie du deine Haare vor weiteren Schäden schützen kannst?",
        "what's causing your hair issues?": "was deine Haarprobleme verursacht?",
        
        # Conditional style strings
        "With the right routine it's fine to": "Mit der richtigen Routine ist es in Ordnung,",
        "to style, curl or color your hair. ": "deine Haare zu stylen, zu locken oder zu färben. ",
        "live an active lifestyle.": "einen aktiven Lebensstil zu führen.",
        "style your hair any way you like and do the activities you enjoy.": "deine Haare zu stylen, wie du möchtest, und die Aktivitäten zu machen, die dir Spaß machen.",
        
        # Missing knowledge strings
        "But if you are still struggling with": "Aber wenn du immer noch kämpfst mit",
        "despite all the treatments, specialists and products you've tried, you're missing important haircare knowledge. ": "trotz aller Behandlungen, Spezialisten und Produkte, die du ausprobiert hast, fehlt dir wichtiges Haarpflege-Wissen. ",
        "while only relying on using shampoo & conditioner, you're missing important haircare knowledge. ": "während du dich nur auf Shampoo und Conditioner verlässt, fehlt dir wichtiges Haarpflege-Wissen. ",
        "despite making time for hair masks and other treatments, you're missing important haircare knowledge. ": "obwohl du dir Zeit für Haarmasken und andere Behandlungen nimmst, fehlt dir wichtiges Haarpflege-Wissen. ",
        "despite using organic products and home remedies, you're missing important haircare knowledge. ": "trotz der Verwendung von Bio-Produkten und Hausmitteln fehlt dir wichtiges Haarpflege-Wissen. ",
        "despite what you've already tried, you're missing important haircare knowledge. ": "trotz allem, was du bereits versucht hast, fehlt dir wichtiges Haarpflege-Wissen. ",
        
        # Conditional hair issues
        " hair loss and thinning": " Haarausfall und dünner werdendes Haar",
        " split ends and dryness": " Spliss und Trockenheit",
        " dandruff and scalp irritation": " Schuppen und Kopfhautreizungen",
        " damaged hair and breakage": " geschädigtes Haar und Haarbruch",
        " mixed hair issues": " gemischte Haarprobleme",
        
        # Mindset question
        "Do you believe your hair problems could be influenced by factors beyond just products?": "Glaubst du, dass deine Haarprobleme von Faktoren beeinflusst werden könnten, die über reine Produkte hinausgehen?",
        
        # Other strings
        "See if the Challenge is a fit for you and your hair profile": "Finde heraus, ob die Challenge zu dir und deinem Haarprofil passt",
    },
    'es': {
        # Question strings with conditionals
        "Do you already know exactly": "¿Ya sabes exactamente",
        "what's triggering your hair fall or thinning?": "qué está provocando tu caída o adelgazamiento del cabello?",
        "how you can tame your frizz and dryness?": "cómo puedes controlar tu frizz y sequedad?",
        "what's behind your scalp irritation or dandruff issues?": "qué hay detrás de tu irritación del cuero cabelludo o problemas de caspa?",
        "how you can save your hair from further damage?": "cómo puedes salvar tu cabello de más daño?",
        "what's causing your hair issues?": "qué está causando tus problemas capilares?",
        
        # Conditional style strings
        "With the right routine it's fine to": "Con la rutina adecuada está bien",
        "to style, curl or color your hair. ": "peinar, rizar o teñir tu cabello. ",
        "live an active lifestyle.": "vivir un estilo de vida activo.",
        "style your hair any way you like and do the activities you enjoy.": "peinar tu cabello como quieras y hacer las actividades que disfrutas.",
        
        # Missing knowledge strings
        "But if you are still struggling with": "Pero si todavía luchas con",
        "despite all the treatments, specialists and products you've tried, you're missing important haircare knowledge. ": "a pesar de todos los tratamientos, especialistas y productos que has probado, te falta conocimiento importante sobre el cuidado del cabello. ",
        "while only relying on using shampoo & conditioner, you're missing important haircare knowledge. ": "mientras solo confías en usar champú y acondicionador, te falta conocimiento importante sobre el cuidado del cabello. ",
        "despite making time for hair masks and other treatments, you're missing important haircare knowledge. ": "aunque dedicas tiempo a mascarillas y otros tratamientos, te falta conocimiento importante sobre el cuidado del cabello. ",
        "despite using organic products and home remedies, you're missing important haircare knowledge. ": "a pesar de usar productos orgánicos y remedios caseros, te falta conocimiento importante sobre el cuidado del cabello. ",
        "despite what you've already tried, you're missing important haircare knowledge. ": "a pesar de lo que ya has intentado, te falta conocimiento importante sobre el cuidado del cabello. ",
        
        # Conditional hair issues
        " hair loss and thinning": " pérdida y adelgazamiento del cabello",
        " split ends and dryness": " puntas abiertas y sequedad",
        " dandruff and scalp irritation": " caspa e irritación del cuero cabelludo",
        " damaged hair and breakage": " cabello dañado y rotura",
        " mixed hair issues": " problemas capilares mixtos",
        
        # Mindset question
        "Do you believe your hair problems could be influenced by factors beyond just products?": "¿Crees que tus problemas capilares podrían estar influenciados por factores más allá de solo productos?",
        
        # Other strings
        "See if the Challenge is a fit for you and your hair profile": "Descubre si el Reto es adecuado para ti y tu perfil capilar",
    }
}

def translate_home_page_strings(content: str, lang: str) -> Tuple[str, List[Tuple[str, str]]]:
    """Translate home page specific strings."""
    translations = HOME_PAGE_TRANSLATIONS.get(lang, {})
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
    
    # Apply home page translations
    new_content, replacements = translate_home_page_strings(content, lang)
    
    return new_content, replacements

def main():
    parser = argparse.ArgumentParser(description='Translate home page strings')
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