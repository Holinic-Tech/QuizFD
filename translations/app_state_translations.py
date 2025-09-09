#!/usr/bin/env python3
"""
App State Translation System
Translates dynamic content in app_state.dart that isn't covered by FlutterFlow's i18n
"""

import re
import json
import sys

# Translation mappings for app state content
# Using informal, friendly, funny and relatable language
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
        
        # Knowledge state
        'Yes': 'Ja',
        'Not yet': 'Noch nicht',
        '🙌 Yes, but I need more support': '🙌 Ja, aber ich brauche mehr Unterstützung',
        '😢 No and I\'m tired of searching': '😢 Nein und ich bin es leid zu suchen',
        '😥 Not sure, it\'s complicated by myself': '😥 Nicht sicher, alleine ist es kompliziert',
        
        # Hairqare knowledge
        'Never heard of it': 'Noch nie davon gehört',
        'Heard about it, but not sure what it is': 'Schon mal gehört, aber weiß nicht genau was es ist',
        'Know what it is, but haven\'t tried it': 'Weiß was es ist, hab\'s aber noch nicht probiert',
        'Tried it and loved it!': 'Hab\'s probiert und liebe es!',
        'I\'m hearing about it for the first time': 'Höre zum ersten Mal davon',
        'I know a few things': 'Ich weiß ein paar Dinge',
        'Yes, I know everything about it': 'Ja, ich weiß alles darüber',
        
        # Mindset questions
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
        
        # Professional referral
        'Yes, by a dermatologist': 'Ja, von einem Hautarzt',
        'Yes, by a hair stylist': 'Ja, von meinem Friseur',
        'Yes, by a friend or family': 'Ja, von Freunden oder Familie',
        'No, I found you myself': 'Nein, ich hab euch selbst gefunden',
        
        # Shampoo spending
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
        'Bleaching / hair colour': 'Bleichen / Haarfarbe',
        'Sun exposure': 'Sonneneinstrahlung',
        'Frequent swimming': 'Häufiges Schwimmen',
        'Tight hair styles (braids, bun, ponytail...)': 'Straffe Frisuren (Zöpfe, Dutt, Pferdeschwanz...)',
        
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
        
        # Knowledge state
        'Yes': 'Sí',
        'Not yet': 'Todavía no',
        
        # Hairqare knowledge
        'Never heard of it': 'Nunca lo he oído',
        'Heard about it, but not sure what it is': 'Lo he oído, pero no sé exactamente qué es',
        'Know what it is, but haven\'t tried it': 'Sé lo que es, pero no lo he probado',
        'Tried it and loved it!': '¡Lo probé y me encanta!',
        
        # Mindset questions
        'Yes, definitely': 'Sí, totalmente',
        'You\'re absolutely right!': '¡Tienes toda la razón!',
        'Diet, stress, environment, and internal health all impact your hair. Our holistic approach addresses ALL these factors for truly transformative results.': 'La dieta, el estrés, el ambiente y la salud interna afectan tu pelo. Nuestro enfoque holístico aborda TODOS estos factores para resultados realmente transformadores.',
        'Not really': 'No mucho',
        'Think about this...': 'Piensa en esto...',
        'Your skin and nails are affected by what you eat and how you feel, right? Your hair is no different! Our holistic approach tackles root causes for lasting results.': 'Tu piel y uñas se ven afectadas por lo que comes y cómo te sientes, ¿verdad? ¡Tu pelo no es diferente! Nuestro enfoque holístico ataca las causas raíz para resultados duraderos.',
        
        # Professional referral
        'Yes': 'Sí',
        'No': 'No',
        'I\'m a professional': 'Soy profesional',
        'Yes, by a dermatologist': 'Sí, un dermatólogo',
        'Yes, by a hair stylist': 'Sí, mi peluquero/a',
        'Yes, by a friend or family': 'Sí, amigos o familia',
        'No, I found you myself': 'No, os encontré yo',
        
        # Shampoo spending
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
        
        # Spanish loading messages
        'Revisando el estado de tu cabello': 'Revisando el estado de tu cabello',
        'Analizando tu rutina': 'Analizando tu rutina',
        'Comprobando si el reto es para ti': 'Comprobando si el reto es para ti',
        
        # Spanish loading widget
        '🚫 Se acabaron los ingredientes dañinos ocultos.': '🚫 Se acabaron los ingredientes dañinos ocultos.',
        '🌱 Menos caída y nuevos pelitos baby.': '🌱 Menos caída y nuevos pelitos baby.',
        '✅ Split ends that don\'t come back.': '✅ Puntas abiertas que no vuelven.',
        '💛 Lo mejor de la ciencia, fácil en casa.': '💛 Lo mejor de la ciencia, fácil en casa.',
        
        # Spanish hair types
        'Liso': 'Liso',
        'Ondulado': 'Ondulado',
        'Rizado': 'Rizado',
        'Afro': 'Afro',
        'I don\'t know': 'No lo sé',
        
        # Spanish hair concerns
        'Caída o pelo más fino': 'Caída o pelo más fino',
        'Daño por tintes, calor o tratamientos químicos': 'Daño por tintes, calor o tratamientos químicos',
        'Irritación del cuero cabelludo o caspa': 'Irritación del cuero cabelludo o caspa',
        'Puntas abiertas, frizz y sequedad': 'Puntas abiertas, frizz y sequedad',
        'Otros problemas variados': 'Otros problemas variados',
        
        # Spanish hair goals
        'Quiero parar mi caída del pelo': 'Quiero parar mi caída del pelo',
        'Quiero pelo más largo y bonito': 'Quiero pelo más largo y bonito',
        'Quiero las dos cosas': 'Quiero las dos cosas',
        
        # Spanish diet
        'Comida rápida / Alimentos procesados': 'Comida rápida / Alimentos procesados',
        'Equilibrada / Alimentos integrales': 'Equilibrada / Alimentos integrales',
        'Protocolo nutricional personalizado': 'Protocolo nutricional personalizado',
        'Vegana / vegetariana': 'Vegana / vegetariana',
        'Otra cosa': 'Otra cosa',
        
        # Hair myths  
        'El aceite de romero reduce la caída': 'El aceite de romero reduce la caída',
        'El aceite de coco es el mejor para el pelo': 'El aceite de coco es el mejor para el pelo',
        'El agua de arroz hace crecer el pelo más rápido': 'El agua de arroz hace crecer el pelo más rápido',
        'Los productos naturales/orgánicos son mejores': 'Los productos naturales/orgánicos son mejores',
        'No lavar el pelo es bueno para el cuero cabelludo': 'No lavar el pelo es bueno para el cuero cabelludo',
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
        'Calor': 'Calor',
        'Decoloración / tinte': 'Decoloración / tinte',
        'Exposición al sol': 'Exposición al sol',
        'Nadar frecuentemente': 'Nadar frecuentemente',
        'Peinados tirantes (trenzas, moño, coleta...)': 'Peinados tirantes (trenzas, moño, coleta...)',
        'Heat styling (blow dry, straighten, curl)': 'Calor (secador, plancha, rizador)',
        'Chemical treatments (dye, bleach, perm)': 'Tratamientos químicos (tinte, decoloración, permanente)',
        'Tight hairstyles or extensions': 'Peinados tirantes o extensiones',
        'Swimming in chlorinated pools': 'Nadar en piscinas con cloro',
        'Sun exposure without protection': 'Sol sin protección',
        'Heat styling': 'Calor',
        'Bleaching / hair colouring': 'Decoloración / tinte',
        'Sun exposure': 'Exposición al sol',
        'Frequent swimming': 'Nadar frecuentemente',
        'Tight hair styles (braids, bun, ponytail...)': 'Peinados tirantes (trenzas, moño, coleta...)',
        
        # Plans
        'Reto de 14 Días': 'Reto de 14 Días',
        'Diario de Cuidado Capilar de 14 Días y Plantillas': 'Diario de Cuidado Capilar de 14 Días y Plantillas',
        'Taller de Champú de Lujo Casero': 'Taller de Champú de Lujo Casero',
        'Lista de Ingredientes Prohibidos': 'Lista de Ingredientes Prohibidos',
        'Manual Completo de Bienestar Capilar': 'Manual Completo de Bienestar Capilar',
        'Manual de Uso Inteligente de Siliconas y Sulfatos': 'Manual de Uso Inteligente de Siliconas y Sulfatos',
        'Experiencia de Mindfulness Capilar de 30 Días': 'Experiencia de Mindfulness Capilar de 30 Días',
        'Comunidad Exclusiva para Miembros': 'Comunidad Exclusiva para Miembros',
        'Analizador de Productos Capilares': 'Analizador de Productos Capilares',
        'Certificado de Finalización': 'Certificado de Finalización',
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
        
        # Knowledge state answers
        '🙌 Sí, pero necesito más apoyo': '🙌 Sí, pero necesito más apoyo',
        '😢 No and I\'m tired of searching': '😢 No y estoy cansada de buscar',
        '😥 Not sure, it\'s complicated by myself': '😥 No estoy segura, es complicado sola',
        '🙌 Yes, but I need more support': '🙌 Sí, pero necesito más apoyo',
        
        # Hairqare knowledge answers
        'I\'m hearing about it for the first time': 'Es la primera vez que lo escucho',
        'Sé algunas cosas': 'Sé algunas cosas',
        'Sí, lo sé todo sobre ello': 'Sí, lo sé todo sobre ello',
        'I know a few things': 'Sé algunas cosas',
        'Yes, I know everything about it': 'Sí, lo sé todo sobre ello',
        
        # Mindset state additional
        'Sí, totalmente': 'Sí, totalmente',
        'Maybe, I\'m not sure': 'Tal vez, no estoy segura',
        'I\'ve never considered that': 'Nunca lo había considerado',
        'No, solo necesito el producto adecuado': 'No, solo necesito el producto adecuado',
        'You\'re absolutely right!': '¡Tienes toda la razón!',
        'You\'re on the right track!': '¡Vas por buen camino!',
        'You\'ll be surprised!': '¡Te sorprenderás!',
        'It\'s a common misconception': 'Es un error común',
        'La dieta, el estrés, el ambiente y la salud interna afectan tu pelo. Nuestro enfoque holístico aborda TODOS estos factores para resultados realmente transformadores.': 'La dieta, el estrés, el ambiente y la salud interna afectan tu pelo. Nuestro enfoque holístico aborda TODOS estos factores para resultados realmente transformadores.',
        'No, I just need the right product': 'No, solo necesito el producto adecuado',
        'Diet, stress, environment, and internal health all impact your hair. Our holistic approach addresses ALL these factors for truly transformative results.': 'La dieta, el estrés, el ambiente y la salud interna afectan tu pelo. Nuestro enfoque holístico aborda TODOS estos factores para resultados realmente transformadores.',
        'La mayoría de las mujeres se centran solo en tratamientos externos, perdiendo el 50% de lo que determina la salud del cabello. Nuestro enfoque cambia eso abordando factores internos y externos para una transformación completa del cabello.': 'La mayoría de las mujeres se centran solo en tratamientos externos, perdiendo el 50% de lo que determina la salud del cabello. Nuestro enfoque cambia eso abordando factores internos y externos para una transformación completa del cabello.',
        'Most women focus only on external treatments, missing 50% of what determines hair health. Our approach changes that by addressing both internal and external factors for complete hair transformation.': 'La mayoría de las mujeres se centran solo en tratamientos externos, perdiendo el 50% de lo que determina la salud del cabello. Nuestro enfoque cambia eso abordando factores internos y externos para una transformación completa del cabello.',
        
        # Diet options
        'Comida rápida / Alimentos procesados': 'Comida rápida / Alimentos procesados',
        'Equilibrada / Alimentos integrales': 'Equilibrada / Alimentos integrales',
        'Protocolo nutricional personalizado': 'Protocolo nutricional personalizado',
        'Vegana / vegetariana': 'Vegana / vegetariana',
        'Otra cosa': 'Otra cosa',
        'Fast food / Processed food diet': 'Comida rápida / Alimentos procesados',
        'Balanced / Whole foods': 'Equilibrada / Alimentos integrales',
        'Custom nutrition protocol': 'Protocolo nutricional personalizado',
        'Vegan / vegetarian': 'Vegana / vegetariana',
        'Something else': 'Otra cosa',
        'Sin dieta específica': 'Sin dieta específica',
        'Vegetariana': 'Vegetariana',
        'Sin gluten': 'Sin gluten',
        'Vegana': 'Vegana',
        'Other': 'Otra',
        
        # Current routine
        '🤓 Avanzada': '🤓 Avanzada',
        'Salon visits, premium products, specialists, supplements': 'Visitas al salón, productos premium, especialistas, suplementos',
        '🫧 Cuidado básico': '🫧 Cuidado básico',
        'Mostly just shampoo and conditioner': 'Principalmente solo champú y acondicionador',
        '🤗 Mimos ocasionales': '🤗 Mimos ocasionales',
        'Basic care and occasional hair masks': 'Cuidado básico y mascarillas ocasionales',
        '🌿 Remedios naturales': '🌿 Remedios naturales',
        'Mostly oils, herbs or DIY treatments': 'Principalmente aceites, hierbas o tratamientos caseros',
        '😌 Ninguno de los anteriores': '😌 Ninguno de los anteriores',
        'I follow a different haircare routine': 'Sigo una rutina de cuidado del cabello diferente',
        '🤓 Advanced': '🤓 Avanzada',
        '🫧 Basic care': '🫧 Cuidado básico',
        '🤗 Occasional pampering': '🤗 Mimos ocasionales',
        '🌿 Natural remedies': '🌿 Remedios naturales',
        '😌 None of the above': '😌 Ninguno de los anteriores',
    }
}

