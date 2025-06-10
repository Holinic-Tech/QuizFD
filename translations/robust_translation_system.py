#!/usr/bin/env python3
"""
Robust Translation System
A comprehensive translation system that handles all edge cases including:
- Escaped JSON strings with backslashes
- Dollar signs in prices
- Emoji handling
- Complex nested structures
- Debug mode for troubleshooting
"""

import re
import json
import sys
import argparse
from typing import Dict, List, Tuple

# Comprehensive translation mappings with ALL missing strings
TRANSLATIONS = {
    'de': {
        # Loading screen messages
        'Checking your hair condition': 'Checke deinen Haarzustand',
        'Analysing your routine': 'Analysiere deine Routine',
        'Checking your challenge-fit': 'Prüfe, ob die Challenge zu dir passt',
        
        # Loading widget messages
        '🚫 No more hidden harmful ingredients.': '🚫 Schluss mit versteckten schädlichen Inhaltsstoffen.',
        '🌱 Reduced hair loss and new baby hair growth.': '🌱 Weniger Haarausfall und neue Babyhaare.',
        '✅ Split ends that don\'t come back.': '✅ Spliss, der nicht wiederkommt.',
        '💛 The best of science, made easy at home.': '💛 Das Beste aus der Wissenschaft, einfach für zu Hause.',
        
        # Hair types
        'Straight': 'Glatt',
        'Wavy': 'Wellig',
        'Curly': 'Lockig',
        'Coily': 'Kraus',
        'I don\'t know': 'Weiß ich nicht',
        
        # Hair concerns
        'Hair loss or hair thinning': 'Haarausfall oder dünner werdendes Haar',
        'Damage from dye, heat, or chemical treatments': 'Schäden durch Färben, Hitze oder chemische Behandlungen',
        'Scalp irritation or dandruff': 'Kopfhautreizungen oder Schuppen',
        'Split ends, frizz, and dryness': 'Spliss, Frizz und Trockenheit',
        'Other, mixed issues': 'Andere, gemischte Probleme',
        
        # Hair goals
        'I want to stop my hair loss': 'Ich will meinen Haarausfall stoppen',
        'I want longer, better looking hair': 'Ich will längeres, schöneres Haar',
        'I want both': 'Ich will beides',
        
        # Age ranges
        '18-24': '18-24',
        '25-34': '25-34',
        '35-44': '35-44',
        '45+': '45+',
        'Under 18': 'Unter 18',
        
        # Current routine
        'Basic Routine': 'Basic Routine',
        'I use shampoo and conditioner only': 'Ich benutze nur Shampoo und Conditioner',
        'Intermediate Routine': 'Mittlere Routine',
        'I sometimes use masks, serums, or treatments': 'Ich benutze manchmal Masken, Seren oder Treatments',
        'Complex Routine': 'Komplexe Routine',
        'I regularly use masks, oils, and specialized products': 'Ich benutze regelmäßig Masken, Öle und Spezialprodukte',
        'Natural/Organic Routine': 'Natürliche/Bio-Routine',
        'I prefer organic or DIY hair treatments': 'Ich bevorzuge Bio- oder DIY-Haarbehandlungen',
        
        # Diet options
        'No specific diet': 'Keine spezielle Ernährung',
        'I don\'t have any dietary restrictions': 'Ich habe keine Ernährungseinschränkungen',
        'Vegetarian': 'Vegetarisch',
        'I abstain from meat, fish, and poultry products': 'Ich verzichte auf Fleisch, Fisch und Geflügel',
        'Gluten-free': 'Glutenfrei',
        'I avoid wheat, barley, rye or other grains': 'Ich meide Weizen, Gerste, Roggen oder andere Getreide',
        'Vegan': 'Vegan',
        'I avoid all animal-based products: meat, eggs, dairy, etc. Plant-based foods only': 'Ich meide alle tierischen Produkte: Fleisch, Eier, Milchprodukte usw. Nur pflanzliche Lebensmittel',
        
        # Knowledge state - INCLUDING ALL MISSING STRINGS
        'Yes': 'Ja',
        'Not yet': 'Noch nicht',
        '🙌 Yes, but I need more support': '🙌 Ja, aber ich brauche mehr Unterstützung',
        '😢 No and I\'m tired of searching': '😢 Nein und ich bin es leid zu suchen',
        '😥 Not sure, it\'s complicated by myself': '😥 Nicht sicher, alleine ist es kompliziert',
        
        # Hairqare knowledge - INCLUDING MISSING STRINGS
        'Never heard of it': 'Noch nie davon gehört',
        'Heard about it, but not sure what it is': 'Schon mal gehört, aber weiß nicht genau was es ist',
        'Know what it is, but haven\'t tried it': 'Weiß was es ist, hab\'s aber noch nicht probiert',
        'Tried it and loved it!': 'Hab\'s probiert und liebe es!',
        'I\'m hearing about it for the first time': 'Höre zum ersten Mal davon',
        'I\u2019m hearing about it for the first time': 'Höre zum ersten Mal davon',  # Unicode apostrophe variant
        'I know a few things': 'Ich weiß ein paar Dinge',
        'Yes, I know everything about it': 'Ja, ich weiß alles darüber',
        
        # Mindset questions - INCLUDING ALL MISSING STRINGS
        'Yes, definitely': 'Ja, definitiv',
        'Yes, totally': 'Ja, total',
        'Maybe, I\'m not sure': 'Vielleicht, ich bin mir nicht sicher',
        'I\'ve never considered that': 'Das habe ich noch nie in Betracht gezogen',
        'No, I just need the right product': 'Nein, ich brauche nur das richtige Produkt',
        'You\'re absolutely right!': 'Du hast absolut recht!',
        'You\'re on the right track!': 'Du bist auf dem richtigen Weg!',
        'You\'ll be surprised!': 'Du wirst überrascht sein!',
        'It\'s a common misconception': 'Das ist ein häufiges Missverständnis',
        'Diet, stress, environment, and internal health all impact your hair. Our holistic approach addresses ALL these factors for truly transformative results.': 'Ernährung, Stress, Umwelt und innere Gesundheit - alles beeinflusst deine Haare. Unser ganzheitlicher Ansatz kümmert sich um ALLE diese Faktoren für wirklich transformative Ergebnisse.',
        'Not really': 'Nicht wirklich',
        'Think about this...': 'Denk mal drüber nach...',
        'Your skin and nails are affected by what you eat and how you feel, right? Your hair is no different! Our holistic approach tackles root causes for lasting results.': 'Deine Haut und Nägel werden von dem beeinflusst, was du isst und wie du dich fühlst, oder? Deinen Haaren geht\'s genauso! Unser ganzheitlicher Ansatz packt die Ursachen an für dauerhafte Ergebnisse.',
        'Most women focus only on external treatments, missing 50% of what determines hair health. Our approach changes that by addressing both internal and external factors for complete hair transformation.': 'Die meisten Frauen konzentrieren sich nur auf äußere Behandlungen und verpassen 50% dessen, was die Haargesundheit bestimmt. Unser Ansatz ändert das, indem wir sowohl innere als auch äußere Faktoren für eine komplette Haartransformation angehen.',
        
        # Professional referral - INCLUDING MISSING STRING
        'Yes, by a dermatologist': 'Ja, von einem Hautarzt',
        'Yes, by a hair stylist': 'Ja, von meinem Friseur',
        'Yes, by a friend or family': 'Ja, von Freunden oder Familie',
        'No, I found you myself': 'Nein, ich hab euch selbst gefunden',
        'I\'m a professional': 'Ich bin ein Profi',
        
        # Shampoo spending - INCLUDING ALL PRICE STRINGS WITH DOLLAR SIGNS
        'Less than $10': 'Weniger als 10€',
        '$10 - $20': '10€ - 20€',
        '$20 - $50': '20€ - 50€',
        'More than $50': 'Mehr als 50€',
        'Under $10': 'Unter 10€',
        '$10-20': '10-20€',
        '$20-40': '20-40€',
        'Over $40': 'Über 40€',
        'Awesome 🤩 you\'re budget conscious!': 'Super 🤩 du achtest auf dein Budget!',
        'You can actually have amazing results without spending more than you do now (or even less) while avoiding harmful products that secretly ruin your hair. You just need the right routine for your unique situation.': 'Du kannst tatsächlich tolle Ergebnisse erzielen, ohne mehr auszugeben als jetzt (oder sogar weniger), während du schädliche Produkte vermeidest, die heimlich deine Haare ruinieren. Du brauchst nur die richtige Routine für deine einzigartige Situation.',
        'Amazing 🙌 you value your hair!': 'Großartig 🙌 du schätzt deine Haare!',
        'You\'re spending thoughtfully, but likely still paying for marketing rather than results. With the right routine, you could get truly transformative results tailored to your unique needs without spending more.': 'Du gibst bewusst Geld aus, zahlst aber wahrscheinlich immer noch für Marketing statt für Ergebnisse. Mit der richtigen Routine könntest du wirklich transformative Ergebnisse erzielen, die auf deine einzigartigen Bedürfnisse zugeschnitten sind, ohne mehr auszugeben.',
        'You clearly care about your hair 💜': 'Dir sind deine Haare eindeutig wichtig 💜',
        'Did you know, in premium haircare up to 90% of what you\'re paying goes to packaging and marketing, not quality ingredients? With the right routine, you can actually get the premium results you\'re looking for without the price tag.': 'Wusstest du, dass bei Premium-Haarpflege bis zu 90% deines Geldes für Verpackung und Marketing draufgeht, nicht für hochwertige Inhaltsstoffe? Mit der richtigen Routine kannst du tatsächlich die Premium-Ergebnisse bekommen, die du suchst, ohne den hohen Preis.',
        'Your hair deserves the best ✨': 'Deine Haare verdienen das Beste ✨',
        'Did you know premium haircare often uses the same ingredients as budget options? With the right personalized routine, you can actually achieve the results those luxury brands are just promising.': 'Wusstest du, dass Premium-Haarpflege oft dieselben Inhaltsstoffe verwendet wie günstige Optionen? Mit der richtigen personalisierten Routine kannst du tatsächlich die Ergebnisse erzielen, die diese Luxusmarken nur versprechen.',
        
        # Hair myths
        'Cutting hair makes it grow faster': 'Haare schneiden lässt sie schneller wachsen',
        'Daily washing is bad for hair': 'Tägliches Waschen schadet den Haaren',
        'Natural ingredients are always better': 'Natürliche Inhaltsstoffe sind immer besser',
        'Expensive products work better': 'Teure Produkte wirken besser',
        
        # Hair damage activities
        'Heat styling (blow dry, straighten, curl)': 'Hitze-Styling (Föhnen, Glätten, Locken)',
        'Chemical treatments (dye, bleach, perm)': 'Chemische Behandlungen (Färben, Bleichen, Dauerwelle)',
        'Tight hairstyles or extensions': 'Straffe Frisuren oder Extensions',
        'Swimming in chlorinated pools': 'Schwimmen in gechlorten Pools',
        'Sun exposure without protection': 'Sonne ohne Schutz',
        'Heat': 'Hitze',
        'Heat styling': 'Hitze-Styling',
        'Bleaching / hair colour': 'Bleichen / Haarfarbe',
        'Bleaching / hair colouring': 'Bleichen / Haarfarbe',
        'Sun exposure': 'Sonneneinstrahlung',
        'Frequent swimming': 'Häufiges Schwimmen',
        'Tight hair styles (braids, bun, ponytail...)': 'Straffe Frisuren (Zöpfe, Dutt, Pferdeschwanz...)',
        
        # Hair myths
        'Rosemary oil is a universal treatment': 'Rosmarinöl ist ein Universalmittel',
        'Rice water will make your hair grow faster': 'Reiswasser lässt deine Haare schneller wachsen',
        'Natural and organic products are better': 'Natürliche und biologische Produkte sind besser',
        'Hair can heal like the skin': 'Haare können wie die Haut heilen',
        
        # Spanish hair myths (to be replaced with German)
        'El aceite de romero reduce la caída': 'Rosmarinöl reduziert Haarausfall',
        'El aceite de coco es el mejor para el pelo': 'Kokosöl ist das beste für die Haare',
        'El agua de arroz hace crecer el pelo más rápido': 'Reiswasser lässt die Haare schneller wachsen',
        'Los productos naturales/orgánicos son mejores': 'Natürliche/biologische Produkte sind besser',
        'No lavar el pelo es bueno para el cuero cabelludo': 'Die Haare nicht zu waschen ist gut für die Kopfhaut',
        
        # Additional missing strings
        'None of the above': 'Nichts davon',
        'Other': 'Andere',
        'I abstain from meat, fish, and poultry\nproducts': 'Ich verzichte auf Fleisch, Fisch und Geflügelprodukte',
        'I abstain from meat, fish, and poultry\\nproducts': 'Ich verzichte auf Fleisch, Fisch und Geflügel\\nprodukte',
        'I avoid all animal-based products: meat,\neggs, dairy, etc. Plant-based foods only': 'Ich vermeide alle tierischen Produkte: Fleisch,\nEier, Milchprodukte usw. Nur pflanzliche Lebensmittel',
        'I avoid all animal-based products: meat,\\neggs, dairy, etc. Plant-based foods only': 'Ich vermeide alle tierischen Produkte: Fleisch,\\nEier, Milchprodukte usw. Nur pflanzliche Lebensmittel',
        
        # Common answers
        'Answer 1': 'Antwort 1',
        'Answer 2': 'Antwort 2',
        'Answer 3': 'Antwort 3',
        'Answer 4': 'Antwort 4',
        'Hello World': 'Hallo Welt',
        
        # Continue button
        'Continue': 'Weiter',
        'CONTINUE': 'WEITER',
        
        # Rich text conditional blocks
        'damaged hair and breakage': 'geschädigtes Haar und Haarbruch',
        'in their': 'in ihren',
        'experience less': 'erleben weniger',
        'breakage and more density': 'Haarbruch und mehr Dichte',
        'within 14 days': 'innerhalb von 14 Tagen',
        '91.2% of women who struggle with damaged hair and breakage in their thirties, experience less breakage and more density within 14 days after switching to a holistic hair care routine.': '91,2% der Frauen, die mit geschädigtem Haar und Haarbruch in ihren Dreißigern kämpfen, erleben weniger Haarbruch und mehr Dichte innerhalb von 14 Tagen nach der Umstellung auf eine ganzheitliche Haarpflegeroutine.',
        
        # Pitch screen conditional text
        'With the right routine it\'s fine to style your hair any way you like and do the activities you enjoy.': 'Mit der richtigen Routine ist es in Ordnung, deine Haare zu stylen, wie du möchtest, und die Aktivitäten zu machen, die dir Spaß machen.',
        'But if you are still struggling with damaged hair and breakage while only relying on using shampoo & conditioner, you\'re missing important haircare knowledge.': 'Aber wenn du immer noch mit geschädigtem Haar und Haarbruch kämpfst, während du dich nur auf Shampoo und Conditioner verlässt, fehlt dir wichtiges Haarpflege-Wissen.',
        'That\'s why nothing has worked so far.': 'Deshalb hat bisher nichts funktioniert.',
        
        # Log screen
        'Probability to fix your damaged hair in 14 days:': 'Wahrscheinlichkeit, dein geschädigtes Haar in 14 Tagen zu reparieren:',
        
        # Dashboard conditional strings
        'That\'s an outstanding score!': 'Das ist ein hervorragender Wert!',
        '9 out of 10 women with this score said their shedding stopped, and they started seeing new baby hairs after the challenge.': '9 von 10 Frauen mit diesem Wert sagten, dass ihr Haarausfall aufhörte und sie nach der Challenge neue Babyhaare sahen.',
        
        # Personal goals
        'My goal:': 'Mein Ziel:',
        'Stronger, more resilient hair that I can style daily without guilt or worry about damage.': 'Stärkeres, widerstandsfähigeres Haar, das ich täglich stylen kann, ohne Schuldgefühle oder Sorgen vor Schäden.',
        'In my 30s': 'In meinen 30ern',
        
        # Motivational text
        'You deserve this': 'Du hast das verdient',
        'You deserve this,': 'Du hast das verdient,',
        
        # CTA text
        'Join the 14-Day Haircare Challenge and say goodbye to your damaged hair permanently with a routine that works. No more frustration or disappointments!': 'Nimm an der 14-Tage Haarpflege-Challenge teil und verabschiede dich dauerhaft von deinem geschädigten Haar mit einer Routine, die funktioniert. Keine Frustration oder Enttäuschungen mehr!',
        
        # Urgency text
        'Only 6 seats remaining. Hurry Up!': 'Nur noch 6 Plätze verfügbar. Beeil dich!',
        'Only': 'Nur noch',
        'seats remaining': 'Plätze verfügbar',
        'Hurry Up!': 'Beeil dich!',
        
        # Additional missing text
        'No worries! We\'ve got you covered.': 'Keine Sorge! Wir kümmern uns um dich.',
        'Did you know that research shows': 'Wussten Sie, dass Untersuchungen zeigen',
        'of women': 'von Frauen',
        'who struggle with': 'die mit',
        
        # All the specific missing strings from translation branch
        'Do you already know exactly how you can save your hair from further damage?': 'Weißt du bereits genau, wie du deine Haare vor weiteren Schäden schützen kannst?',
        'I don\'t know': 'Weiß ich nicht',
        'I\'m hearing about it for the first time': 'Höre zum ersten Mal davon',
        'Split ends that don\'t come back.': 'Spliss, der nicht wiederkommt.',
        'No and I\'m tired of searching': '😢 Nein und ich bin es leid zu suchen',
        'Not sure, it\'s complicated by myself': '😥 Nicht sicher, alleine ist es kompliziert',
        'Maybe, I\'m not sure': 'Vielleicht, ich bin mir nicht sicher',
        'I\'ve never considered that': 'Das habe ich noch nie in Betracht gezogen',
        'You\'re absolutely right!': 'Du hast absolut recht!',
        'You\'re on the right track!': 'Du bist auf dem richtigen Weg!',
        'You\'ll be surprised!': 'Du wirst überrascht sein!',
        'It\'s a common misconception': 'Das ist ein häufiges Missverständnis',
        'I\'m a professional': 'Ich bin ein Profi',
        'Less than \$10': 'Weniger als 10€',
        'Awesome 🤩 you\'re budget conscious!': 'Super 🤩 du achtest auf dein Budget!',
        '\$10 - \$20': '10€ - 20€',
        'You\'re spending thoughtfully, but likely still paying for marketing rather than results. With the right routine, you could get truly transformative results tailored to your unique needs without spending more.': 'Du gibst bewusst Geld aus, zahlst aber wahrscheinlich immer noch für Marketing statt für Ergebnisse. Mit der richtigen Routine könntest du wirklich transformative Ergebnisse erzielen, die auf deine einzigartigen Bedürfnisse zugeschnitten sind, ohne mehr auszugeben.',
        '\$20 - \$50': '20€ - 50€',
        'Did you know, in premium haircare up to 90% of what you\'re paying goes to packaging and marketing, not quality ingredients? With the right routine, you can actually get the premium results you\'re looking for without the price tag.': 'Wusstest du, dass bei Premium-Haarpflege bis zu 90% deines Geldes für Verpackung und Marketing draufgeht, nicht für hochwertige Inhaltsstoffe? Mit der richtigen Routine kannst du tatsächlich die Premium-Ergebnisse bekommen, die du suchst, ohne den hohen Preis.',
        'More than \$50': 'Mehr als 50€',
        'I don\'t have any dietary restrictions': 'Ich habe keine Ernährungseinschränkungen',
        'I abstain from meat, fish, and poultry\\nproducts': 'Ich verzichte auf Fleisch, Fisch und Geflügel\\nprodukte',
        'I avoid all animal-based products: meat,\\neggs, dairy, etc. Plant-based foods only': 'Ich vermeide alle tierischen Produkte: Fleisch,\\nEier, Milchprodukte usw. Nur pflanzliche Lebensmittel',
        
        # Plans
        '14 Day Challenge': '14-Tage-Challenge',
        '14 Day Haircare Journal & Templates': '14-Tage Haarpflege-Tagebuch & Vorlagen',
        'DIY Luxury Shampoo Workshop': 'DIY Luxus-Shampoo Workshop',
        'Haircare Ingredients No-No List': 'Haarpflege No-Go Inhaltsstoffe Liste',
        'Total Hair Wellness Handbook': 'Komplettes Haar-Wellness Handbuch',
        'Silicones & Sulfates Smart Usage Manual': 'Silikone & Sulfate - Clevere Anwendung',
        '30 Day Hair Mindfulness Experience': '30-Tage Haar-Achtsamkeits-Erfahrung',
        'Exclusive Members-Only Community': 'Exklusive Mitglieder-Community',
        'Haircare Product Analyzer': 'Haarpflege-Produkt-Analyzer',
        'Certificate of Completion': 'Teilnahme-Zertifikat',
        
        # Diet options
        'Fast food / Processed food diet': 'Fast Food / Verarbeitete Lebensmittel',
        'Balanced / Whole foods': 'Ausgewogen / Vollwertkost',
        'Custom nutrition protocol': 'Individuelles Ernährungsprotokoll',
        'Vegan / vegetarian': 'Vegan / vegetarisch',
        'Something else': 'Etwas anderes',
        
        # Current routine
        '🤓 Advanced': '🤓 Fortgeschritten',
        'Salon visits, premium products, specialists, supplements': 'Salonbesuche, Premium-Produkte, Spezialisten, Nahrungsergänzungsmittel',
        '🫧 Basic care': '🫧 Grundpflege',
        'Mostly just shampoo and conditioner': 'Hauptsächlich nur Shampoo und Conditioner',
        '🤗 Occasional pampering': '🤗 Gelegentliche Verwöhnung',
        'Basic care and occasional hair masks': 'Grundpflege und gelegentliche Haarmasken',
        '🌿 Natural remedies': '🌿 Natürliche Heilmittel',
        'Mostly oils, herbs or DIY treatments': 'Hauptsächlich Öle, Kräuter oder DIY-Behandlungen',
        '😌 None of the above': '😌 Nichts davon',
        'I follow a different haircare routine': 'Ich folge einer anderen Haarpflege-Routine',
    },
    'es': {
        # Loading screen messages
        'Checking your hair condition': 'Revisando el estado de tu cabello',
        'Analysing your routine': 'Analizando tu rutina',
        'Checking your challenge-fit': 'Comprobando si el reto es para ti',
        
        # Loading widget messages
        '🚫 No more hidden harmful ingredients.': '🚫 Se acabaron los ingredientes dañinos ocultos.',
        '🌱 Reduced hair loss and new baby hair growth.': '🌱 Menos caída y nuevos pelitos baby.',
        '✅ Split ends that don\'t come back.': '✅ Puntas abiertas que no vuelven.',
        '💛 The best of science, made easy at home.': '💛 Lo mejor de la ciencia, fácil en casa.',
        
        # Hair types
        'Straight': 'Liso',
        'Wavy': 'Ondulado',
        'Curly': 'Rizado',
        'Coily': 'Afro',
        'I don\'t know': 'No lo sé',
        
        # Hair concerns
        'Hair loss or hair thinning': 'Caída o pelo más fino',
        'Damage from dye, heat, or chemical treatments': 'Daño por tintes, calor o tratamientos químicos',
        'Scalp irritation or dandruff': 'Irritación del cuero cabelludo o caspa',
        'Split ends, frizz, and dryness': 'Puntas abiertas, frizz y sequedad',
        'Other, mixed issues': 'Otros problemas variados',
        
        # Hair goals
        'I want to stop my hair loss': 'Quiero parar mi caída del pelo',
        'I want longer, better looking hair': 'Quiero pelo más largo y bonito',
        'I want both': 'Quiero las dos cosas',
        
        # Age ranges
        '18-24': '18-24',
        '25-34': '25-34',
        '35-44': '35-44',
        '45+': '45+',
        'Under 18': 'Menos de 18',
        '18 - 29': '18 - 29',
        '30 - 39': '30 - 39',
        '40 - 49': '40 - 49',
        '50 +': '50 +',
        
        # Current routine
        'Basic Routine': 'Rutina Básica',
        'I use shampoo and conditioner only': 'Solo uso champú y acondicionador',
        'Intermediate Routine': 'Rutina Intermedia',
        'I sometimes use masks, serums, or treatments': 'A veces uso mascarillas, sérums o tratamientos',
        'Complex Routine': 'Rutina Compleja',
        'I regularly use masks, oils, and specialized products': 'Uso regularmente mascarillas, aceites y productos especializados',
        'Natural/Organic Routine': 'Rutina Natural/Orgánica',
        'I prefer organic or DIY hair treatments': 'Prefiero tratamientos orgánicos o caseros',
        
        # Diet options
        'No specific diet': 'Sin dieta específica',
        'I don\'t have any dietary restrictions': 'No tengo restricciones alimentarias',
        'Vegetarian': 'Vegetariana',
        'I abstain from meat, fish, and poultry products': 'No como carne, pescado ni aves',
        'Gluten-free': 'Sin gluten',
        'I avoid wheat, barley, rye or other grains': 'Evito trigo, cebada, centeno y otros cereales',
        'Vegan': 'Vegana',
        'I avoid all animal-based products: meat, eggs, dairy, etc. Plant-based foods only': 'Evito todos los productos animales: carne, huevos, lácteos, etc. Solo alimentos vegetales',
        
        # Knowledge state - INCLUDING ALL MISSING STRINGS
        'Yes': 'Sí',
        'Not yet': 'Todavía no',
        '🙌 Yes, but I need more support': '🙌 Sí, pero necesito más apoyo',
        '😢 No and I\'m tired of searching': '😢 No y estoy cansada de buscar',
        '😥 Not sure, it\'s complicated by myself': '😥 No estoy segura, es complicado sola',
        
        # Hairqare knowledge - INCLUDING MISSING STRINGS
        'Never heard of it': 'Nunca lo he oído',
        'Heard about it, but not sure what it is': 'Lo he oído, pero no sé exactamente qué es',
        'Know what it is, but haven\'t tried it': 'Sé lo que es, pero no lo he probado',
        'Tried it and loved it!': '¡Lo probé y me encanta!',
        'I\'m hearing about it for the first time': 'Es la primera vez que lo escucho',
        'I\u2019m hearing about it for the first time': 'Es la primera vez que lo escucho',  # Unicode apostrophe variant
        'I know a few things': 'Sé algunas cosas',
        'Yes, I know everything about it': 'Sí, lo sé todo sobre ello',
        
        # Mindset questions - INCLUDING ALL MISSING STRINGS
        'Yes, definitely': 'Sí, totalmente',
        'Yes, totally': 'Sí, totalmente',
        'Maybe, I\'m not sure': 'Tal vez, no estoy segura',
        'I\'ve never considered that': 'Nunca lo había considerado',
        'No, I just need the right product': 'No, solo necesito el producto adecuado',
        'You\'re absolutely right!': '¡Tienes toda la razón!',
        'You\'re on the right track!': '¡Vas por buen camino!',
        'You\'ll be surprised!': '¡Te sorprenderás!',
        'It\'s a common misconception': 'Es un error común',
        'Diet, stress, environment, and internal health all impact your hair. Our holistic approach addresses ALL these factors for truly transformative results.': 'La dieta, el estrés, el ambiente y la salud interna afectan tu pelo. Nuestro enfoque holístico aborda TODOS estos factores para resultados realmente transformadores.',
        'Not really': 'No mucho',
        'Think about this...': 'Piensa en esto...',
        'Your skin and nails are affected by what you eat and how you feel, right? Your hair is no different! Our holistic approach tackles root causes for lasting results.': 'Tu piel y uñas se ven afectadas por lo que comes y cómo te sientes, ¿verdad? ¡Tu pelo no es diferente! Nuestro enfoque holístico ataca las causas raíz para resultados duraderos.',
        'Most women focus only on external treatments, missing 50% of what determines hair health. Our approach changes that by addressing both internal and external factors for complete hair transformation.': 'La mayoría de las mujeres se centran solo en tratamientos externos, perdiendo el 50% de lo que determina la salud del cabello. Nuestro enfoque cambia eso abordando factores internos y externos para una transformación completa del cabello.',
        
        # Professional referral - INCLUDING MISSING STRING
        'Yes': 'Sí',
        'No': 'No',
        'I\'m a professional': 'Soy profesional',
        'Yes, by a dermatologist': 'Sí, un dermatólogo',
        'Yes, by a hair stylist': 'Sí, mi peluquero/a',
        'Yes, by a friend or family': 'Sí, amigos o familia',
        'No, I found you myself': 'No, os encontré yo',
        
        # Shampoo spending - INCLUDING ALL PRICE STRINGS WITH DOLLAR SIGNS
        'Less than $10': 'Menos de 10€',
        '$10 - $20': '10€ - 20€',
        '$20 - $50': '20€ - 50€',
        'More than $50': 'Más de 50€',
        'Under $10': 'Menos de 10€',
        '$10-20': '10-20€',
        '$20-40': '20-40€',
        'Over $40': 'Más de 40€',
        'Awesome 🤩 you\'re budget conscious!': '¡Genial 🤩 eres consciente del presupuesto!',
        'You can actually have amazing results without spending more than you do now (or even less) while avoiding harmful products that secretly ruin your hair. You just need the right routine for your unique situation.': 'Puedes tener resultados increíbles sin gastar más de lo que gastas ahora (o incluso menos) evitando productos dañinos que arruinan tu pelo en secreto. Solo necesitas la rutina adecuada para tu situación única.',
        'Amazing 🙌 you value your hair!': '¡Increíble 🙌 valoras tu pelo!',
        'You\'re spending thoughtfully, but likely still paying for marketing rather than results. With the right routine, you could get truly transformative results tailored to your unique needs without spending more.': 'Gastas con cuidado, pero probablemente sigues pagando por marketing en lugar de resultados. Con la rutina adecuada, podrías obtener resultados verdaderamente transformadores adaptados a tus necesidades únicas sin gastar más.',
        'You clearly care about your hair 💜': 'Claramente te importa tu pelo 💜',
        'Did you know, in premium haircare up to 90% of what you\'re paying goes to packaging and marketing, not quality ingredients? With the right routine, you can actually get the premium results you\'re looking for without the price tag.': '¿Sabías que en productos premium hasta el 90% de lo que pagas va a empaque y marketing, no a ingredientes de calidad? Con la rutina adecuada, puedes obtener los resultados premium que buscas sin el precio elevado.',
        'Your hair deserves the best ✨': 'Tu pelo merece lo mejor ✨',
        'Did you know premium haircare often uses the same ingredients as budget options? With the right personalized routine, you can actually achieve the results those luxury brands are just promising.': '¿Sabías que los productos premium a menudo usan los mismos ingredientes que las opciones económicas? Con la rutina personalizada adecuada, puedes lograr los resultados que esas marcas de lujo solo prometen.',
        
        # Hair myths  
        'Rosemary oil is reduces hair loss': 'El aceite de romero reduce la caída',
        'Coconut oil is the best hair oil': 'El aceite de coco es el mejor para el pelo',
        'Rice water makes hair grow faster': 'El agua de arroz hace crecer el pelo más rápido',
        'Natural / organic products are better': 'Los productos naturales/orgánicos son mejores',
        'Not washing hair is good for the scalp': 'No lavar el pelo es bueno para el cuero cabelludo',
        'Cutting hair makes it grow faster': 'Cortar el pelo lo hace crecer más rápido',
        'Daily washing is bad for hair': 'Lavarlo a diario es malo para el pelo',
        'Natural ingredients are always better': 'Los ingredientes naturales siempre son mejores',
        'Expensive products work better': 'Los productos caros funcionan mejor',
        
        # Hair damage activities
        'Heat styling (blow dry, straighten, curl)': 'Calor (secador, plancha, rizador)',
        'Chemical treatments (dye, bleach, perm)': 'Tratamientos químicos (tinte, decoloración, permanente)',
        'Tight hairstyles or extensions': 'Peinados tirantes o extensiones',
        'Swimming in chlorinated pools': 'Nadar en piscinas con cloro',
        'Sun exposure without protection': 'Sol sin protección',
        'Heat': 'Calor',
        'Heat styling': 'Estilizado con calor',
        'Bleaching / hair colour': 'Decoloración / tinte',
        'Bleaching / hair colouring': 'Decoloración / tinte',
        'Sun exposure': 'Exposición al sol',
        'Frequent swimming': 'Nadar frecuentemente',
        'Tight hair styles (braids, bun, ponytail...)': 'Peinados tirantes (trenzas, moño, coleta...)',
        
        # Hair myths already in Spanish (ensure consistency)
        'Rosemary oil is a universal treatment': 'El aceite de romero es un tratamiento universal',
        'Rice water will make your hair grow faster': 'El agua de arroz hará crecer tu cabello más rápido',
        'Natural and organic products are better': 'Los productos naturales y orgánicos son mejores',
        'Hair can heal like the skin': 'El cabello puede sanar como la piel',
        
        # Additional missing strings
        'None of the above': 'Ninguna de las anteriores',
        'Other': 'Otra',
        'I abstain from meat, fish, and poultry\nproducts': 'Me abstengo de carne, pescado y aves',
        'I avoid all animal-based products: meat,\neggs, dairy, etc. Plant-based foods only': 'Evito todos los productos de origen animal: carne,\nhuevos, lácteos, etc. Solo alimentos vegetales',
        
        # Common answers
        'Answer 1': 'Respuesta 1',
        'Answer 2': 'Respuesta 2',
        'Answer 3': 'Respuesta 3',
        'Answer 4': 'Respuesta 4',
        'Hello World': 'Hola Mundo',
        
        # Plans
        '14 Day Challenge': 'Reto de 14 Días',
        '14 Day Haircare Journal & Templates': 'Diario de Cuidado Capilar de 14 Días y Plantillas',
        'DIY Luxury Shampoo Workshop': 'Taller de Champú de Lujo Casero',
        'Haircare Ingredients No-No List': 'Lista de Ingredientes Prohibidos',
        'Total Hair Wellness Handbook': 'Manual Completo de Bienestar Capilar',
        'Silicones & Sulfates Smart Usage Manual': 'Manual de Uso Inteligente de Siliconas y Sulfatos',
        '30 Day Hair Mindfulness Experience': 'Experiencia de Mindfulness Capilar de 30 Días',
        'Exclusive Members-Only Community': 'Comunidad Exclusiva para Miembros',
        'Haircare Product Analyzer': 'Analizador de Productos Capilares',
        'Certificate of Completion': 'Certificado de Finalización',
        
        # Diet options
        'Fast food / Processed food diet': 'Comida rápida / Alimentos procesados',
        'Balanced / Whole foods': 'Equilibrada / Alimentos integrales',
        'Custom nutrition protocol': 'Protocolo nutricional personalizado',
        'Vegan / vegetarian': 'Vegana / vegetariana',
        'Something else': 'Otra cosa',
        
        # Current routine
        '🤓 Advanced': '🤓 Avanzada',
        'Salon visits, premium products, specialists, supplements': 'Visitas al salón, productos premium, especialistas, suplementos',
        '🫧 Basic care': '🫧 Cuidado básico',
        'Mostly just shampoo and conditioner': 'Principalmente solo champú y acondicionador',
        '🤗 Occasional pampering': '🤗 Mimos ocasionales',
        'Basic care and occasional hair masks': 'Cuidado básico y mascarillas ocasionales',
        '🌿 Natural remedies': '🌿 Remedios naturales',
        'Mostly oils, herbs or DIY treatments': 'Principalmente aceites, hierbas o tratamientos caseros',
        '😌 None of the above': '😌 Ninguno de los anteriores',
        'I follow a different haircare routine': 'Sigo una rutina de cuidado del cabello diferente',
        
        # Continue button
        'Continue': 'Continuar',
        'CONTINUE': 'CONTINUAR',
        
        # Rich text conditional blocks
        'damaged hair and breakage': 'cabello dañado y rotura',
        'in their': 'en sus',
        'experience less': 'experimentan menos',
        'breakage and more density': 'rotura y más densidad',
        'within 14 days': 'en 14 días',
        '91.2% of women who struggle with damaged hair and breakage in their thirties, experience less breakage and more density within 14 days after switching to a holistic hair care routine.': 'El 91.2% de las mujeres que luchan con el cabello dañado y la rotura en sus treinta, experimentan menos rotura y más densidad en 14 días después de cambiar a una rutina de cuidado capilar holística.',
        
        # Pitch screen conditional text
        'With the right routine it\'s fine to style your hair any way you like and do the activities you enjoy.': 'Con la rutina adecuada está bien peinar tu cabello como quieras y hacer las actividades que disfrutas.',
        'But if you are still struggling with damaged hair and breakage while only relying on using shampoo & conditioner, you\'re missing important haircare knowledge.': 'Pero si todavía luchas con el cabello dañado y la rotura mientras solo confías en usar champú y acondicionador, te falta conocimiento importante sobre el cuidado del cabello.',
        'That\'s why nothing has worked so far.': 'Por eso nada ha funcionado hasta ahora.',
        
        # Log screen
        'Probability to fix your damaged hair in 14 days:': 'Probabilidad de reparar tu cabello dañado en 14 días:',
        
        # Dashboard conditional strings
        'That\'s an outstanding score!': '¡Es una puntuación excelente!',
        '9 out of 10 women with this score said their shedding stopped, and they started seeing new baby hairs after the challenge.': '9 de cada 10 mujeres con esta puntuación dijeron que su caída se detuvo y comenzaron a ver nuevos cabellos baby después del reto.',
        
        # Personal goals
        'My goal:': 'Mi objetivo:',
        'Stronger, more resilient hair that I can style daily without guilt or worry about damage.': 'Cabello más fuerte y resistente que pueda peinar diariamente sin culpa o preocupación por el daño.',
        'In my 30s': 'En mis 30',
        
        # Motivational text
        'You deserve this': 'Te lo mereces',
        'You deserve this,': 'Te lo mereces,',
        
        # CTA text
        'Join the 14-Day Haircare Challenge and say goodbye to your damaged hair permanently with a routine that works. No more frustration or disappointments!': '¡Únete al Reto de Cuidado Capilar de 14 Días y despídete permanentemente de tu cabello dañado con una rutina que funciona. ¡No más frustración o decepciones!',
        
        # Urgency text
        'Only 6 seats remaining. Hurry Up!': '¡Solo quedan 6 lugares. Date prisa!',
        'Only': 'Solo quedan',
        'seats remaining': 'lugares disponibles',
        'Hurry Up!': '¡Date prisa!',
        
        # Additional missing text
        'No worries! We\'ve got you covered.': '¡No te preocupes! Te tenemos cubierta.',
        'Did you know that research shows': '¿Sabías que las investigaciones muestran',
        'of women': 'de mujeres',
        'who struggle with': 'que luchan con',
        
        # All the specific missing strings from translation branch
        'Do you already know exactly how you can save your hair from further damage?': '¿Ya sabes exactamente cómo puedes salvar tu cabello de más daño?',
        'I don\'t know': 'No lo sé',
        'I\'m hearing about it for the first time': 'Es la primera vez que lo escucho',
        'Split ends that don\'t come back.': 'Puntas abiertas que no vuelven.',
        'No and I\'m tired of searching': '😢 No y estoy cansada de buscar',
        'Not sure, it\'s complicated by myself': '😥 No estoy segura, es complicado sola',
        'Maybe, I\'m not sure': 'Tal vez, no estoy segura',
        'I\'ve never considered that': 'Nunca lo había considerado',
        'You\'re absolutely right!': '¡Tienes toda la razón!',
        'You\'re on the right track!': '¡Vas por buen camino!',
        'You\'ll be surprised!': '¡Te sorprenderás!',
        'It\'s a common misconception': 'Es un error común',
        'I\'m a professional': 'Soy profesional',
        'Less than \$10': 'Menos de 10€',
        'Awesome 🤩 you\'re budget conscious!': '¡Genial 🤩 eres consciente del presupuesto!',
        '\$10 - \$20': '10€ - 20€',
        'You\'re spending thoughtfully, but likely still paying for marketing rather than results. With the right routine, you could get truly transformative results tailored to your unique needs without spending more.': 'Gastas con cuidado, pero probablemente sigues pagando por marketing en lugar de resultados. Con la rutina adecuada, podrías obtener resultados verdaderamente transformadores adaptados a tus necesidades únicas sin gastar más.',
        '\$20 - \$50': '20€ - 50€',
        'Did you know, in premium haircare up to 90% of what you\'re paying goes to packaging and marketing, not quality ingredients? With the right routine, you can actually get the premium results you\'re looking for without the price tag.': '¿Sabías que en productos premium hasta el 90% de lo que pagas va a empaque y marketing, no a ingredientes de calidad? Con la rutina adecuada, puedes obtener los resultados premium que buscas sin el precio elevado.',
        'More than \$50': 'Más de 50€',
        'I don\'t have any dietary restrictions': 'No tengo restricciones alimentarias',
        'I abstain from meat, fish, and poultry\\nproducts': 'Me abstengo de carne, pescado y aves',
        'I avoid all animal-based products: meat,\\neggs, dairy, etc. Plant-based foods only': 'Evito todos los productos de origen animal: carne,\\nhuevos, lácteos, etc. Solo alimentos vegetales',
    }
}

