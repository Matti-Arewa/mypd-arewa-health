// utils/sample_data_de.dart
import '../models/content_model.dart';

class SampleData {
  static ContentData getSampleContent() {
    return ContentData(sections: [
      // SECTION 1: Grundlagen der Schwangerschaft
      ContentSection(
      id: 'basics',
      title: 'Einleitung und Grundlagen',
      description: 'Grundlegende Informationen über Schwangerschaft, Gynäkologen und den Verlauf.',
      imageUrl: 'assets/images/pregnancy_basics.png',
      categories: [
        ContentCategory(
          id: 'gynecologist',
          title: 'Aufgaben eines Gynäkologen',
          description: 'Informationen über den Frauenarzt und gynäkologische Untersuchungen.',
          imageUrl: 'assets/images/gynecologist.png',
          sectionId: 'basics',
          questions: [
            ContentQuestion(
              id: 'gynecologist_1',
              question: 'Was ist die Rolle eines Frauenarztes?',
              answer: 'Ein Frauenarzt kümmert sich um die reproduktive Gesundheit von Frauen in allen Lebensphasen. Zu seinen Hauptaufgaben gehören:\n\n• Präventive Versorgung: Krebsvorsorge, Ultraschall, gynäkologische Untersuchungen\n• Schwangerschaft & Geburt: Betreuung, Ultraschall, Entbindung, Nachsorge\n• Behandlung von Erkrankungen: Hormonstörungen, Infektionen, Endometriose, Myome\n• Beratung zu Verhütung & Fruchtbarkeit\n• Unterstützung in den Wechseljahren\n• Psychosomatische Betreuung\n• Operationen: Kaiserschnitt, Sterilisation, Tumorentfernung\n\nFrauenärzte begleiten Frauen medizinisch oft ein Leben lang.',
              categoryId: 'gynecologist',
            ),
            ContentQuestion(
              id: 'gynecologist_2',
              question: 'Was beinhaltet der erste gynäkologische Termin während der Schwangerschaft?',
              answer: 'Der erste gynäkologische Termin umfasst:\n\n• Eine ausführliche Anamnese (Krankengeschichte)\n• Erfassung von Gewicht, Größe und Blutdruck\n• Eine umfassende klinische Untersuchung\n• Ultraschalluntersuchung (falls technisch möglich) zur Beurteilung der inneren Organe, Lage und Entwicklung der Schwangerschaft.',
              categoryId: 'gynecologist',
            ),
            ContentQuestion(
              id: 'gynecologist_3',
              question: 'Welche Fragen sollte ich als schwangere Frau dem Arzt stellen?',
              answer: '1. Entwickelt sich die Schwangerschaft planmäßig? Diese Frage dient zur Bestätigung der normalen Entwicklung der Schwangerschaft.\n\n2. Worauf sollte ich als schwangere Frau achten? Diese Frage dient der individuellen Beratung durch den Arzt.\n\n3. Was sollte ich als schwangere Frau nicht tun? Diese Frage dient dazu, dich über deinen individuellen Schwangerschaftsverlauf zu beraten.',
              categoryId: 'gynecologist',
            ),
          ],
        ),
        ContentCategory(
          id: 'pregnancy_basics',
          title: 'Grundlagen der Schwangerschaft',
          description: 'Was ist eine Schwangerschaft und wie funktioniert sie?',
          imageUrl: 'assets/images/pregnancy_basics.png',
          sectionId: 'basics',
          questions: [
            ContentQuestion(
              id: 'pregnancy_basics_1',
              question: 'Was ist eine Schwangerschaft?',
              answer: 'Eine Schwangerschaft beginnt, wenn eine Samenzelle eine Eizelle befruchtet. Die befruchtete Eizelle nistet sich in der Gebärmutter ein und beginnt zu wachsen. Daraus entwickelt sich langsam ein Embryo und später ein Baby. Der Körper der Mutter versorgt das Baby über die Nabelschnur mit allem, was es braucht. Nach etwa neun Monaten ist das Baby bereit zur Geburt.',
              categoryId: 'pregnancy_basics',
            ),
            ContentQuestion(
              id: 'pregnancy_basics_2',
              question: 'Wie funktioniert eine Schwangerschaft?',
              answer: 'In der Schwangerschaft verändert sich der Hormonhaushalt der Frau stark. Wichtige Hormone wie HCG, Progesteron und Östrogen steigen stark. Sie bereiten den weiblichen Körper auf das Baby vor. Die Gebärmutter wächst mit dem Kind. Die Plazenta versorgt das Baby mit allem Wichtigen. Das Baby entwickelt sich Monat für Monat weiter und entwickelt sich von einem Zellhaufen zum fertigen kleinen Menschen.',
              categoryId: 'pregnancy_basics',
            ),
            ContentQuestion(
              id: 'pregnancy_basics_3',
              question: 'Wie und wann kann ich feststellen, dass ich schwanger bin?',
              answer: 'Eine Schwangerschaft wird oft durch folgende Zeichen erkannt:\n\n• Das Ausbleiben der Periode (besonders bei regelmäßigem Zyklus)\n• Übelkeit und Erbrechen, besonders morgens\n• Müdigkeit und erhöhtes Schlafbedürfnis\n• Häufiges Wasserlassen\n• Ein Spannungsgefühl in den Brüsten\n• Manchmal leichte Schmierblutungen bei der Einnistung\n\nEin Schwangerschaftstest aus der Apotheke oder Drogerie kann bereits ab dem ersten Tag der ausgebliebenen Periode durchgeführt werden. Am besten morgens, da der Urin dann konzentrierter ist.',
              categoryId: 'pregnancy_basics',
            ),
          ],
        ),
        ContentCategory(
          id: 'pregnancy_stages',
          title: 'Schwangerschaftsphasen',
          description: 'Informationen über die verschiedenen Phasen der Schwangerschaft.',
          imageUrl: 'assets/images/pregnancy_stages.png',
          sectionId: 'basics',
          questions: [
            ContentQuestion(
              id: 'pregnancy_stages_1',
              question: 'Wie lange dauert eine Schwangerschaft?',
              answer: 'Eine Schwangerschaft dauert etwa 40 Wochen (Schwangerschaftswochen = SSW), manchmal auch bis zu 42 Wochen. Das entspricht etwa 9-10 Monaten, gerechnet vom ersten Tag der letzten Periode.',
              categoryId: 'pregnancy_stages',
            ),
            ContentQuestion(
              id: 'pregnancy_stages_2',
              question: 'Was ist ein Trimester?',
              answer: 'Ein Trimenon ist ein Begriff, der die drei Phasen der Schwangerschaft beschreibt, die jeweils etwa drei Monate dauern.\n\n1. Erstes Trimenon (erste 12 Wochen): In dieser Phase findet die Befruchtung statt, und die frühen Entwicklungen des Embryos und der Organe beginnen. Die Frau kann erste Symptome wie Übelkeit und Müdigkeit erfahren.\n\n2. Zweites Trimenon (13. bis 26. Woche): Der Fötus wächst weiter, und viele der Beschwerden der ersten Phase lassen nach. In dieser Phase beginnen viele Frauen, ihren Babybauch zu zeigen.\n\n3. Drittes Trimenon (27. Woche bis zur Geburt): Das Baby wächst weiter, und der Körper der Mutter bereitet sich auf die Geburt vor. Es kann vermehrt zu körperlichen Beschwerden wie Rückenschmerzen oder Schlafproblemen kommen.',
              categoryId: 'pregnancy_stages',
            ),
            ContentQuestion(
              id: 'pregnancy_stages_3',
              question: 'Wie unterscheiden sich die Untersuchungen je nach Trimester?',
              answer: '1. Trimester (1-12 Wochen):\n• Erstuntersuchung: Blutdruck, Gewicht, Urin, Bluttests (Rhesusfaktor, Infektionen)\n• Ultraschall zur Bestätigung der Schwangerschaft\n• Optionale Tests: Nackentransparenzmessung, Ersttrimesterscreening, nicht-invasiver Pränataltest (NIPT)\n\n2. Trimester (13-28 Wochen):\n• Vorsorge alle 4 Wochen: Blutdruck, Gewicht, Urin, Wachstumsüberwachung\n• 20-22 Wochen: Detaillierte Ultraschalluntersuchung\n• 24-28 Wochen: Diabetesausschluss (Glukosetoleranztest)\n\n3. Trimester (29-40 Wochen):\n• Ab 29 Wochen Vorsorge alle 3 Wochen, ab 36 Wochen wöchentlich\n• CTG-Kontrollen, Bestimmung der Kindslage\n• Ab 40 Wochen engmaschige Überwachung bis zur Geburt\n\nAlle Untersuchungen dienen der Überwachung der Gesundheit von Mutter und Kind.',
              categoryId: 'pregnancy_stages',
            ),
            ContentQuestion(
              id: 'pregnancy_stages_4',
              question: 'Welche körperlichen Veränderungen können während der Schwangerschaft erwartet werden?',
              answer: 'Der Körper bereitet sich auf die Geburt vor: Die Gebärmutter wächst, Hormone verändern sich und das Gewicht nimmt zu. Typische Veränderungen während der Schwangerschaft können sein:\n\n1. Trimester (1-12 Wochen): Übelkeit, Müdigkeit, empfindliche Brüste.\n\n2. Trimester (13-28 Wochen): Wachsender Bauch, weniger Beschwerden, Kindsbewegungen können gespürt werden.\n\n3. Trimester (29-40 Wochen): Bauch wird schwerer, Rückenschmerzen, häufiges Wasserlassen, Vorbereitung auf die Geburt.',
              categoryId: 'pregnancy_stages',
            ),
          ],
        ),
      ],
    ),

    // SECTION 2: Kinderwunsch und Vorbereitung
    ContentSection(
    id: 'planning',
    title: 'Kinderwunsch und Vorbereitung',
    description: 'Informationen zur Vorbereitung und Planung einer Schwangerschaft.',
    imageUrl: 'assets/images/pre_pregnancy.png',
    categories: [
    ContentCategory(
    id: 'pre_pregnancy',
    title: 'Vor der Schwangerschaft',
    description: 'Informationen zur Vorbereitung und Planung einer Schwangerschaft.',
    imageUrl: 'assets/images/pre_pregnancy.png',
    sectionId: 'planning',
    questions: [
    ContentQuestion(
    id: 'pre_pregnancy_1',
    question: 'Was sollte ich vor einer Schwangerschaft beachten?',
    answer: 'Vor der Schwangerschaft bereitet sich der Körper der Frau auf den Eisprung vor, und die Gebärmutterschleimhaut baut sich auf. Um die Chancen auf eine gesunde Schwangerschaft zu erhöhen, sollten Sie folgende Punkte beachten:\n\n• Gesunde Ernährung mit viel Obst, Gemüse und Vollkornprodukten\n• Regelmäßige Bewegung, aber ohne Überanstrengung\n• Verzicht auf Alkohol, Nikotin und andere Drogen\n• Einnahme von Folsäure bereits vor der Schwangerschaft\n• Vorsorgeuntersuchungen beim Frauenarzt\n• Überprüfung der Immunität gegen Röteln und Windpocken',
    categoryId: 'pre_pregnancy',
    ),
    ContentQuestion(
    id: 'pre_pregnancy_2',
    question: 'Welche Voruntersuchungen sollte ich durchführen lassen, bevor ich schwanger werde?',
    answer: 'Vor der Schwangerschaft sollten Sie folgende Untersuchungen durchführen lassen, um Krankheiten auszuschließen und Risiken zu identifizieren:\n\n1. Allgemeincheck: Blutdruck, Blutbild, Schilddrüsenfunktion (TSH)\n2. Gynäkologischer Check: Abstrich, Ultraschall, eventuell Zyklusmonitoring\n3. Bluttests: Röteln, Windpocken, Toxoplasmose, Hepatitis B/C, HIV\n4. Impfungen: Masern, Mumps, Röteln, Windpocken, Tetanus, Keuchhusten, Grippe\n5. Zahncheck: Zahngesundheit überprüfen',
    categoryId: 'pre_pregnancy',
    ),
    ContentQuestion(
    id: 'pre_pregnancy_3',
    question: 'Wie kann ich meinen Lebensstil optimieren, um die Fruchtbarkeit zu verbessern?',
    answer: 'Vor und besonders während der Schwangerschaft sollten Sie Folgendes beachten:\n\n• Gesunde Ernährung mit viel Obst, Gemüse, Vollkornprodukten, gesunden Fetten (z.B. Avocado) und Proteinen\n• Gesundes Körpergewicht (BMI 18,5-24,9)\n• Moderate Bewegung (regelmäßig, aber nicht übertreiben)\n• Stressreduktion (Meditation, Yoga, Akupunktur)\n• Vermeidung schädlicher Substanzen (kein Nikotin und Alkohol, wenig Koffein)\n• Minimierung von Umweltgiften\n• Ausreichend Schlaf (7-9 Stunden)',
    categoryId: 'pre_pregnancy',
    ),
    ContentQuestion(
    id: 'pre_pregnancy_4',
    question: 'Welche Vitamine und Nährstoffe sollte ich bereits vor der Schwangerschaft einnehmen?',
    answer: 'Die folgenden Vitamine und Nährstoffe sind im Zusammenhang mit einer Schwangerschaft wichtig:\n\n• Folsäure: 400-800 μg (mindestens 3 Monate im Voraus)\n• Vitamin D: 800-1.000 IE täglich\n• Omega-3-Fettsäuren: 500-1.000 mg EPA/DHA\n• Eisen: je nach Blutwerten\n• Zink & Vitamin E: für die Eizellenqualität\n• Vitamin C: unterstützt die Eisenaufnahme\n• Jod: 150-200 μg täglich\n\nDiese Nahrungsergänzungsmittel sollten in Absprache mit Ihrem Arzt eingenommen werden.',
    categoryId: 'pre_pregnancy',
    ),
    ContentQuestion(
    id: 'pre_pregnancy_5',
    question: 'Welche Rolle spielt der Partner bei der Vorbereitung auf eine Schwangerschaft?',
    answer: 'Folgende Faktoren können Einfluss auf die Schwangerschaft haben:\n\n• Rauchen und Alkohol senken die Spermienqualität\n• Stress kann die Spermienproduktion verringern\n• Eine ausgewogene Ernährung verbessert die Fruchtbarkeit\n• Hitze (z. B. Sauna, Laptop auf dem Schoß) kann Spermien schädigen\n• Regelmäßige Bewegung fördert die Hormonbalance\n\nDarum prüft gemeinsam euren Lebensstil und verbessert ihn, falls notwendig.',
    categoryId: 'pre_pregnancy',
    ),
    ],
    ),
    ContentCategory(
    id: 'fertility',
    title: 'Fruchtbarkeit und Verhütung',
    description: 'Informationen über Fruchtbarkeit, Verhütungsmethoden und Familienplanung.',
    imageUrl: 'assets/images/fertility.png',
    sectionId: 'planning',
    questions: [
    ContentQuestion(
    id: 'fertility_1',
    question: 'Was ist Fruchtbarkeit?',
    answer: 'Fruchtbarkeit beschreibt die Fähigkeit, schwanger zu werden und ein Kind auszutragen.',
    categoryId: 'fertility',
    ),
    ContentQuestion(
    id: 'fertility_2',
    question: 'Wie funktioniert der weibliche Zyklus und wann liegen die fruchtbaren Tage?',
    answer: 'Der Zyklus beginnt mit der Periode und dauert etwa 28 Tage. Die fruchtbaren Tage sind um den Eisprung, meist zwischen Tag 12 und 16. In dieser Zeit ist die Chance auf eine Schwangerschaft am höchsten.',
    categoryId: 'fertility',
    ),
    ContentQuestion(
    id: 'fertility_3',
    question: 'Welche Faktoren beeinflussen die Fruchtbarkeit?',
    answer: 'Verschiedene Faktoren können die Fruchtbarkeit beeinflussen:\n\n• Stress stört den Hormonhaushalt – Entspannung und Pausen helfen\n• Übergewicht oder Untergewicht beeinflussen den Zyklus – eine gesunde Ernährung wirkt ausgleichend\n• Rauchen senkt die Fruchtbarkeit – ein Rauchstopp verbessert die Chancen\n• Alkohol kann die Eizellqualität verringern – besser ganz darauf verzichten\n• Alter spielt eine Rolle – je früher der Kinderwunsch, desto besser die Chancen',
    categoryId: 'fertility',
    ),
    ContentQuestion(
    id: 'fertility_4',
    question: 'Warum Verhütung anwenden?',
    answer: 'Verhütung wird angewendet, um ungewollte Schwangerschaften und sexuell übertragbare Krankheiten zu verhindern.',
    categoryId: 'fertility',
    ),
    ContentQuestion(
    id: 'fertility_5',
    question: 'Welche verschiedenen Verhütungsmethoden gibt es und was sind ihre Vor- und Nachteile?',
    answer: 'Verhütungsmethoden wie Kondome, die Pille oder Spiralen haben jeweils spezifische Vor- und Nachteile, wie Schutz vor Infektionen, Sicherheit oder Nebenwirkungen.',
    categoryId: 'fertility',
    ),
    ],
    ),
    ],
    ),

    // SECTION 3: Schwangerschaftsverlauf
    ContentSection(
    id: 'pregnancy_progress',
    title: 'Schwangerschaftsverlauf',
    description: 'Informationen über den Verlauf der Schwangerschaft und die Entwicklung des Babys.',
    imageUrl: 'assets/images/pregnancy_stages.png',
    categories: [
    ContentCategory(
    id: 'pregnancy_check',
    title: 'Schwangerschaftserkennung',
    description: 'Informationen über das Erkennen und Bestätigen einer Schwangerschaft.',
    imageUrl: 'assets/images/pregnancy_check.png',
    sectionId: 'pregnancy_progress',
    questions: [
    ContentQuestion(
    id: 'pregnancy_check_1',
    question: 'Wie stelle ich selbst eine Schwangerschaft fest?',
    answer: '• Ausbleiben der Periode - meistens erstes Anzeichen vor allem bei regelmäßigem Zyklus\n• Frühe Symptome- Übelkeit, Müdigkeit, Brustspannen oder häufiger Harndrang können Hinweise sein\n• Schwangerschaftstest - ein Urintest aus Drogerie oder Apotheke gibt in wenigen Minuten Klarheit – am besten morgens durchführen',
    categoryId: 'pregnancy_check',
    ),
    ContentQuestion(
    id: 'pregnancy_check_2',
    question: 'Wann sollte ich eine Schwangerschaft bestätigen lassen?',
    answer: 'Der ideale Zeitpunkt für die Bestätigung einer Schwangerschaft hängt davon ab, wie weit Sie fortgeschritten sind und wie sicher Sie das Ergebnis haben möchten. Hier sind einige allgemeine Richtlinien:\n\n1. Früherkennung (ab dem Ausbleiben der Periode):\nUrintest: Schwangerschaftstests für zu Hause können ab dem ersten Tag, an dem Ihre Periode ausbleibt, durchgeführt werden. Diese Tests messen das Hormon hCG im Urin, das früh in der Schwangerschaft produziert wird.\nArzttermin: Wenn der Schwangerschaftstest positiv ist oder Unsicherheit besteht, kann eine Bestätigung durch einen Arzt sinnvoll sein. Ein Bluttest beim Arzt ist empfindlicher und kann eine Schwangerschaft oft früher nachweisen (etwa 7-10 Tage nach dem Eisprung).\nErster Arztbesuch (ca. 6-8 Schwangerschaftswochen): Es wird empfohlen, den ersten Termin beim Frauenarzt etwa 2-3 Wochen nach Ausbleiben der Periode zu vereinbaren. Zu diesem Zeitpunkt kann der Arzt die Schwangerschaft mit einem Ultraschall bestätigen und den Fruchtsack oder Embryo sichtbar machen. Der Herzschlag ist oft ab der 6. Woche erkennbar.',
    categoryId: 'pregnancy_check',
    ),
    ContentQuestion(
    id: 'pregnancy_check_3',
    question: 'Wie stellt der Arzt die Entwicklung einer Schwangerschaft fest?',
    answer: 'Durch Symptome wie ausgebliebene Periode, Übelkeit, Spannung in den Brüsten. Bestätigung durch Schwangerschaftstest (hCG-Nachweis) und Ultraschall.',
    categoryId: 'pregnancy_check',
    ),
    ContentQuestion(
    id: 'pregnancy_check_4',
    question: 'Welche Anzeichen können in der Frühschwangerschaft auftreten?',
    answer: 'Übelkeit, Müdigkeit, Brustspannen, häufiges Wasserlassen, leichte Bauchschmerzen.',
    categoryId: 'pregnancy_check',
    ),
    ContentQuestion(
    id: 'pregnancy_check_5',
    question: 'Mit welchen Symptomen in der Frühschwangerschaft sollte ich einen Arzt aufsuchen?',
    answer: 'Starke Schmerzen, Blutungen, hohes Fieber, Schwindel, plötzliche starke Übelkeit.',
    categoryId: 'pregnancy_check',
    ),
    ],
    ),
    ContentCategory(
    id: 'nutrition',
    title: 'Ernährung während der Schwangerschaft',
    description: 'Leitfaden für eine richtige Ernährung für Mutter und Baby während der Schwangerschaft.',
    imageUrl: 'assets/images/nutrition.png',
    sectionId: 'pregnancy_progress',
    questions: [
    ContentQuestion(
    id: 'nutrition_1',
    question: 'Warum ist die Ernährung während der Schwangerschaft wichtig?',
    answer: 'Eine richtige Ernährung während der Schwangerschaft stellt sicher, dass das Baby wichtige Nährstoffe für die Entwicklung erhält und hilft, die Gesundheit der Mutter zu erhalten. Sie kann das Risiko von Geburtsfehlern und Komplikationen reduzieren.',
    categoryId: 'nutrition',
    ),
    ContentQuestion(
    id: 'nutrition_2',
    question: 'Welche Lebensmittel sollten während der Schwangerschaft vermieden werden?',
    answer: 'Zu vermeiden sind rohes oder unzureichend gegartes Fleisch, Fisch mit hohem Quecksilbergehalt, unpasteurisierte Milchprodukte, rohe Eier, ungewaschenes Obst und Gemüse sowie übermäßiges Koffein.',
    categoryId: 'nutrition',
    ),
    ContentQuestion(
    id: 'nutrition_3',
    question: 'Welche Nährstoffe sind während der Schwangerschaft besonders wichtig?',
    answer: 'Schlüsselnährstoffe sind Folsäure, Eisen, Kalzium, Vitamin D, Protein und Omega-3-Fettsäuren. Diese unterstützen die Entwicklung des Babys und den sich verändernden Körper der Mutter.',
    categoryId: 'nutrition',
    ),
    ContentQuestion(
    id: 'nutrition_4',
    question: 'Wie sollte ich mich während der Schwangerschaft ernähren?',
    answer: 'Schwangere Frauen sollten viel Obst, Gemüse, Proteine, Folsäure und Eisen zu sich nehmen und Lebensmittel wie rohes Fleisch, rohe Eier und unpasteurisierte Milchprodukte vermeiden.',
    categoryId: 'nutrition',
    ),
    ContentQuestion(
    id: 'nutrition_5',
    question: 'Welche Lebensmittel sind während der Schwangerschaft gesund?',
    answer: 'Gesunde Lebensmittel sind: Frisches Obst und Gemüse (für Vitamine und Ballaststoffe), Vollkornprodukte (für komplexe Kohlenhydrate und Ballaststoffe), mageres Fleisch, Fisch (besonders fettiger Fisch wie Lachs für Omega-3), Eier, Hülsenfrüchte und Nüsse (für Proteine und gesunde Fette), Milchprodukte (für Kalzium und Vitamin D), Hülsenfrüchte (für Eisen und Protein).',
    categoryId: 'nutrition',
    ),
    ContentQuestion(
    id: 'nutrition_6',
    question: 'Welche Lebensmittel sind während der Schwangerschaft ungesund?',
    answer: 'Ungesunde oder zu vermeidende Lebensmittel sind: Rohes Fleisch, roher Fisch (z.B. Sushi), rohe Eier und unpasteurisierte Milchprodukte (Risiko von Listeriose und Toxoplasmose), Leber und leberhaltige Produkte (aufgrund des hohen Vitamin-A-Gehalts), Koffein in großen Mengen (maximal 200 mg pro Tag, etwa eine Tasse Kaffee), Alkohol und Zigaretten (schädlich für die Entwicklung des Babys), Fisch mit hohem Quecksilbergehalt (z.B. Thunfisch, Schwertfisch).',
    categoryId: 'nutrition',
    ),
    ],
    ),
    ContentCategory(
    id: 'exercise',
    title: 'Bewegung während der Schwangerschaft',
    description: 'Sichere Bewegungspraktiken und Empfehlungen für schwangere Frauen.',
    imageUrl: 'assets/images/exercise.png',
    sectionId: 'pregnancy_progress',
    questions: [
    ContentQuestion(
    id: 'exercise_1',
    question: 'Ist Bewegung während der Schwangerschaft sicher?',
    answer: 'Bewegung während der Schwangerschaft ist nicht nur erlaubt, sondern auch sehr gesund - solange sie an die individuellen Bedürfnisse und die jeweilige Schwangerschaftsphase angepasst ist.',
    categoryId: 'exercise',
    ),
    ContentQuestion(
    id: 'exercise_2',
    question: 'Welche Arten von Bewegung sind während der Schwangerschaft geeignet?',
    answer: 'Sichere Aktivitäten umfassen Schwimmen, Gehen, Schwangerschaftsyoga, leichte Gymnastik oder Radfahren auf ebenem Gelände.',
    categoryId: 'exercise',
    ),
    ContentQuestion(
    id: 'exercise_3',
    question: 'Wie viel Bewegung sollte ich zu welchem Zeitpunkt der Schwangerschaft machen?',
      answer: '1. Erstes Trimester (1-12 Wochen):\n• Geeignet: Leichte bis moderate Bewegung, z.B. Gehen, Schwimmen, Yoga, Pilates, Radfahren auf ebenem Gelände\n• Vorsicht: Überhitzung vermeiden, extreme Anstrengung und Sportarten mit hohem Sturzrisiko\n• Nicht empfohlen: Kontaktsportarten, intensives Krafttraining, Sportarten mit hoher Belastung (z.B. Springreiten)\n\n2. Zweites Trimester (13-27 Wochen):\n• Geeignet: Schwangerschaftsyoga, moderates Krafttraining (besonders für Rücken und Beckenboden), Wassergymnastik, Gehen\n• Vorsicht: Keine Übungen im Liegen auf dem Rücken nach der 20. Woche (kann den Blutfluss zur Gebärmutter beeinträchtigen)\n• Nicht empfohlen: Sportarten mit plötzlichen Richtungswechseln oder hohem Verletzungsrisiko\n\n3. Drittes Trimester (28-40 Wochen):\n• Geeignet: Sanftes Yoga, Schwimmen, leichtes Krafttraining, Beckenbodenübungen\n• Vorsicht: Kein übermäßiges Dehnen, da Gelenke aufgrund des Hormons Relaxin lockerer sind\n• Nicht empfohlen: Sportarten mit hohem Sturzrisiko oder Belastung\n\nAllgemeine Tipps:\n✔ Höre auf deinen Körper und reduziere die Intensität, wenn du dich müde fühlst\n✔ Trinke viel Wasser\n✔ Vermeide Bewegung bei extremer Hitze\n✔ Konsultiere deinen Arzt oder deine Hebamme, wenn du unsicher bist',
      categoryId: 'exercise',
    ),
    ],
    ),
    ],
    ),

      // SECTION 4: Besondere Situationen und Komplikationen
      ContentSection(
        id: 'complications',
        title: 'Besondere Situationen & Komplikationen',
        description: 'Informationen zu möglichen Komplikationen und besonderen Situationen während der Schwangerschaft.',
        imageUrl: 'assets/images/complications.png',
        categories: [
          ContentCategory(
            id: 'pregnancy_complications',
            title: 'Komplikationen in der Schwangerschaft',
            description: 'Informationen über mögliche Komplikationen und Erkrankungen während der Schwangerschaft.',
            imageUrl: 'assets/images/complications.png',
            sectionId: 'complications',
            questions: [
              ContentQuestion(
                id: 'pregnancy_complications_1',
                question: 'Was sind die häufigsten Erkrankungen, die während der Schwangerschaft auftreten?',
                answer: 'Häufige Erkrankungen in der Schwangerschaft sind Präeklampsie, Harnwegsinfektionen und Schwangerschaftsdiabetes.',
                categoryId: 'pregnancy_complications',
              ),
              ContentQuestion(
                id: 'pregnancy_complications_2',
                question: 'Welche Risikofaktoren treten häufig auf?',
                answer: 'Zu den Risikofaktoren gehören mütterliches Alter über 35, chronische Erkrankungen, Rauchen, Alkoholkonsum und starkes Übergewicht.',
                categoryId: 'pregnancy_complications',
              ),
              ContentQuestion(
                id: 'pregnancy_complications_3',
                question: 'Welche Komplikationen können in der Frühschwangerschaft auftreten?',
                answer: 'Fehlgeburt, Eileiterschwangerschaft, Blutungen, Hyperemesis gravidarum (schwere Schwangerschaftsübelkeit).',
                categoryId: 'pregnancy_complications',
              ),
              ContentQuestion(
                id: 'pregnancy_complications_4',
                question: 'Gibt es medizinische Behandlungen für Komplikationen in der Schwangerschaft?',
                answer: 'Ja, z.B. hormonelle Unterstützung, Operation bei Eileiterschwangerschaft, intravenöse Flüssigkeiten bei schwerer Übelkeit.',
                categoryId: 'pregnancy_complications',
              ),
              ContentQuestion(
                id: 'pregnancy_complications_5',
                question: 'Welche Krankheiten können meiner Schwangerschaft schaden?',
                answer: 'Röteln, Toxoplasmose, Listeriose, Zika-Virus, Diabetes oder Schilddrüsenerkrankungen.',
                categoryId: 'pregnancy_complications',
              ),
            ],
          ),
          ContentCategory(
            id: 'premature_birth',
            title: 'Frühgeburt',
            description: 'Informationen über Frühgeburten, Ursachen und Versorgung.',
            imageUrl: 'assets/images/premature_birth.png',
            sectionId: 'complications',
            questions: [
              ContentQuestion(
                id: 'premature_birth_1',
                question: 'Was ist eine Frühgeburt?',
                answer: 'Eine Frühgeburt ist eine Geburt, die vor der 37. Schwangerschaftswoche (Gestationswoche) stattfindet.',
                categoryId: 'premature_birth',
              ),
              ContentQuestion(
                id: 'premature_birth_2',
                question: 'Wann gilt eine Geburt als Frühgeburt?',
                answer: 'Eine Geburt gilt als Frühgeburt, wenn das Kind vor Vollendung der 37. Schwangerschaftswoche geboren wird.',
                categoryId: 'premature_birth',
              ),
              ContentQuestion(
                id: 'premature_birth_3',
                question: 'Was sind die Ursachen für eine Frühgeburt?',
                answer: 'Ursachen für eine Frühgeburt können Infektionen, Mehrlingsschwangerschaften, anatomische Anomalien der Gebärmutter, Stress, Trauma oder chronische mütterliche Erkrankungen wie Bluthochdruck oder Diabetes sein.',
                categoryId: 'premature_birth',
              ),
              ContentQuestion(
                id: 'premature_birth_4',
                question: 'Gibt es körperliche Anzeichen für eine Frühgeburt?',
                answer: 'Körperliche Anzeichen einer Frühgeburt können regelmäßige Wehen, vaginale Blutungen, Rückenschmerzen, ein Druckgefühl im Becken und Verlust von Fruchtwasser sein.',
                categoryId: 'premature_birth',
              ),
              ContentQuestion(
                id: 'premature_birth_5',
                question: 'Welche möglichen Folgen hat eine Frühgeburt für die Mutter?',
                answer: 'Mögliche Folgen für die Mutter sind ein erhöhtes Risiko für weitere Frühgeburten, psychischer Stress und Komplikationen nach der Geburt.',
                categoryId: 'premature_birth',
              ),
              ContentQuestion(
                id: 'premature_birth_6',
                question: 'Welche möglichen Folgen hat eine Frühgeburt für das Kind?',
                answer: 'Mögliche Folgen für das Kind sind Atemprobleme, Unterentwicklung von Organen, Entwicklungsverzögerungen und ein erhöhtes Infektionsrisiko.',
                categoryId: 'premature_birth',
              ),
              ContentQuestion(
                id: 'premature_birth_7',
                question: 'Gibt es Möglichkeiten, eine Frühgeburt zu verhindern?',
                answer: 'Möglichkeiten zur Verhinderung einer Frühgeburt sind regelmäßige Vorsorgeuntersuchungen, Behandlung von Infektionen, Ruhe, Stressabbau und bei medizinischer Notwendigkeit die Einnahme von Progesteron.',
                categoryId: 'premature_birth',
              ),
              ContentQuestion(
                id: 'premature_birth_8',
                question: 'Was kann die schwangere Frau tun, um einer Frühgeburt vorzubeugen?',
                answer: 'Schwangere Frauen können eine gesunde Ernährung einhalten, Alkohol und Zigaretten vermeiden, Stress reduzieren und regelmäßige Arztbesuche wahrnehmen, um das Risiko einer Frühgeburt zu minimieren.',
                categoryId: 'premature_birth',
              ),
              ContentQuestion(
                id: 'premature_birth_9',
                question: 'Gesundheitsbedenken?',
                answer: 'Gesundheitsbedenken im Zusammenhang mit Frühgeburten umfassen Entwicklungsprobleme beim Kind, Atemwegserkrankungen, erhöhte Anfälligkeit für Infektionen und psychischen Stress für die Mutter.',
                categoryId: 'premature_birth',
              ),
            ],
          ),
          ContentCategory(
            id: 'late_birth',
            title: 'Späte Geburt',
            description: 'Informationen über späte Geburten und ihre möglichen Folgen.',
            imageUrl: 'assets/images/late_birth.png',
            sectionId: 'complications',
            questions: [
              ContentQuestion(
                id: 'late_birth_1',
                question: 'Wann gilt eine Geburt als späte Geburt?',
                answer: 'Eine späte Geburt liegt vor, wenn die Schwangerschaft länger als 42 Wochen dauert.',
                categoryId: 'late_birth',
              ),
              ContentQuestion(
                id: 'late_birth_2',
                question: 'Gesundheitsbedenken bei später Geburt?',
                answer: 'Gesundheitsbedenken bei einer späten Geburt umfassen ein erhöhtes Risiko für Komplikationen während der Geburt, Sauerstoffmangel für das Kind und ein größeres Geburtsgewicht, das die Geburt erschweren kann.',
                categoryId: 'late_birth',
              ),
            ],
          ),
        ],
      ),

      // SECTION 5: Medizinische Betreuung
      ContentSection(
        id: 'medical_care',
        title: 'Medizinische Betreuung',
        description: 'Informationen über Vorsorgeuntersuchungen und die medizinische Betreuung während der Schwangerschaft.',
        imageUrl: 'assets/images/prenatal_care.png',
        categories: [
          ContentCategory(
            id: 'prenatal_care',
            title: 'Vorsorgeuntersuchungen',
            description: 'Informationen über Vorsorgeuntersuchungen während der Schwangerschaft.',
            imageUrl: 'assets/images/prenatal_care.png',
            sectionId: 'medical_care',
            questions: [
              ContentQuestion(
                id: 'prenatal_care_1',
                question: 'Welche besonderen Untersuchungen gibt es während der Schwangerschaft?',
                answer: 'Es gibt besondere Untersuchungen wie Ultraschalluntersuchungen, Bluttests, den Glukosetest (Glukosetoleranztest), das Ersttrimesterscreening und mögliche pränatale Diagnostik, wie NIPT oder Fruchtwasseruntersuchung.',
                categoryId: 'prenatal_care',
              ),
              ContentQuestion(
                id: 'prenatal_care_2',
                question: 'Was ist Pränataldiagnostik?',
                answer: 'Pränataldiagnostik umfasst spezielle Tests wie Fruchtwasseruntersuchungen, um genetische Risiken zu erkennen.',
                categoryId: 'prenatal_care',
              ),
              ContentQuestion(
                id: 'prenatal_care_3',
                question: 'Welche Untersuchungen gehören zur Pränataldiagnostik?',
                answer: 'Zur Pränataldiagnostik gehören Ersttrimesterscreening, NIPT (nicht-invasive Pränataltests), Chorionzottenbiopsie, Amniozentese (Fruchtwasseruntersuchung) und detaillierter Ultraschall.',
                categoryId: 'prenatal_care',
              ),
              ContentQuestion(
                id: 'prenatal_care_4',
                question: 'Was ist ein CTG?',
                answer: 'Ein CTG (Kardiotokographie) misst die Herzfrequenz des Babys und die Wehen der Mutter ab der 26. Schwangerschaftswoche.',
                categoryId: 'prenatal_care',
              ),
              ContentQuestion(
                id: 'prenatal_care_5',
                question: 'Ist Ultraschall während der Schwangerschaft gefährlich?',
                answer: 'Eine Ultraschalluntersuchung ist nicht gefährlich und hilft, die Entwicklung des Kindes zu überwachen.',
                categoryId: 'prenatal_care',
              ),
            ],
          ),
        ],
      ),

      // SECTION 6: Geburt und Nachsorge
      ContentSection(
        id: 'birth_and_postpartum',
        title: 'Geburt und Nachsorge',
        description: 'Informationen über die Geburt, das Wochenbett und die Zeit danach.',
        imageUrl: 'assets/images/birth_preparation.png',
        categories: [
          ContentCategory(
            id: 'birth_preparation',
            title: 'Geburtsvorbereitung',
            description: 'Informationen über die Vorbereitung auf die Geburt und verschiedene Geburtsmethoden.',
            imageUrl: 'assets/images/birth_preparation.png',
            sectionId: 'birth_and_postpartum',
            questions: [
              ContentQuestion(
                id: 'birth_preparation_1',
                question: 'Welche Geburtsmethoden stehen mir zur Verfügung?',
                answer: 'Zu den Geburtsmethoden gehören vaginale Geburt, Kaiserschnitt, Wassergeburt und Geburten mit Unterstützung wie Saugglocke oder Zangengeburt.',
                categoryId: 'birth_preparation',
              ),
              ContentQuestion(
                id: 'birth_preparation_2',
                question: 'Wie kann ich mich mental und körperlich auf die Geburt vorbereiten?',
                answer: 'Geburtsvorbereitungskurse, Atemübungen, Entspannungsübungen und das Erlernen von Schmerzbewältigungstechniken können hilfreich sein. Auch der Austausch mit anderen Müttern kann psychische Stärke vermitteln.',
                categoryId: 'birth_preparation',
              ),
              ContentQuestion(
                id: 'birth_preparation_3',
                question: 'Wann sollte ich mich während der Schwangerschaft im Krankenhaus vorstellen?',
                answer: 'In der Regel stellen Sie sich von der 32. bis 36. Schwangerschaftswoche im Krankenhaus vor, um die Geburt zu planen.',
                categoryId: 'birth_preparation',
              ),
              ContentQuestion(
                id: 'birth_preparation_4',
                question: 'Welche persönlichen Gegenstände sollte ich zu einem Krankenhausbesuch mitbringen?',
                answer: 'Es ist ratsam, Ihren Mutterpass, Ihre Krankenversicherungskarte, eventuell eine Überweisung und persönliche Dokumente sowie bequeme Kleidung mitzubringen.',
                categoryId: 'birth_preparation',
              ),
            ],
          ),
          ContentCategory(
            id: 'postpartum',
            title: 'Wochenbett und Stillen',
            description: 'Informationen über das Wochenbett und das Stillen nach der Geburt.',
            imageUrl: 'assets/images/postpartum.png',
            sectionId: 'birth_and_postpartum',
            questions: [
              ContentQuestion(
                id: 'postpartum_1',
                question: 'Wie lange dauert das Wochenbett und worauf sollte ich in dieser Zeit achten?',
                answer: 'Das Wochenbett dauert etwa sechs bis acht Wochen und dient der körperlichen und emotionalen Erholung nach der Geburt. In dieser Zeit sollte auf ausreichende Ruhe, gesunde Ernährung und Wundheilung geachtet werden.',
                categoryId: 'postpartum',
              ),
              ContentQuestion(
                id: 'postpartum_2',
                question: 'Welche Rolle spielt die Hebamme im Wochenbett?',
                answer: 'Die Hebamme unterstützt im Wochenbett bei der Erholung, Wundversorgung, beim Stillen sowie der Pflege des Babys und gibt wertvolle Tipps für die neue Lebenssituation.',
                categoryId: 'postpartum',
              ),
              ContentQuestion(
                id: 'postpartum_3',
                question: 'Wie funktioniert das Stillen und wie oft sollte ich mein Baby stillen?',
                answer: 'Stillen funktioniert nach dem Prinzip von Angebot und Nachfrage: Je öfter Sie Ihr Baby an die Brust legen, desto mehr Milch wird produziert. Neugeborene sollten in den ersten Wochen mindestens acht bis zwölf Mal innerhalb von 24 Stunden gestillt werden, je nach den Bedürfnissen Ihres Babys.',
                categoryId: 'postpartum',
              ),
              ContentQuestion(
                id: 'postpartum_4',
                question: 'Was kann ich tun, wenn das Stillen nicht gut klappt?',
                answer: 'Wenn das Stillen nicht gut klappt, kann es hilfreich sein, auf die richtige Anlegetechnik zu achten, da diese entscheidend für den Stillerfolg ist. Unterstützung durch eine Hebamme oder Stillberaterin kann wertvolle Hilfe bieten.',
                categoryId: 'postpartum',
              ),
            ],
          ),
          ContentCategory(
            id: 'post_pregnancy',
            title: 'Nach der Schwangerschaft',
            description: 'Informationen über die Zeit nach der Geburt und die postpartale Erholung.',
            imageUrl: 'assets/images/post_pregnancy.png',
            sectionId: 'birth_and_postpartum',
            questions: [
              ContentQuestion(
                id: 'post_pregnancy_1',
                question: 'Was passiert nach der Schwangerschaft?',
                answer: 'Nach der Schwangerschaft bildet sich die Gebärmutter zurück, der Hormonhaushalt stabilisiert sich und die Milchproduktion beginnt.',
                categoryId: 'post_pregnancy',
              ),
              ContentQuestion(
                id: 'post_pregnancy_2',
                question: 'Wie lange dauert die körperliche Erholung nach der Geburt?',
                answer: 'Die vollständige körperliche Erholung kann bis zu sechs Wochen oder länger dauern, je nach Art der Geburt (vaginal oder Kaiserschnitt) und eventuellen Komplikationen.',
                categoryId: 'post_pregnancy',
              ),
              ContentQuestion(
                id: 'post_pregnancy_3',
                question: 'Wie kann ich die emotionale Anpassung nach der Geburt bewältigen?',
                answer: 'Zeit für sich selbst nehmen, ausreichend Ruhe und Unterstützung bekommen und offen über Emotionen sprechen kann helfen, den "Baby Blues" oder emotionale Anpassungen zu bewältigen. Wenn du starke Stimmungsschwankungen erlebst, solltest du einen Arzt aufsuchen.',
                categoryId: 'post_pregnancy',
              ),
            ],
          ),
        ],
      ),

      // SECTION 7: Das neugeborene Kind
      ContentSection(
        id: 'newborn_care',
        title: 'Das neugeborene Kind',
        description: 'Informationen über die Pflege und Betreuung des Neugeborenen.',
        imageUrl: 'assets/images/newborn.png',
        categories: [
          ContentCategory(
            id: 'newborn',
            title: 'Das Neugeborene',
            description: 'Informationen über die Pflege und Unterstützung des Neugeborenen.',
            imageUrl: 'assets/images/newborn.png',
            sectionId: 'newborn_care',
            questions: [
              ContentQuestion(
                id: 'newborn_1',
                question: 'Wie oft muss ein Neugeborenes gefüttert werden?',
                answer: 'Ein Neugeborenes sollte etwa alle 2-3 Stunden gefüttert werden, also 8-12 Mal in 24 Stunden.',
                categoryId: 'newborn',
              ),
              ContentQuestion(
                id: 'newborn_2',
                question: 'Wie kann ich mein Baby beruhigen, wenn es weint?',
                answer: 'Zur Beruhigung können körperlicher Kontakt, sanftes Wiegen oder leises Summen helfen.',
                categoryId: 'newborn',
              ),
              ContentQuestion(
                id: 'newborn_3',
                question: 'Welche Schlafmuster sind für ein Neugeborenes normal?',
                answer: 'Neugeborene schlafen unregelmäßig und in der Regel 16-18 Stunden am Tag, verteilt auf kurze Schlafphasen.',
                categoryId: 'newborn',
              ),
              ContentQuestion(
                id: 'newborn_4',
                question: 'Wie oft sollte ich mein Neugeborenes zum Kinderarzt bringen?',
                answer: 'Mit einem Neugeborenen sollten Sie regelmäßig die Vorsorgeuntersuchungen beim Kinderarzt wahrnehmen, die nach einem festen Zeitplan stattfinden.',
                categoryId: 'newborn',
              ),
              ContentQuestion(
                id: 'newborn_5',
                question: 'Welche Untersuchungen sind beim Kinderarzt in den ersten Monaten wichtig?',
                answer: 'Die U1, unmittelbar nach der Geburt, umfasst die Überprüfung von Atmung, Herzschlag, Muskeltonus, Reflexen und Hautfarbe (APGAR-Score) sowie die Erstversorgung, einschließlich Durchtrennung der Nabelschnur und Warmhalten.\n\nDie U2 (3.-10. Lebenstag) umfasst eine gründliche körperliche Untersuchung, Überprüfung der Organe, Reflexe und ein Neugeborenen-Screening auf Stoffwechselerkrankungen.\n\nDie U4 (3.-4. Lebensmonat) überprüft die körperliche und motorische Entwicklung, den Impfstatus und umfasst oft die ersten Impfungen.',
                categoryId: 'newborn',
              ),
            ],
          ),
        ],
      ),

      // SECTION 8: Verhaltensrichtlinien
      ContentSection(
        id: 'guidelines',
        title: 'Verhaltensrichtlinien',
        description: 'Richtlinien und Empfehlungen für die Schwangerschaft.',
        imageUrl: 'assets/images/dont_dos.png',
        categories: [
          ContentCategory(
            id: 'dont_dos',
            title: 'Verhaltensrichtlinien',
            description: 'Richtlinien und zu vermeidende Aktivitäten während der Schwangerschaft.',
            imageUrl: 'assets/images/dont_dos.png',
            sectionId: 'guidelines',
            questions: [
              ContentQuestion(
                id: 'dont_dos_1',
                question: 'Was sind Don\'ts, sobald Sie wissen, dass Sie schwanger sind?',
                answer: 'Schwangere Frauen sollten Alkohol, Drogen und rohes Fleisch und Fisch vermeiden, keine schweren Gegenstände heben und übermäßigen Koffeinkonsum einschränken.',
                categoryId: 'dont_dos',
              ),
            ],
          ),
        ],
      ),
    ]);
  }
}