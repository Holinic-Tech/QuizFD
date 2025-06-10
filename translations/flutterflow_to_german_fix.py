#!/usr/bin/env python3
"""
FlutterFlow to German Translation Fix
This script applies ALL missing German translations identified from the flutterflow branch,
fixing every single untranslated string for 100% coverage.
"""

import re
import sys
from pathlib import Path
from typing import Dict, List, Tuple

# Complete German translations for all missing strings
GERMAN_TRANSLATIONS = {
    # Hair Type - missing "I don't know"
    "I don't know": "Weiß ich nicht",
    "I don\\'t know": "Weiß ich nicht",
    
    # Hair goals
    "I want to stop my hair loss": "Ich will meinen Haarausfall stoppen",
    "I want longer, better looking hair": "Ich will längeres, schöneres Haar",
    "I want both": "Ich will beides",
    
    # Hair types
    "Straight": "Glatt",
    "Wavy": "Wellig", 
    "Curly": "Lockig",
    "Coily": "Kraus",
    
    # Hair concerns
    "Hair loss or hair thinning": "Haarausfall oder dünner werdendes Haar",
    "Damage from dye, heat, or chemical treatments": "Schäden durch Färben, Hitze oder chemische Behandlungen",
    "Scalp irritation or dandruff": "Kopfhautreizungen oder Schuppen",
    "Split ends, frizz, and dryness": "Spliss, Frizz und Trockenheit",
    "Other, mixed issues": "Andere, gemischte Probleme",
    
    # Loading messages
    "Checking your hair condition": "Checke deinen Haarzustand",
    "Analysing your routine": "Analysiere deine Routine",
    "Checking your challenge-fit": "Prüfe, ob die Challenge zu dir passt",
    
    # Loading widget messages
    "🚫 No more hidden harmful ingredients.": "🚫 Schluss mit versteckten schädlichen Inhaltsstoffen.",
    "🌱 Reduced hair loss and new baby hair growth.": "🌱 Weniger Haarausfall und neue Babyhaare.",
    "✅ Split ends that don't come back.": "✅ Spliss, der nicht wiederkommt.",
    "💛 The best of science, made easy at home.": "💛 Das Beste aus der Wissenschaft, einfach für zu Hause.",
    
    # Multi-choice answers
    "Heat styling": "Hitze-Styling",
    "Bleaching / hair colour": "Bleichen / Haarfarbe",
    "Bleaching / hair colouring": "Bleichen / Haarfarbe",
    "Sun exposure": "Sonneneinstrahlung",
    "Frequent swimming": "Häufiges Schwimmen",
    "Tight hair styles (braids, bun, ponytail...)": "Straffe Frisuren (Zöpfe, Dutt, Pferdeschwanz...)",
    "None of the above": "Nichts davon",
    
    # Diet options
    "No specific diet": "Keine spezielle Ernährung",
    "I don't have any dietary restrictions": "Ich habe keine Ernährungseinschränkungen",
    "Vegetarian": "Vegetarisch",
    "I abstain from meat, fish, and poultry\\nproducts": "Ich verzichte auf Fleisch, Fisch und Geflügel\\nprodukte",
    "Gluten-free": "Glutenfrei", 
    "I avoid wheat, barley, rye or other grains": "Ich meide Weizen, Gerste, Roggen oder andere Getreide",
    "Vegan": "Vegan",
    "I avoid all animal-based products: meat,\\neggs, dairy, etc. Plant-based foods only": "Ich vermeide alle tierischen Produkte: Fleisch,\\nEier, Milchprodukte usw. Nur pflanzliche Lebensmittel",
    "Other": "Andere",
    
    # Multi-choice with images
    "Rosemary oil is a universal treatment": "Rosmarinöl ist ein Universalmittel",
    "Coconut oil is the best hair oil": "Kokosöl ist das beste für die Haare",
    "Rice water will make your hair grow faster": "Reiswasser lässt deine Haare schneller wachsen",
    "Natural and organic products are better": "Natürliche und biologische Produkte sind besser",
    "Hair can heal like the skin": "Haare können wie die Haut heilen",
    
    # Plan data
    "14 Day Challenge": "14-Tage-Challenge",
    
    # Personal plan titles
    "14 Day Haircare Journal & Templates": "14-Tage Haarpflege-Tagebuch & Vorlagen",
    "DIY Luxury Shampoo Workshop": "DIY Luxus-Shampoo Workshop",
    "Haircare Ingredients No-No List": "Haarpflege No-Go Inhaltsstoffe Liste",
    "Total Hair Wellness Handbook": "Komplettes Haar-Wellness Handbuch",
    "Silicones & Sulfates Smart Usage Manual": "Silikone & Sulfate - Clevere Anwendung",
    "30 Day Hair Mindfulness Experience": "30-Tage Haar-Achtsamkeits-Erfahrung", 
    "Exclusive Members-Only Community": "Exklusive Mitglieder-Community",
    "Haircare Product Analyzer": "Haarpflege-Produkt-Analyzer",
    "Certificate of Completion": "Teilnahme-Zertifikat",
    
    # Age options
    "18 - 29": "18 - 29",
    "30 - 39": "30 - 39", 
    "40 - 49": "40 - 49",
    "50 +": "50 +",
    
    # Knowledge state answers
    "🙌 Yes, but I need more support": "🙌 Ja, aber ich brauche mehr Unterstützung",
    "😢 No and I'm tired of searching": "😢 Nein und ich bin es leid zu suchen",
    "😥 Not sure, it's complicated by myself": "😥 Nicht sicher, alleine ist es kompliziert",
    
    # Hairqare knowledge answers
    "I'm hearing about it for the first time": "Höre zum ersten Mal davon",
    "I know a few things": "Ich weiß ein paar Dinge",
    "Yes, I know everything about it": "Ja, ich weiß alles darüber",
    
    # Mindset state
    "Yes, definitely": "Ja, definitiv",
    "You're absolutely right!": "Du hast absolut recht!",
    "Diet, stress, environment, and internal health all impact your hair. Our holistic approach addresses ALL these factors for truly transformative results.": "Ernährung, Stress, Umwelt und innere Gesundheit - alles beeinflusst deine Haare. Unser ganzheitlicher Ansatz kümmert sich um ALLE diese Faktoren für wirklich transformative Ergebnisse.",
    
    "Maybe, I'm not sure": "Vielleicht, ich bin mir nicht sicher",
    "You're on the right track!": "Du bist auf dem richtigen Weg!",
    
    "I've never considered that": "Das habe ich noch nie in Betracht gezogen",
    "You'll be surprised!": "Du wirst überrascht sein!",
    
    "No, I just need the right product": "Nein, ich brauche nur das richtige Produkt",
    "It's a common misconception": "Das ist ein häufiges Missverständnis",
    "Most women focus only on external treatments, missing 50% of what determines hair health. Our approach changes that by addressing both internal and external factors for complete hair transformation.": "Die meisten Frauen konzentrieren sich nur auf äußere Behandlungen und verpassen 50% dessen, was die Haargesundheit bestimmt. Unser Ansatz ändert das, indem wir sowohl innere als auch äußere Faktoren für eine komplette Haartransformation angehen.",
    
    # Diet choices
    "Fast food / Processed food diet": "Fast Food / Verarbeitete Lebensmittel",
    "Balanced / Whole foods": "Ausgewogen / Vollwertkost",
    "Custom nutrition protocol": "Individuelles Ernährungsprotokoll",
    "Vegan / vegetarian": "Vegan / vegetarisch",
    "Something else": "Etwas anderes",
    
    # Spending amounts and descriptions
    "Less than $10": "Weniger als 10€",
    "Awesome 🤩 you're budget conscious!": "Super 🤩 du achtest auf dein Budget!",
    "You can actually have amazing results without spending more than you do now (or even less) while avoiding harmful products that secretly ruin your hair. You just need the right routine for your unique situation.": "Du kannst tatsächlich tolle Ergebnisse erzielen, ohne mehr auszugeben als jetzt (oder sogar weniger), während du schädliche Produkte vermeidest, die heimlich deine Haare ruinieren. Du brauchst nur die richtige Routine für deine einzigartige Situation.",
    
    "$10 - $20": "10€ - 20€",
    "Amazing 🙌 you value your hair!": "Großartig 🙌 du schätzt deine Haare!",
    "You're spending thoughtfully, but likely still paying for marketing rather than results. With the right routine, you could get truly transformative results tailored to your unique needs without spending more.": "Du gibst bewusst Geld aus, zahlst aber wahrscheinlich immer noch für Marketing statt für Ergebnisse. Mit der richtigen Routine könntest du wirklich transformative Ergebnisse erzielen, die auf deine einzigartigen Bedürfnisse zugeschnitten sind, ohne mehr auszugeben.",
    
    "$20 - $50": "20€ - 50€",
    "You clearly care about your hair 💜": "Dir sind deine Haare eindeutig wichtig 💜",
    "Did you know, in premium haircare up to 90% of what you're paying goes to packaging and marketing, not quality ingredients? With the right routine, you can actually get the premium results you're looking for without the price tag.": "Wusstest du, dass bei Premium-Haarpflege bis zu 90% deines Geldes für Verpackung und Marketing draufgeht, nicht für hochwertige Inhaltsstoffe? Mit der richtigen Routine kannst du tatsächlich die Premium-Ergebnisse bekommen, die du suchst, ohne den hohen Preis.",
    
    "More than $50": "Mehr als 50€",
    "Your hair deserves the best ✨": "Deine Haare verdienen das Beste ✨",
    "Did you know premium haircare often uses the same ingredients as budget options? With the right personalized routine, you can actually achieve the results those luxury brands are just promising.": "Wusstest du, dass Premium-Haarpflege oft dieselben Inhaltsstoffe verwendet wie günstige Optionen? Mit der richtigen personalisierten Routine kannst du tatsächlich die Ergebnisse erzielen, die diese Luxusmarken nur versprechen.",
    
    # Hair myths
    "Rosemary oil is reduces hair loss": "Rosmarinöl reduziert Haarausfall",
    "Coconut oil is the best hair oil": "Kokosöl ist das beste für die Haare",
    "Rice water makes hair grow faster": "Reiswasser lässt die Haare schneller wachsen",
    "Natural / organic products are better": "Natürliche/Bio-Produkte sind besser",
    "Not washing hair is good for the scalp": "Die Haare nicht zu waschen ist gut für die Kopfhaut",
    
    # Hair damage activities
    "Heat styling": "Hitze-Styling",
    "Bleaching / hair colouring": "Bleichen / Haarfarbe", 
    "Sun exposure": "Sonneneinstrahlung",
    "Frequent swimming": "Häufiges Schwimmen",
    "Tight hair styles (braids, bun, ponytail...)": "Straffe Frisuren (Zöpfe, Dutt, Pferdeschwanz...)",
    
    # Professional referral
    "Yes": "Ja",
    "No": "Nein", 
    "I'm a professional": "Ich bin ein Profi",
    
    # Current routine
    "🤓 Advanced": "🤓 Fortgeschritten",
    "Salon visits, premium products, specialists, supplements": "Salonbesuche, Premium-Produkte, Spezialisten, Nahrungsergänzungsmittel",
    "🫧 Basic care": "🫧 Grundpflege",
    "Mostly just shampoo and conditioner": "Hauptsächlich nur Shampoo und Conditioner",
    "🤗 Occasional pampering": "🤗 Gelegentliche Verwöhnung",
    "Basic care and occasional hair masks": "Grundpflege und gelegentliche Haarmasken",
    "🌿 Natural remedies": "🌿 Natürliche Heilmittel",
    "Mostly oils, herbs or DIY treatments": "Hauptsächlich Öle, Kräuter oder DIY-Behandlungen",
    "😌 None of the above": "😌 Nichts davon",
    "I follow a different haircare routine": "Ich folge einer anderen Haarpflege-Routine",
    
    # Common answers
    "Answer 1": "Antwort 1",
    "Answer 2": "Antwort 2", 
    "Answer 3": "Antwort 3",
    "Answer 4": "Antwort 4",
    "Hello World": "Hallo Welt",
}

