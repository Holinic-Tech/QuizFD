#!/usr/bin/env python3
"""
Complete Missing Translations Fix
This script addresses ALL the missing translations identified from the flutterflow branch,
including app_state.dart, pitch screens, login screens, and dashboard conditional strings.
"""

import re
import sys
from pathlib import Path
from typing import Dict, List, Tuple

# ALL MISSING TRANSLATIONS based on user's specific feedback
MISSING_TRANSLATIONS = {
    'de': {
        # app_state.dart missing translations
        
        # hairType - the "I don't know" option
        '"I don\\'t know"': '"Weiß ich nicht"',
        '"I don\\\\\\\'t know"': '"Weiß ich nicht"',  # Escaped version
        
        # currentRoutine - ALL missing descriptions
        '"Basic routine for busy people"': '"Grundroutine für beschäftigte Menschen"',
        '"Just the essentials, nothing fancy"': '"Nur das Wesentliche, nichts Ausgefallenes"',
        '"Salon visits, premium products, specialists, supplements"': '"Salonbesuche, Premium-Produkte, Spezialisten, Nahrungsergänzungsmittel"',
        '"Complex routine with professional guidance"': '"Komplexe Routine mit professioneller Anleitung"',
        '"Basic care and occasional hair masks"': '"Grundpflege und gelegentliche Haarmasken"',
        '"A little extra love when you have time"': '"Ein bisschen zusätzliche Liebe, wenn du Zeit hast"',
        '"Mostly oils, herbs or DIY treatments"': '"Hauptsächlich Öle, Kräuter oder DIY-Behandlungen"',
        '"Pure ingredients, made at home"': '"Reine Zutaten, selbst gemacht"',
        '"I follow a different haircare routine"': '"Ich folge einer anderen Haarpflegeroutine"',
        '"Tell us more in the next step"': '"Erzähl uns mehr im nächsten Schritt"',
        
        # knowledgeState - missing answer fields
        '"🙌 Yes, but I need more support"': '"🙌 Ja, aber ich brauche mehr Unterstützung"',
        '"😢 No and I\\'m tired of searching"': '"😢 Nein und ich bin es leid zu suchen"',
        '"😥 Not sure, it\\'s complicated by myself"': '"😥 Nicht sicher, alleine ist es kompliziert"',
        
        # hairqareKnowledge - missing answers
        '"I\\'m hearing about it for the first time"': '"Höre zum ersten Mal davon"',
        '"I know a few things"': '"Ich weiß ein paar Dinge"',
        '"Yes, I know everything about it"': '"Ja, ich weiß alles darüber"',
        
        # shampooSpending - complete objects with titles and descriptions
        '"Less than $10"': '"Weniger als 10€"',
        '"Awesome 🤩 you\\'re budget conscious!"': '"Super 🤩 du achtest auf dein Budget!"',
        '"You can actually have amazing results without spending more than you do now (or even less) while avoiding harmful products that secretly ruin your hair. You just need the right routine for your unique situation."': '"Du kannst tatsächlich tolle Ergebnisse erzielen, ohne mehr auszugeben als jetzt (oder sogar weniger), während du schädliche Produkte vermeidest, die heimlich deine Haare ruinieren. Du brauchst nur die richtige Routine für deine einzigartige Situation."',
        
        '"$10 - $20"': '"10€ - 20€"',
        '"Amazing 🙌 you value your hair!"': '"Großartig 🙌 du schätzt deine Haare!"',
        '"You\\'re spending thoughtfully, but likely still paying for marketing rather than results. With the right routine, you could get truly transformative results tailored to your unique needs without spending more."': '"Du gibst bewusst Geld aus, zahlst aber wahrscheinlich immer noch für Marketing statt für Ergebnisse. Mit der richtigen Routine könntest du wirklich transformative Ergebnisse erzielen, die auf deine einzigartigen Bedürfnisse zugeschnitten sind, ohne mehr auszugeben."',
        
        '"$20 - $50"': '"20€ - 50€"',
        '"You clearly care about your hair 💜"': '"Dir sind deine Haare eindeutig wichtig 💜"',
        '"Did you know, in premium haircare up to 90% of what you\\'re paying goes to packaging and marketing, not quality ingredients? With the right routine, you can actually get the premium results you\\'re looking for without the price tag."': '"Wusstest du, dass bei Premium-Haarpflege bis zu 90% deines Geldes für Verpackung und Marketing draufgeht, nicht für hochwertige Inhaltsstoffe? Mit der richtigen Routine kannst du tatsächlich die Premium-Ergebnisse bekommen, die du suchst, ohne den hohen Preis."',
        
        '"More than $50"': '"Mehr als 50€"',
        '"Your hair deserves the best ✨"': '"Deine Haare verdienen das Beste ✨"',
        '"Did you know premium haircare often uses the same ingredients as budget options? With the right personalized routine, you can actually achieve the results those luxury brands are just promising."': '"Wusstest du, dass Premium-Haarpflege oft dieselben Inhaltsstoffe verwendet wie günstige Optionen? Mit der richtigen personalisierten Routine kannst du tatsächlich die Ergebnisse erzielen, die diese Luxusmarken nur versprechen."',
        
        # hairMyth - missing answers
        '"Rosemary oil reduces hair loss"': '"Rosmarinöl reduziert Haarausfall"',
        '"Coconut oil is the best hair oil"': '"Kokosöl ist das beste für die Haare"',
        '"Rice water makes hair grow faster"': '"Reiswasser lässt die Haare schneller wachsen"',
        '"Natural / organic products are better"': '"Natürliche/Bio-Produkte sind besser"',
        '"Not washing hair is good for the scalp"': '"Die Haare nicht zu waschen ist gut für die Kopfhaut"',
        
        # hairDamageActivity - missing answers
        '"Heat styling (blow dry, straighten, curl)"': '"Hitze-Styling (Föhnen, Glätten, Locken)"',
        '"Chemical treatments (dye, bleach, perm)"': '"Chemische Behandlungen (Färben, Bleichen, Dauerwelle)"',
        '"Tight hairstyles or extensions"': '"Straffe Frisuren oder Extensions"',
        '"Swimming in chlorinated pools"': '"Schwimmen in gechlorten Pools"',
        '"Sun exposure without protection"': '"Sonneneinstrahlung ohne Schutz"',
        '"None of the above"': '"Nichts davon"',
        
        # professionalReferral - missing answers
        '"Yes, by a dermatologist"': '"Ja, von einem Hautarzt"',
        '"Yes, by a hair stylist"': '"Ja, von meinem Friseur"',
        '"Yes, by a friend or family"': '"Ja, von Freunden oder Familie"',
        '"No, I found you myself"': '"Nein, ich hab euch selbst gefunden"',
        '"I\\'m a professional"': '"Ich bin ein Profi"',
        
        # Pitch Screens - conditional strings within TextSpan widgets
        '"Did you know research shows that"': '"Wusstest du, dass Untersuchungen zeigen, dass"',
        '"With the right routine it\\'s fine to style your hair any way you like and do the activities you enjoy."': '"Mit der richtigen Routine ist es in Ordnung, deine Haare zu stylen, wie du möchtest, und die Aktivitäten zu machen, die dir Spaß machen."',
        '"But if you are still struggling with damaged hair and breakage while only relying on using shampoo & conditioner, you\\'re missing important haircare knowledge."': '"Aber wenn du immer noch mit geschädigtem Haar und Haarbruch kämpfst, während du dich nur auf Shampoo und Conditioner verlässt, fehlt dir wichtiges Haarpflege-Wissen."',
        '"That\\'s why nothing has worked so far."': '"Deshalb hat bisher nichts funktioniert."',
        '"of women who struggle with damaged hair and breakage in their thirties, experience less breakage and more density within 14 days after switching to a holistic hair care routine."': '"von Frauen, die mit geschädigtem Haar und Haarbruch in ihren Dreißigern kämpfen, erleben weniger Haarbruch und mehr Dichte innerhalb von 14 Tagen nach der Umstellung auf eine ganzheitliche Haarpflegeroutine."',
        
        # Login Screen - partial translations
        '"Probability to fix your geschädigtes Haar in 14 days:"': '"Wahrscheinlichkeit, dein geschädigtes Haar in 14 Tagen zu reparieren:"',
        'Probability to fix your geschädigtes Haar in 14 days:': 'Wahrscheinlichkeit, dein geschädigtes Haar in 14 Tagen zu reparieren:',
        '"geschädigtes Haar"': '"geschädigtes Haar"',  # This should stay as is, it's already German
        
        # Dashboard - mixed language strings and conditional content
        '"That\\'s an outstanding score!"': '"Das ist ein hervorragender Wert!"',
        '"You deserve this,"': '"Du hast das verdient,"',
        '"out of 10 women with this score said"': '"von 10 Frauen mit diesem Wert sagten"',
        '"their shedding stopped"': '"ihr Haarausfall stoppte"',
        '"they started seeing new baby hairs"': '"sie begannen neue Babyhaare zu sehen"',
        '"after the challenge"': '"nach der Challenge"',
        '"My Goal:"': '"Mein Ziel:"',
        '"Stronger, more resilient hair that I can style daily without guilt or worry about damage"': '"Stärkeres, widerstandsfähigeres Haar, das ich täglich stylen kann, ohne Schuldgefühle oder Sorgen vor Schäden"',
        '"Only"': '"Nur noch"',
        '"seats remaining. Hurry Up!"': '"Plätze verfügbar. Beeil dich!"',
        '"and say goodbye to your"': '"und verabschiede dich dauerhaft von deinem"',
        '"permanently with a routine that works"': '"mit einer Routine, die funktioniert"',
        '"No more frustration or disappointments!"': '"Keine Frustration oder Enttäuschungen mehr!"',
        '"Join the 14-Day Haircare Challenge and say goodbye to your damaged hair permanently with a routine that works. No more frustration or disappointments!"': '"Nimm an der 14-Tage Haarpflege-Challenge teil und verabschiede dich dauerhaft von deinem geschädigten Haar mit einer Routine, die funktioniert. Keine Frustration oder Enttäuschungen mehr!"',
        
        # Additional conditionals and variables
        '"damaged hair and breakage"': '"geschädigtes Haar und Haarbruch"',
        '"in their"': '"in ihren"',
        '"experience less"': '"erleben weniger"',
        '"breakage and more density"': '"Haarbruch und mehr Dichte"',
        '"within 14 days"': '"innerhalb von 14 Tagen"',
        '"91.2% of women who struggle with"': '"91,2% der Frauen, die mit"',
        '"kämpfen, erleben weniger"': '"kämpfen, erleben weniger"',
        
        # Common patterns that might be missed
        'I don\\'t know': 'Weiß ich nicht',
        'I don\\\\\\\'t know': 'Weiß ich nicht',
        'geschädigtes Haar': 'geschädigtes Haar',  # Already German
        'geschädigtem Haar': 'geschädigtem Haar',  # Already German
        'damaged hair': 'geschädigtes Haar',
        'hair loss': 'Haarausfall',
        'split ends': 'Spliss',
        'hair problems': 'Haarprobleme',
        'scalp issues': 'Kopfhautprobleme',
        'In my 30s': 'In meinen 30ern',
        'In my 40s': 'In meinen 40ern',
        'In my 50s': 'In meinen 50ern',
    }
}