def translate_text(text, lang):
    """Translate text to target language"""
    if lang not in TRANSLATIONS:
        return text
    return TRANSLATIONS[lang].get(text, text)

def process_app_state_file(file_path, lang):
    """Process app_state.dart file and translate relevant content"""
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Translate simple string lists (beforeLoadingData, loadingWidget)
    for original, translated in TRANSLATIONS[lang].items():
        # Escape special characters for regex
        escaped_original = re.escape(original)
        # Replace in simple string literals
        content = re.sub(f"'{escaped_original}'", f"'{translated}'", content)
        content = re.sub(f'"{escaped_original}"', f'"{translated}"', content)
        
        # Also replace inside JSON strings (for quiz content)
        # This handles strings like: '{"answer":"Hair loss or hair thinning",...}'
        # Need to handle both regular quotes and escaped quotes in JSON
        json_pattern = r'(\{[^}]*\\"(?:answer|title|AnswerTitle|AnswerDescription)\\"\s*:\s*\\")' + escaped_original + r'(\\",?[^}]*\})'
        # Use a lambda to avoid regex group reference errors
        content = re.sub(json_pattern, lambda m: m.group(1) + translated + m.group(2), content)
    
    # Write the modified content back
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(content)
    
    print(f"Translated app_state.dart to {lang} (including JSON content)")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python app_state_translations.py <file_path> <language_code>")
        sys.exit(1)
    
    file_path = sys.argv[1]
    lang = sys.argv[2]
    
    process_app_state_file(file_path, lang)