def apply_german_translations(file_path: Path) -> Tuple[str, int]:
    """Apply German translations to a file"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        return f"Error reading file: {e}", 0
    
    original_content = content
    replacements_made = 0
    
    # Sort translations by length (longest first) to avoid partial replacements
    sorted_translations = sorted(GERMAN_TRANSLATIONS.items(), key=lambda x: len(x[0]), reverse=True)
    
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
    
    parser = argparse.ArgumentParser(description='Apply German translations to FlutterFlow files')
    parser.add_argument('directory', help='Directory to process')
    parser.add_argument('--dry-run', action='store_true', help='Show what would be changed without modifying files')
    
    args = parser.parse_args()
    
    directory = Path(args.directory)
    if not directory.exists():
        print(f"Error: Directory {directory} does not exist")
        sys.exit(1)
    
    # Find all Dart files
    dart_files = list(directory.rglob('*.dart'))
    
    print(f"🔧 Applying German translations to {len(dart_files)} files...")
    
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
                for english, german in GERMAN_TRANSLATIONS.items():
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
            result, replacements = apply_german_translations(dart_file)
            print(f"  {result}")
            if replacements > 0:
                total_replacements += replacements
                files_updated += 1
    
    print(f"\n🎉 German translation fix complete!")
    print(f"📊 Summary:")
    print(f"  - Files processed: {len(dart_files)}")
    print(f"  - Files updated: {files_updated}")
    print(f"  - Total replacements: {total_replacements}")
    
    if args.dry_run:
        print("\n🔍 This was a dry run - no files were actually modified")
    else:
        print(f"\n✅ All German translations have been applied!")

if __name__ == "__main__":
    main()