def apply_comprehensive_translations(file_path: Path, target_lang: str = 'de') -> Tuple[str, int]:
    """Apply comprehensive translations to a file"""
    if target_lang not in MISSING_TRANSLATIONS:
        return "No translations available for this language", 0
    
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        return f"Error reading file: {e}", 0
    
    original_content = content
    translations = MISSING_TRANSLATIONS[target_lang]
    replacements_made = 0
    
    # Sort translations by length (longest first) to avoid partial replacements
    sorted_translations = sorted(translations.items(), key=lambda x: len(x[0]), reverse=True)
    
    for english, german in sorted_translations:
        # Count how many times this replacement is made
        count_before = content.count(english)
        if count_before > 0:
            content = content.replace(english, german)
            count_after = content.count(english)
            actual_replacements = count_before - count_after
            if actual_replacements > 0:
                replacements_made += actual_replacements
                print(f"  ✅ Replaced '{english}' with '{german}' ({actual_replacements} times)")
    
    if content != original_content:
        try:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
            return f"Successfully updated {file_path}", replacements_made
        except Exception as e:
            return f"Error writing file: {e}", 0
    else:
        return f"No changes needed for {file_path}", 0

def main():
    import argparse
    
    parser = argparse.ArgumentParser(description='Apply comprehensive missing translations fix')
    parser.add_argument('directory', help='Directory to process')
    parser.add_argument('--lang', default='de', choices=['de'], help='Target language')
    parser.add_argument('--dry-run', action='store_true', help='Show what would be changed without modifying files')
    
    args = parser.parse_args()
    
    directory = Path(args.directory)
    if not directory.exists():
        print(f"Error: Directory {directory} does not exist")
        sys.exit(1)
    
    # Find all Dart files
    dart_files = list(directory.rglob('*.dart'))
    
    print(f"🔧 Applying comprehensive missing translations fix to {len(dart_files)} files...")
    print(f"🎯 Target language: {args.lang}")
    
    total_replacements = 0
    files_updated = 0
    
    for dart_file in dart_files:
        print(f"\n📄 Processing {dart_file.relative_to(directory)}...")
        
        if args.dry_run:
            # For dry run, just count what would be replaced
            try:
                with open(dart_file, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                replacements = 0
                for english, german in MISSING_TRANSLATIONS[args.lang].items():
                    count = content.count(english)
                    if count > 0:
                        replacements += count
                        print(f"  Would replace '{english}' ({count} times)")
                
                if replacements > 0:
                    total_replacements += replacements
                    files_updated += 1
                    print(f"  Would make {replacements} replacements")
                else:
                    print("  No changes needed")
                    
            except Exception as e:
                print(f"  Error processing file: {e}")
        else:
            # Actually apply the translations
            result, replacements = apply_comprehensive_translations(dart_file, args.lang)
            print(f"  {result}")
            if replacements > 0:
                total_replacements += replacements
                files_updated += 1
    
    print(f"\n🎉 Translation fix complete!")
    print(f"📊 Summary:")
    print(f"  - Files processed: {len(dart_files)}")
    print(f"  - Files updated: {files_updated}")
    print(f"  - Total replacements: {total_replacements}")
    
    if args.dry_run:
        print("\n🔍 This was a dry run - no files were actually modified")
    else:
        print(f"\n✅ All missing translations have been applied!")

if __name__ == "__main__":
    main()