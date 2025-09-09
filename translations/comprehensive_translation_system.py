#!/usr/bin/env python3
"""Comprehensive translation system for German translations."""

import re
import sys
from pathlib import Path

# Comprehensive German translations
TRANSLATIONS = {
    'de': {
        # UI Elements
        'CONTINUE': 'WEITER',
        'Continue': 'Weiter',
        'BACK': 'ZURÜCK',
        'Back': 'Zurück',
        'NEXT': 'WEITER',
        'Next': 'Weiter',
        'SUBMIT': 'ABSENDEN',
        'Submit': 'Absenden',
        'CANCEL': 'ABBRECHEN',
        'Cancel': 'Abbrechen',
        'SAVE': 'SPEICHERN',
        'Save': 'Speichern',
        'DONE': 'FERTIG',
        'Done': 'Fertig',
        'START': 'START',
        'Start': 'Start',
        'FINISH': 'BEENDEN',
        'Finish': 'Beenden',
        'SKIP': 'ÜBERSPRINGEN',
        'Skip': 'Überspringen',
        'Skip the Quiz': 'Quiz überspringen',
        'Close': 'Schließen',
        'Yes': 'Ja',
        'No': 'Nein',
        'OK': 'OK',
        'Error': 'Fehler',
        'Success': 'Erfolg',
        'Warning': 'Warnung',
        'Info': 'Info',
        'Loading': 'Lädt',
        'Please wait': 'Bitte warten',
        
        # Goal Selection
        'I want to stop my hair loss': 'Ich will meinen Haarausfall stoppen',
        'I want better hair': 'Ich will bessere Haare',
        'I want BOTH': 'Ich will BEIDES',
        'Start by selecting your goal:': 'Beginne mit der Auswahl deines Ziels:',
        
        # Hair Type
        'Which hair type do you have?': 'Welchen Haartyp hast du?',
        'Straight': 'Glatt',
        'Wavy': 'Wellig',
        'Curly': 'Lockig',
        'Coily': 'Kraus',
        
        # Age
        'How old are you?': 'Wie alt bist du?',
        'Under 25': 'Unter 25',
        '25-35': '25-35',
        '36-45': '36-45',
        '46-55': '46-55',
        'Over 55': 'Über 55',
        
        # Hair Concern
        'What is your biggest hair concern?': 'Was ist dein größtes Haarproblem?',
        'Select one': 'Wähle eine Option',
        'Hair loss / thinning': 'Haarausfall / dünner werdendes Haar',
        'Split ends / dryness': 'Spliss / Trockenheit',
        'Scalp issues': 'Kopfhautprobleme',
        'Damaged hair': 'Geschädigtes Haar',
        
        # Current Routine
        'What best describes your current hair care routine?': 'Was beschreibt deine aktuelle Haarpflege-Routine am besten?',
        'Just shampoo & conditioner': 'Nur Shampoo & Conditioner',
        'I add masks & treatments': 'Ich verwende Masken & Behandlungen',
        'I use natural/organic products': 'Ich verwende natürliche/Bio-Produkte',
        'Full routine with many products': 'Vollständige Routine mit vielen Produkten',
        
        # Knowledge Questions
        "Do you already know exactly": "Weißt du bereits genau",
        "what's triggering your hair fall or thinning?": "was deinen Haarausfall oder dünner werdendes Haar auslöst?",
        "how you can tame your frizz and dryness?": "wie du Frizz und Trockenheit in den Griff bekommst?",
        "what's behind your scalp irritation or dandruff issues?": "was hinter deinen Kopfhautreizungen oder Schuppenproblemen steckt?",
        "how you can save your hair from further damage?": "wie du deine Haare vor weiteren Schäden schützen kannst?",
        "what's causing your hair issues?": "was deine Haarprobleme verursacht?",
        
        # Knowledge State Answers
        "🙌 Yes, but I need more support": "🙌 Ja, aber ich brauche mehr Unterstützung",
        "😢 No and I'm tired of searching": "😢 Nein und ich bin es leid zu suchen",
        "😥 Not sure, it's complicated by myself": "😥 Nicht sicher, es ist kompliziert für mich allein",
        
        # Pitch Messages
        "Don't worry! We got you.": "Keine Sorge! Wir helfen dir.",
        "Beautiful hair needs more than just products": "Schönes Haar braucht mehr als nur Produkte",
        "Our evidence-based programs are designed to heal your hair from within": "Unsere evidenzbasierten Programme sind darauf ausgelegt, dein Haar von innen zu heilen",
        "Clinically proven to heal your hair from root to tip": "Klinisch erwiesen, um dein Haar von der Wurzel bis zur Spitze zu heilen",
        "Proven Results for:": "Bewährte Ergebnisse für:",
        "Any hair concern": "Jedes Haarproblem",
        "Any age": "Jedes Alter",
        "Any hair type": "Jeden Haartyp",
        "Any hair goal": "Jedes Haarziel",
        
        # Hairqare Knowledge
        "How familiar are you with Hairqare method?": "Wie vertraut bist du mit der Hairqare-Methode?",
        "I'm hearing about it for the first time": "Ich höre zum ersten Mal davon",
        "I've heard of it before": "Ich habe schon davon gehört",
        "I know it well": "Ich kenne es gut",
        
        # Diet
        "What best describes your diet?": "Was beschreibt deine Ernährung am besten?",
        "What we eat affects our hair growth and quality": "Was wir essen beeinflusst unser Haarwachstum und die Haarqualität",
        "Balanced": "Ausgewogen",
        "Vegetarian": "Vegetarisch",
        "Vegan": "Vegan",
        "Keto/Low-carb": "Keto/Low-Carb",
        "No specific diet": "Keine spezielle Diät",
        
        # Spending
        "How much do you spend on a bottle of shampoo?": "Wie viel gibst du für eine Flasche Shampoo aus?",
        "Less than €10": "Weniger als 10€",
        "€10 - €20": "10€ - 20€",
        "€20 - €50": "20€ - 50€",
        "More than €50": "Mehr als 50€",
        
        # Myths
        "Which of these hair care myths do you believe?": "An welche dieser Haarpflege-Mythen glaubst du?",
        
        # Damage Activities
        "Select the damaging practices you do regularly": "Wähle die schädlichen Praktiken, die du regelmäßig machst",
        
        # Confidence Questions
        "My reflection affects my mood and self-worth": "Mein Spiegelbild beeinflusst meine Stimmung und mein Selbstwertgefühl",
        "I tend to compare my hair to others' and it makes me frustrated": "Ich neige dazu, meine Haare mit anderen zu vergleichen und das frustriert mich",
        "How much do you agree with the following statement?": "Wie sehr stimmst du der folgenden Aussage zu?",
        
        # Professional Referral
        "Did a professional refer you to us?": "Hat dich ein Profi an uns verwiesen?",
        
        # Loading Screen
        "Creating your personalized hair care program": "Erstelle dein personalisiertes Haarpflege-Programm",
        
        # Login Component
        "Your results are ready!": "Deine Ergebnisse sind fertig!",
        "On the next screen, you'll see...": "Auf dem nächsten Bildschirm siehst du...",
        "Probability to achieve your hair goal": "Wahrscheinlichkeit, dein Haarziel zu erreichen",
        "Probability to fix your": "Wahrscheinlichkeit, dein",
        "Probability to reduce your hair problems in 14 days": "Wahrscheinlichkeit, deine Haarprobleme in 14 Tagen zu reduzieren",
        "Enter your details to unlock": "Gib deine Daten ein, um freizuschalten",
        "Name": "Name",
        "Email": "E-Mail",
        "Absenden": "Absenden",
        "Your info is 100% secure and never shared": "Deine Daten sind 100% sicher und werden niemals geteilt",
        
        # Dashboard
        "Join the 14-Day Haircare Challenge": "Nimm an der 14-Tage Haarpflege-Challenge teil",
        "START MY CHALLENGE": "MEINE CHALLENGE STARTEN",
        "RESERVE MY SEAT": "MEINEN PLATZ RESERVIEREN",
        "That's an outstanding score!": "Das ist ein hervorragender Wert!",
        "You deserve this,": "Du hast das verdient,",
        "out of 10 women with this score said": "von 10 Frauen mit diesem Wert sagten",
        "their shedding stopped": "ihr Haarausfall stoppte",
        "they started seeing new baby hairs": "sie begannen neue Babyhaare zu sehen",
        "after the challenge": "nach der Challenge",
        "My Goal:": "Mein Ziel:",
        "Stronger, more resilient hair that I can style daily without guilt or worry about damage": "Stärkeres, widerstandsfähigeres Haar, das ich täglich stylen kann, ohne Schuldgefühle oder Sorgen vor Schäden",
        "Only": "Nur noch",
        "seats remaining. Hurry Up!": "Plätze verfügbar. Beeil dich!",
        "and say goodbye to your": "und verabschiede dich dauerhaft von deinem",
        "permanently with a routine that works": "mit einer Routine, die funktioniert",
        "No more frustration or disappointments!": "Keine Frustration oder Enttäuschungen mehr!",
        
        # Conditional Phrases
        "with the right routine": "mit der richtigen Routine",
        "tailored to your unique needs": "auf deine einzigartigen Bedürfnisse zugeschnitten",
        "without spending more": "ohne mehr auszugeben",
        "despite all the treatments, specialists and products you've tried, you're missing important haircare knowledge": "trotz aller Behandlungen, Spezialisten und Produkte, die du ausprobiert hast, fehlt dir wichtiges Haarpflege-Wissen",
        "while only relying on using shampoo & conditioner, you're missing important haircare knowledge": "während du dich nur auf Shampoo & Conditioner verlässt, fehlt dir wichtiges Haarpflege-Wissen",
        "despite making time for hair masks and other treatments, you're missing important haircare knowledge": "trotz der Zeit, die du für Haarmasken und andere Behandlungen aufwendest, fehlt dir wichtiges Haarpflege-Wissen",
        "despite using organic products and home remedies, you're missing important haircare knowledge": "trotz der Verwendung von Bio-Produkten und Hausmitteln fehlt dir wichtiges Haarpflege-Wissen",
        "despite what you've already tried, you're missing important haircare knowledge": "trotz allem, was du bereits ausprobiert hast, fehlt dir wichtiges Haarpflege-Wissen",
        "That's why nothing has worked so far": "Deshalb hat bisher nichts funktioniert",
        
        # Hair Terms
        "hair loss": "Haarausfall",
        "split ends": "Spliss",
        "damaged hair": "geschädigtes Haar",
        "hair problems": "Haarprobleme",
        "scalp issues": "Kopfhautprobleme",
        "hair fall": "Haarausfall",
        "thinning": "dünner werdendes Haar",
        "breakage": "Haarbruch",
        "In my 30s": "In meinen 30ern",
        "In my 40s": "In meinen 40ern",
        "In my 50s": "In meinen 50ern",
        
        # Hair Type - MISSING TRANSLATION
        "I don't know": "Weiß ich nicht",
        
        # Current Routine - ALL MISSING DESCRIPTIONS
        "Basic routine for busy people": "Grundroutine für beschäftigte Menschen",
        "Just the essentials, nothing fancy": "Nur das Wesentliche, nichts Ausgefallenes",
        "Salon visits, premium products, specialists, supplements": "Salonbesuche, Premium-Produkte, Spezialisten, Nahrungsergänzungsmittel",
        "Complex routine with professional guidance": "Komplexe Routine mit professioneller Anleitung",
        "Basic care and occasional hair masks": "Grundpflege und gelegentliche Haarmasken",
        "A little extra love when you have time": "Ein bisschen zusätzliche Liebe, wenn du Zeit hast",
        "Mostly oils, herbs or DIY treatments": "Hauptsächlich Öle, Kräuter oder DIY-Behandlungen",
        "Pure ingredients, made at home": "Reine Zutaten, selbst gemacht",
        "I follow a different haircare routine": "Ich folge einer anderen Haarpflegeroutine",
        "Tell us more in the next step": "Erzähl uns mehr im nächsten Schritt",
        
        # Shampoo Spending - ALL MISSING DESCRIPTIONS AND TITLES
        "Awesome 🤩 you're budget conscious!": "Super 🤩 du achtest auf dein Budget!",
        "You can actually have amazing results without spending more than you do now (or even less) while avoiding harmful products that secretly ruin your hair. You just need the right routine for your unique situation.": "Du kannst tatsächlich tolle Ergebnisse erzielen, ohne mehr auszugeben als jetzt (oder sogar weniger), während du schädliche Produkte vermeidest, die heimlich deine Haare ruinieren. Du brauchst nur die richtige Routine für deine einzigartige Situation.",
        "Amazing 🙌 you value your hair!": "Großartig 🙌 du schätzt deine Haare!",
        "You're spending thoughtfully, but likely still paying for marketing rather than results. With the right routine, you could get truly transformative results tailored to your unique needs without spending more.": "Du gibst bewusst Geld aus, zahlst aber wahrscheinlich immer noch für Marketing statt für Ergebnisse. Mit der richtigen Routine könntest du wirklich transformative Ergebnisse erzielen, die auf deine einzigartigen Bedürfnisse zugeschnitten sind, ohne mehr auszugeben.",
        "You clearly care about your hair 💜": "Dir sind deine Haare eindeutig wichtig 💜",
        "Did you know, in premium haircare up to 90% of what you're paying goes to packaging and marketing, not quality ingredients? With the right routine, you can actually get the premium results you're looking for without the price tag.": "Wusstest du, dass bei Premium-Haarpflege bis zu 90% deines Geldes für Verpackung und Marketing draufgeht, nicht für hochwertige Inhaltsstoffe? Mit der richtigen Routine kannst du tatsächlich die Premium-Ergebnisse bekommen, die du suchst, ohne den hohen Preis.",
        "Your hair deserves the best ✨": "Deine Haare verdienen das Beste ✨",
        "Did you know premium haircare often uses the same ingredients as budget options? With the right personalized routine, you can actually achieve the results those luxury brands are just promising.": "Wusstest du, dass Premium-Haarpflege oft dieselben Inhaltsstoffe verwendet wie günstige Optionen? Mit der richtigen personalisierten Routine kannst du tatsächlich die Ergebnisse erzielen, die diese Luxusmarken nur versprechen.",
        
        # Hair Myths - ALL MISSING ANSWERS
        "Rosemary oil reduces hair loss": "Rosmarinöl reduziert Haarausfall",
        "Coconut oil is the best hair oil": "Kokosöl ist das beste Haaröl",
        "Rice water makes hair grow faster": "Reiswasser lässt die Haare schneller wachsen",
        "Natural / organic products are better": "Natürliche/Bio-Produkte sind besser",
        "Not washing hair is good for the scalp": "Die Haare nicht zu waschen ist gut für die Kopfhaut",
        
        # Hair Damage Activity - ALL MISSING ANSWERS
        "Heat styling (blow dry, straighten, curl)": "Hitze-Styling (Föhnen, Glätten, Locken)",
        "Chemical treatments (dye, bleach, perm)": "Chemische Behandlungen (Färben, Bleichen, Dauerwelle)",
        "Tight hairstyles or extensions": "Straffe Frisuren oder Extensions",
        "Swimming in chlorinated pools": "Schwimmen in gechlorten Pools",
        "Sun exposure without protection": "Sonneneinstrahlung ohne Schutz",
        "None of the above": "Nichts davon",
        
        # Professional Referral - MISSING ANSWER
        "I'm a professional": "Ich bin ein Profi",
        
        # Pitch Screen Conditional Strings
        "Did you know research shows that": "Wusstest du, dass Untersuchungen zeigen, dass",
        "With the right routine it's fine to style your hair any way you like and do the activities you enjoy.": "Mit der richtigen Routine ist es in Ordnung, deine Haare zu stylen, wie du möchtest, und die Aktivitäten zu machen, die dir Spaß machen.",
        "But if you are still struggling with damaged hair and breakage while only relying on using shampoo & conditioner, you're missing important haircare knowledge.": "Aber wenn du immer noch mit geschädigtem Haar und Haarbruch kämpfst, während du dich nur auf Shampoo und Conditioner verlässt, fehlt dir wichtiges Haarpflege-Wissen.",
        "That's why nothing has worked so far.": "Deshalb hat bisher nichts funktioniert.",
        
        # Login Screen - PARTIAL TRANSLATIONS
        "Probability to fix your geschädigtes Haar in 14 days:": "Wahrscheinlichkeit, dein geschädigtes Haar in 14 Tagen zu reparieren:",
        "geschädigtes Haar": "geschädigtes Haar",
        
        # Dashboard - MIXED LANGUAGE STRINGS
        "That's an outstanding score!": "Das ist ein hervorragender Wert!",
        "You deserve this,": "Du hast das verdient,",
        "out of 10 women with this score said": "von 10 Frauen mit diesem Wert sagten",
        "their shedding stopped": "ihr Haarausfall stoppte",
        "they started seeing new baby hairs": "sie begannen neue Babyhaare zu sehen",
        "after the challenge": "nach der Challenge",
        "My Goal:": "Mein Ziel:",
        "Stronger, more resilient hair that I can style daily without guilt or worry about damage": "Stärkeres, widerstandsfähigeres Haar, das ich täglich stylen kann, ohne Schuldgefühle oder Sorgen vor Schäden",
        "Only": "Nur noch",
        "seats remaining. Hurry Up!": "Plätze verfügbar. Beeil dich!",
        "and say goodbye to your": "und verabschiede dich dauerhaft von deinem",
        "permanently with a routine that works": "mit einer Routine, die funktioniert",
        "No more frustration or disappointments!": "Keine Frustration oder Enttäuschungen mehr!",
        
        # Spending Descriptions
        "You're spending thoughtfully, but likely still paying for marketing rather than results": "Du gibst dein Geld bewusst aus, zahlst aber wahrscheinlich immer noch für Marketing statt für Ergebnisse",
        "With the right routine, you could get truly transformative results tailored to your unique needs without spending more": "Mit der richtigen Routine könntest du wirklich transformative Ergebnisse erhalten, die auf deine einzigartigen Bedürfnisse zugeschnitten sind, ohne mehr auszugeben",
        "Awesome & you're budget conscious!": "Großartig & du bist kostenbewusst!",
        "You can actually get great results without spending more than now (or even less), while avoiding harmful products that secretly ruin your hair": "Du kannst tatsächlich tolle Ergebnisse erzielen, ohne mehr auszugeben als jetzt (oder sogar weniger), während du schädliche Produkte vermeidest, die heimlich deine Haare ruinieren",
    }
}