class RobustTranslator:
    """A robust translation system that handles all edge cases"""
    
    def __init__(self, lang: str, debug: bool = False):
        self.lang = lang
        self.debug = debug
        self.translations = TRANSLATIONS.get(lang, {})
        self.replacements_made = []
        
    def log_debug(self, message: str):
        """Log debug messages if debug mode is enabled"""
        if self.debug:
            print(f"[DEBUG] {message}")
    
    def escape_for_regex(self, text: str) -> str:
        """Properly escape text for regex patterns"""
        # Escape all special regex characters
        escaped = re.escape(text)
        # Handle apostrophes specifically
        escaped = escaped.replace("\\'", "(?:'|\\\\')")
        return escaped
    
    def find_all_occurrences(self, content: str, search_text: str) -> List[Tuple[int, int, str]]:
        """Find all occurrences of a text in content with their contexts"""
        occurrences = []
        
        # Method 1: Direct string search (case-sensitive)
        start = 0
        while True:
            pos = content.find(search_text, start)
            if pos == -1:
                break
            context = content[max(0, pos-50):min(len(content), pos+50+len(search_text))]
            occurrences.append((pos, pos + len(search_text), context))
            start = pos + 1
        
        # Method 2: Look for escaped versions
        escaped_versions = [
            search_text.replace("'", "\\'"),
            search_text.replace('"', '\\"'),
            search_text.replace("'", "\\\\'"),
        ]
        
        for escaped_text in escaped_versions:
            start = 0
            while True:
                pos = content.find(escaped_text, start)
                if pos == -1:
                    break
                context = content[max(0, pos-50):min(len(content), pos+50+len(escaped_text))]
                occurrences.append((pos, pos + len(escaped_text), context))
                start = pos + 1
        
        return occurrences
    
    def replace_with_context(self, content: str, original: str, translation: str) -> str:
        """Replace text with proper context handling"""
        if original not in self.translations:
            return content
        
        replacements = 0
        
        # Handle dollar signs specially
        if '$' in original:
            # Replace dollar signs with euro signs in translation
            translation = translation.replace('$', '€')
            
        # Special handling for strings with apostrophes in JSON contexts
        # These appear as: jsonDecode('{"answer":"I'm hearing..."...')
        if "'" in original and f'"{original}"' in content:
            # The apostrophe is NOT escaped in this context
            old_pattern = f'"{original}"'
            new_pattern = f'"{translation}"'
            count = content.count(old_pattern)
            if count > 0:
                content = content.replace(old_pattern, new_pattern)
                replacements += count
                self.log_debug(f"Replaced '{original}' in JSON context ({count} times)")
                self.replacements_made.append((original, translation, count))
                return content  # Early return since we found and replaced it
        
        # Method 1: Replace in simple string literals
        patterns = [
            (f"'{original}'", f"'{translation}'"),
            (f'"{original}"', f'"{translation}"'),
            (f"\\'{original}\\'", f"\\'{translation}\\'"),
            (f'\\"{original}\\"', f'\\"{translation}\\"'),
        ]
        
        # Also handle strings inside jsonDecode with outer single quotes
        # This handles cases like: jsonDecode('{"answer":"I'm hearing..."...')
        if '"' + original + '"' in content:
            patterns.append((f'"{original}"', f'"{translation}"'))
        
        for pattern, replacement in patterns:
            if pattern in content:
                content = content.replace(pattern, replacement)
                replacements += content.count(replacement)
        
        # Method 2: Replace in JSON contexts
        # Handle escaped JSON strings
        # For JSON, we need to handle apostrophes that might already be escaped
        json_original = original
        json_translation = translation
        
        # If the original has apostrophes, also try with escaped versions
        json_patterns = [
            # Pattern for JSON with escaped quotes
            (r'(\\"(?:answer|title|AnswerTitle|AnswerDescription)\\"\s*:\s*\\")' + 
             re.escape(json_original).replace('\\$', '\\\\\\$').replace("\\'", "\\\\'") + r'(\\")', 
             lambda m: m.group(1) + json_translation + m.group(2)),
            # Pattern for regular JSON
            (r'("(?:answer|title|AnswerTitle|AnswerDescription)"\s*:\s*")' + 
             re.escape(json_original).replace('\\$', '\\\\\\$') + r'(")', 
             lambda m: m.group(1) + json_translation + m.group(2)),
        ]
        
        # Also try with pre-escaped apostrophes
        if "'" in original:
            escaped_json_original = original.replace("'", "\\'")
            escaped_json_translation = translation.replace("'", "\\'")
            json_patterns.extend([
                (r'(\\"(?:answer|title|AnswerTitle|AnswerDescription)\\"\s*:\s*\\")' + 
                 re.escape(escaped_json_original).replace('\\$', '\\\\\\$') + r'(\\")', 
                 lambda m: m.group(1) + escaped_json_translation + m.group(2)),
            ])
        
        for pattern, replacement_func in json_patterns:
            matches = list(re.finditer(pattern, content))
            if matches:
                replacements += len(matches)
                content = re.sub(pattern, replacement_func, content)
        
        # Method 3: Handle special cases with backslashes
        if "'" in original:
            # Handle cases where apostrophes might be escaped
            escaped_original = original.replace("'", "\\'")
            escaped_translation = translation.replace("'", "\\'")
            
            patterns = [
                (f'"{escaped_original}"', f'"{escaped_translation}"'),
                (f"'{escaped_original}'", f"'{escaped_translation}'"),
                (f'\\"{escaped_original}\\"', f'\\"{escaped_translation}\\"'),
            ]
            
            for pattern, replacement in patterns:
                if pattern in content:
                    content = content.replace(pattern, replacement)
                    replacements += content.count(replacement)
        
        if replacements > 0:
            self.replacements_made.append((original, translation, replacements))
            self.log_debug(f"Replaced '{original}' with '{translation}' ({replacements} times)")
        
        return content
    
    def translate_file(self, file_path: str) -> Tuple[str, List[Tuple[str, str, int]]]:
        """Translate a file and return the new content and replacement summary"""
        self.log_debug(f"Starting translation of {file_path} to {self.lang}")
        
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        self.replacements_made = []
        
        # Sort translations by length (longest first) to avoid partial replacements
        sorted_translations = sorted(self.translations.items(), key=lambda x: len(x[0]), reverse=True)
        
        # Apply each translation
        for original, translation in sorted_translations:
            content = self.replace_with_context(content, original, translation)
        
        # Check for missed translations if in debug mode
        if self.debug:
            self.check_missed_translations(content)
        
        return content, self.replacements_made
    
    def check_missed_translations(self, content: str):
        """Check for any strings that should have been translated but weren't"""
        missed = []
        for original, translation in self.translations.items():
            # Check if original text exists anywhere in the content
            if original in content:
                # Check if it's already translated
                if translation not in content:
                    occurrences = self.find_all_occurrences(content, original)
                    if occurrences:
                        missed.append((original, len(occurrences)))
        
        if missed:
            self.log_debug("\nMISSED TRANSLATIONS:")
            for text, count in missed:
                self.log_debug(f"  - '{text}' ({count} occurrences)")
    
    def test_translation(self, test_string: str) -> str:
        """Test translation on a sample string"""
        self.log_debug(f"\nTesting translation on sample string...")
        
        for original, translation in self.translations.items():
            test_string = self.replace_with_context(test_string, original, translation)
        
        return test_string