def translate_file(file_path, target_lang='de'):
    """Translate a single file to the target language."""
    if target_lang not in TRANSLATIONS:
        print(f"Warning: No translations available for language '{target_lang}'")
        return False
    
    translations = TRANSLATIONS[target_lang]
    
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        
        # Apply translations
        for english, german in translations.items():
            # Handle various quote styles
            patterns = [
                (f"'{english}'", f"'{german}'"),
                (f'"{english}"', f'"{german}"'),
                (f"'{english}'", f"'{german}'"),
                (f'"{english}"', f'"{german}"'),
            ]
            
            for pattern, replacement in patterns:
                content = content.replace(pattern, replacement)
        
        if content != original_content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
            return True
        return False
        
    except Exception as e:
        print(f"Error processing {file_path}: {e}")
        return False

def main():
    if len(sys.argv) < 2:
        print("Usage: python comprehensive_translation_system.py <directory> [language]")
        sys.exit(1)
    
    directory = Path(sys.argv[1])
    target_lang = sys.argv[2] if len(sys.argv) > 2 else 'de'
    
    if not directory.exists():
        print(f"Error: Directory '{directory}' does not exist")
        sys.exit(1)
    
    # Find all Dart files
    dart_files = list(directory.rglob('*.dart'))
    
    print(f"Translating {len(dart_files)} files to {target_lang}...")
    
    translated_count = 0
    for dart_file in dart_files:
        if translate_file(dart_file, target_lang):
            print(f"✅ Translated: {dart_file}")
            translated_count += 1
    
    print(f"\nTranslation complete! {translated_count} files were updated.")

if __name__ == "__main__":
    main()