def main():
    parser = argparse.ArgumentParser(description='Robust translation system for app_state.dart')
    parser.add_argument('file_path', help='Path to the app_state.dart file')
    parser.add_argument('language', choices=['de', 'es'], help='Target language')
    parser.add_argument('--debug', action='store_true', help='Enable debug mode')
    parser.add_argument('--dry-run', action='store_true', help='Show what would be changed without modifying the file')
    parser.add_argument('--test', action='store_true', help='Run translation test on sample strings')
    
    args = parser.parse_args()
    
    translator = RobustTranslator(args.language, args.debug)
    
    if args.test:
        # Test mode - run translation on sample strings
        test_strings = [
            '''{"answer":"I'm hearing about it for the first time","isCorrect":false}''',
            '''{"answer":"Less than $10","description":"Awesome 🤩 you're budget conscious!"}''',
            '''{"answer":"😢 No and I'm tired of searching","isCorrect":false}''',
            '''{"answer":"Maybe, I'm not sure","response":"You're on the right track!"}''',
        ]
        
        print(f"\nTesting translations for {args.language}:")
        print("=" * 80)
        for test_string in test_strings:
            result = translator.test_translation(test_string)
            print(f"Original: {test_string}")
            print(f"Result:   {result}")
            print("-" * 80)
        return
    
    # Translate the file
    new_content, replacements = translator.translate_file(args.file_path)
    
    # Show summary
    print(f"\nTranslation Summary for {args.language}:")
    print("=" * 80)
    print(f"Total unique strings replaced: {len(replacements)}")
    print(f"Total replacements made: {sum(count for _, _, count in replacements)}")
    
    if replacements:
        print("\nReplacements made:")
        for original, translation, count in sorted(replacements, key=lambda x: x[2], reverse=True):
            print(f"  {count}x: '{original}' → '{translation}'")
    
    if not args.dry_run:
        # Write the modified content back
        with open(args.file_path, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"\n✅ Successfully translated {args.file_path} to {args.language}")
    else:
        print(f"\n🔍 Dry run completed - no files were modified")

if __name__ == "__main__":
    main()