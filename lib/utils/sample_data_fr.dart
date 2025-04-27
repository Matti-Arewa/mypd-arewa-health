// utils/sample_data_fr.dart
import '../models/content_model.dart';

class SampleDataFR {
  static ContentData getSampleContent() {
    return ContentData(sections: [
      // SECTION 1: Basics of Pregnancy
      ContentSection(
        id: 'basics',
        title: 'Introduction et notions de base',
        description: 'Informations de base sur la grossesse, les gynécologues et le processus.',
        imageUrl: 'assets/images/pregnancy_basics.png',
        categories: [
          ContentCategory(
            id: 'gynecologist',
            title: 'Rôles d’un gynécologue',
            description: 'Informations sur le gynécologue et les examens gynécologiques.',
            imageUrl: 'assets/images/gynecologist.png',
            sectionId: 'basics',
            questions: [
              ContentQuestion(
                id: 'gynecologist_1',
                question: 'Quel est le rôle d’un gynécologue ?',
                answer: 'Un gynécologue prend en charge la santé reproductive des femmes à chaque étape de la vie. Ses principales responsabilités comprennent :\n\n• Soins préventifs : dépistage du cancer, échographie, examens gynécologiques\n• Grossesse et accouchement : suivi prénatal, échographie, accouchement, suivi post-partum\n• Traitement des affections : troubles hormonaux, infections, endométriose, fibromes\n• Conseils en contraception et fertilité\n• Accompagnement pendant la ménopause\n• Prise en charge psychosomatique\n• Interventions chirurgicales : césarienne, stérilisation, ablation de tumeurs\n\nLes gynécologues accompagnent souvent les femmes médicalement tout au long de leur vie.',
                categoryId: 'gynecologist',
              ),
              ContentQuestion(
                id: 'gynecologist_2',
                question: 'Que comprend le premier rendez-vous prénatal ?',
                answer: 'Le premier rendez-vous prénatal comprend :\n\n• Un historique médical détaillé\n• La prise de poids, de taille et de tension artérielle\n• Un examen clinique complet\n• Une échographie (si techniquement possible) pour évaluer les organes internes, la position et le développement de la grossesse.',
                categoryId: 'gynecologist',
              ),
              ContentQuestion(
                id: 'gynecologist_3',
                question: 'Quelles questions devrais-je poser à mon médecin en tant que femme enceinte ?',
                answer: '1. La grossesse évolue-t-elle normalement ? Cette question permet de confirmer le déroulement régulier de la grossesse.\n\n2. À quoi dois-je faire attention pendant la grossesse ? Cela fournit des conseils personnalisés du médecin.\n\n3. Que dois-je éviter de faire pendant la grossesse ? Cela vous aide à comprendre les éventuelles restrictions spécifiques à votre grossesse.',
                categoryId: 'gynecologist',
              ),
            ],
          ),
          ContentCategory(
            id: 'pregnancy_basics',
            title: 'Notions de base sur la grossesse',
            description: 'Qu’est-ce que la grossesse et comment fonctionne-t-elle ?',
            imageUrl: 'assets/images/pregnancy_basics.png',
            sectionId: 'basics',
            questions: [
              ContentQuestion(
                id: 'pregnancy_basics_1',
                question: 'Qu’est-ce que la grossesse ?',
                answer: 'La grossesse débute lorsqu’un spermatozoïde féconde un ovule. L’œuf fécondé s’implante dans l’utérus et commence à se développer. Il évolue progressivement en embryon puis en bébé. Le corps de la mère fournit tout ce dont le bébé a besoin via le cordon ombilical. Après environ neuf mois, le bébé est prêt à naître.',
                categoryId: 'pregnancy_basics',
              ),
              ContentQuestion(
                id: 'pregnancy_basics_2',
                question: 'Comment fonctionne la grossesse ?',
                answer: 'Pendant la grossesse, le taux d’hormones chez la femme change de manière significative. Des hormones clés comme la hCG, la progestérone et les œstrogènes augmentent fortement. Elles préparent le corps à accueillir le bébé. L’utérus se développe en même temps que le bébé. Le placenta fournit au bébé les nutriments essentiels. Le bébé se développe mois après mois, passant d’un amas de cellules à un petit humain entièrement formé.',
                categoryId: 'pregnancy_basics',
              ),
              ContentQuestion(
                id: 'pregnancy_basics_3',
                question: 'Comment et quand puis-je savoir que je suis enceinte ?',
                answer: 'La grossesse est souvent détectée par les signes suivants :\n\n• Absence de règles (surtout en cas de cycle régulier)\n• Nausées et vomissements, surtout le matin\n• Fatigue et besoin accru de sommeil\n• Mictions fréquentes\n• Sensibilité des seins\n• Parfois de légers saignements lors de l’implantation\n\nUn test de grossesse en vente libre peut être effectué dès le premier jour de retard des règles, de préférence le matin, lorsque l’urine est plus concentrée.',
                categoryId: 'pregnancy_basics',
              ),
            ],
          ),
          ContentCategory(
            id: 'pregnancy_stages',
            title: 'Étapes de la grossesse',
            description: 'Informations sur les différentes étapes de la grossesse.',
            imageUrl: 'assets/images/pregnancy_stages.png',
            sectionId: 'basics',
            questions: [
              ContentQuestion(
                id: 'pregnancy_stages_1',
                question: 'Combien de temps dure une grossesse ?',
                answer: 'Une grossesse dure environ 40 semaines (semaines de gestation), parfois jusqu’à 42 semaines. Cela correspond à environ 9-10 mois, calculés à partir du premier jour des dernières règles.',
                categoryId: 'pregnancy_stages',
              ),
              ContentQuestion(
                id: 'pregnancy_stages_2',
                question: 'Qu’est-ce qu’un trimestre ?',
                answer: 'Un trimestre désigne l’une des trois phases de la grossesse, chacune durant environ trois mois.\n\n1. Premier trimestre (semaines 1-12) : la fécondation se produit et le développement précoce de l’embryon et des organes commence. Des symptômes tels que nausées et fatigue peuvent apparaître.\n\n2. Deuxième trimestre (semaines 13-26) : le fœtus continue de croître et de nombreuses gênes initiales disparaissent. Le ventre devient visible.\n\n3. Troisième trimestre (semaines 27-40) : le bébé grossit davantage et le corps de la mère se prépare à l’accouchement. Les inconforts physiques comme les maux de dos ou les troubles du sommeil peuvent augmenter.',
                categoryId: 'pregnancy_stages',
              ),
              ContentQuestion(
                id: 'pregnancy_stages_3',
                question: 'En quoi les examens diffèrent-ils selon le trimestre ?',
                answer: '1. Premier trimestre (semaines 1-12) :\n• Examen initial : tension artérielle, poids, urines, analyses sanguines (facteur Rh, infections)\n• Échographie pour confirmer la grossesse\n• Examens optionnels : mesure de la clarté nucale, dépistage du premier trimestre, test prénatal non invasif (DPNI)\n\n2. Deuxième trimestre (semaines 13-28) :\n• Consultations toutes les 4 semaines : tension artérielle, poids, urines, suivi de la croissance\n• 20-22 semaines : échographie détaillée\n• 24-28 semaines : test de tolérance au glucose pour exclure un diabète\n\n3. Troisième trimestre (semaines 29-40) :\n• À partir de la semaine 29, consultations toutes les 3 semaines, à partir de la semaine 36 hebdomadaires\n• Monitoring CTG, évaluation de la position fœtale\n• À partir de la semaine 40, suivi rapproché jusqu’à l’accouchement\n\nTous ces examens visent à surveiller la santé de la mère et de l’enfant.',
                categoryId: 'pregnancy_stages',
              ),
              ContentQuestion(
                id: 'pregnancy_stages_4',
                question: 'Quels changements physiques peut-on attendre pendant la grossesse ?',
                answer: 'Le corps se prépare à l’accouchement : l’utérus se développe, les hormones changent et le poids augmente. Changements typiques selon le trimestre :\n\n1. Premier trimestre (semaines 1-12) : nausées, fatigue, sensibilité des seins.\n\n2. Deuxième trimestre (semaines 13-28) : ventre qui s’arrondit, moins de gênes, perception des mouvements fœtaux.\n\n3. Troisième trimestre (semaines 29-40) : ventre plus volumineux, maux de dos, mictions fréquentes, préparation à l’accouchement.',
                categoryId: 'pregnancy_stages',
              ),
            ],
          ),
        ],
      ),

      // SECTION 2: Family Planning and Preparation
      ContentSection(
        id: 'planning',
        title: 'Planification familiale et préparation',
        description: 'Informations sur la préparation et la planification d’une grossesse.',
        imageUrl: 'assets/images/pre_pregnancy.png',
        categories: [
          ContentCategory(
            id: 'pre_pregnancy',
            title: 'Avant la grossesse',
            description: 'Informations sur la préparation et la planification d’une grossesse.',
            imageUrl: 'assets/images/pre_pregnancy.png',
            sectionId: 'planning',
            questions: [
              ContentQuestion(
                id: 'pre_pregnancy_1',
                question: 'Que dois-je prendre en compte avant de tomber enceinte ?',
                answer: 'Avant la grossesse, le corps de la femme se prépare à l’ovulation et à l’épaississement de la muqueuse utérine. Pour augmenter vos chances d’une grossesse en bonne santé, tenez compte des points suivants :\n\n• Alimentation équilibrée riche en fruits, légumes et céréales complètes\n• Exercice régulier sans effort excessif\n• Éviter l’alcool, la nicotine et autres drogues\n• Prendre de l’acide folique avant la grossesse\n• Consultations de routine chez le gynécologue\n• Vérifier l’immunité contre la rougeole et la varicelle',
                categoryId: 'pre_pregnancy',
              ),
              ContentQuestion(
                id: 'pre_pregnancy_2',
                question: 'Quels bilans préconceptionnels devrais-je réaliser ?',
                answer: 'Avant la grossesse, vous devriez subir les bilans suivants pour exclure des maladies et identifier les risques :\n\n1. Bilan général : tension artérielle, numération formule sanguine, fonction thyroïdienne (TSH)\n2. Bilan gynécologique : frottis, échographie, éventuel suivi de cycle\n3. Analyses sanguines : rougeole, varicelle, toxoplasmose, hépatites B/C, VIH\n4. Vaccinations : rougeole, oreillons, rubéole, varicelle, tétanos, coqueluche, grippe\n5. Bilan dentaire : examen de la santé bucco-dentaire',
                categoryId: 'pre_pregnancy',
              ),
              ContentQuestion(
                id: 'pre_pregnancy_3',
                question: 'Comment puis-je optimiser mon mode de vie pour améliorer ma fertilité ?',
                answer: 'Avant et surtout pendant la grossesse, faites attention à :\n\n• Alimentation équilibrée avec fruits, légumes, céréales complètes, graisses saines (p. ex. avocat) et protéines\n• Poids santé (IMC entre 18,5 et 24,9)\n• Exercice modéré (régulier mais pas excessif)\n• Réduction du stress (méditation, yoga, acupuncture)\n• Éviter les substances nocives (pas de nicotine, pas d’alcool ; limiter la caféine)\n• Minimiser les toxines environnementales\n• Sommeil suffisant (7 à 9 heures)',
                categoryId: 'pre_pregnancy',
              ),
              ContentQuestion(
                id: 'pre_pregnancy_4',
                question: 'Quels vitamines et nutriments devrais-je prendre avant la grossesse ?',
                answer: 'Les vitamines et nutriments importants pour la grossesse comprennent :\n\n• Acide folique : 400-800 μg (au moins 3 mois avant)\n• Vitamine D : 800-1000 UI par jour\n• Acides gras oméga-3 : 500-1000 mg d’EPA/DHA\n• Fer : selon les besoins en fonction des valeurs sanguines\n• Zinc et vitamine E : pour la qualité de l’ovule\n• Vitamine C : favorise l’absorption du fer\n• Iode : 150-200 μg par jour\n\nPrenez ces compléments en consultation avec votre médecin.',
                categoryId: 'pre_pregnancy',
              ),
              ContentQuestion(
                id: 'pre_pregnancy_5',
                question: 'Quel rôle joue le partenaire dans la préparation à la grossesse ?',
                answer: 'Les facteurs suivants peuvent affecter la grossesse :\n\n• Tabac et alcool réduisent la qualité du sperme\n• Le stress peut diminuer la production de spermatozoïdes\n• Une alimentation équilibrée améliore la fertilité\n• Exposition à la chaleur (sauna, ordinateur portable sur les genoux) peut endommager les spermatozoïdes\n• Exercice régulier favorise l’équilibre hormonal\n\nRévisez votre mode de vie ensemble et apportez des améliorations si nécessaire.',
                categoryId: 'pre_pregnancy',
              ),
            ],
          ),
          ContentCategory(
            id: 'fertility',
            title: 'Fertilité et contraception',
            description: 'Informations sur la fertilité, les méthodes contraceptives et la planification familiale.',
            imageUrl: 'assets/images/fertility.png',
            sectionId: 'planning',
            questions: [
              ContentQuestion(
                id: 'fertility_1',
                question: 'Qu’est-ce que la fertilité ?',
                answer: 'La fertilité décrit la capacité de concevoir et de mener une grossesse à terme.',
                categoryId: 'fertility',
              ),
              ContentQuestion(
                id: 'fertility_2',
                question: 'Comment fonctionne le cycle féminin et quand sont les jours fertiles ?',
                answer: 'Le cycle commence par les menstruations et dure environ 28 jours. Les jours fertiles se situent autour de l’ovulation, généralement entre le 12ᵉ et le 16ᵉ jour, lorsque les chances de grossesse sont les plus élevées.',
                categoryId: 'fertility',
              ),
              ContentQuestion(
                id: 'fertility_3',
                question: 'Quels facteurs influencent la fertilité ?',
                answer: 'Différents facteurs peuvent influencer la fertilité :\n\n• Le stress perturbe les hormones – la relaxation et les pauses aident\n• Le surpoids ou le sous-poids affecte le cycle – une alimentation saine rééquilibre\n• Le tabac réduit la fertilité – arrêter augmente les chances\n• L’alcool peut diminuer la qualité des ovocytes – mieux vaut l’éviter\n• L’âge compte – plus tôt c’est mieux',
                categoryId: 'fertility',
              ),
              ContentQuestion(
                id: 'fertility_4',
                question: 'Pourquoi utiliser la contraception ?',
                answer: 'La contraception est utilisée pour prévenir les grossesses non désirées et les infections sexuellement transmissibles.',
                categoryId: 'fertility',
              ),
              ContentQuestion(
                id: 'fertility_5',
                question: 'Quelles sont les différentes méthodes contraceptives disponibles et quels en sont les avantages et inconvénients ?',
                answer: 'Les méthodes contraceptives comme les préservatifs, la pilule ou les DIU ont chacune des avantages et inconvénients spécifiques, tels que la protection contre les infections, l’efficacité ou les effets secondaires.',
                categoryId: 'fertility',
              ),
            ],
          ),
        ],
      ),

      // SECTION 3: Pregnancy Progress
      ContentSection(
        id: 'pregnancy_progress',
        title: 'Évolution de la grossesse',
        description: 'Informations sur le déroulement de la grossesse et le développement du bébé.',
        imageUrl: 'assets/images/pregnancy_stages.png',
        categories: [
          ContentCategory(
            id: 'pregnancy_check',
            title: 'Détection de la grossesse',
            description: 'Informations sur la détection et la confirmation de la grossesse.',
            imageUrl: 'assets/images/pregnancy_check.png',
            sectionId: 'pregnancy_progress',
            questions: [
              ContentQuestion(
                id: 'pregnancy_check_1',
                question: 'Comment puis-je détecter moi-même une grossesse ?',
                answer: '• Absence de règles – souvent le premier signe, surtout avec un cycle régulier\n• Symptômes précoces – nausées, fatigue, sensibilité des seins, mictions fréquentes peuvent être des indicateurs\n• Test de grossesse – un test urinaire en pharmacie donne des résultats en quelques minutes ; à réaliser de préférence le matin',
                categoryId: 'pregnancy_check',
              ),
              ContentQuestion(
                id: 'pregnancy_check_2',
                question: 'Quand devrais-je faire confirmer ma grossesse par un médecin ?',
                answer: 'Le moment idéal dépend de l’avancement de la grossesse et du niveau de certitude souhaité :\n\n1. Détection précoce (dès le retard des règles) :\n- Test urinaire : les tests de grossesse mesurent l’hCG dans les urines dès le premier jour de retard.\n- Consultation : pour confirmation ou en cas d’incertitude, une prise de sang détecte la grossesse plus tôt (environ 7-10 jours après l’ovulation).\n\n2. Premier rendez-vous prénatal (vers 6-8 semaines) : à planifier 2-3 semaines après le retard des règles. Une échographie peut confirmer la grossesse en visualisant le sac gestationnel ou l’embryon ; un battement de cœur est souvent visible dès la 6ᵉ semaine.',
                categoryId: 'pregnancy_check',
              ),
              ContentQuestion(
                id: 'pregnancy_check_3',
                question: 'Comment le médecin évalue-t-il le développement de la grossesse ?',
                answer: 'Par des symptômes tels que l’absence de règles, les nausées, la sensibilité des seins. Confirmation par test de grossesse (détection de l’hCG) et échographie.',
                categoryId: 'pregnancy_check',
              ),
              ContentQuestion(
                id: 'pregnancy_check_4',
                question: 'Quels signes peuvent survenir en début de grossesse ?',
                answer: 'Nausées, fatigue, sensibilité des seins, mictions fréquentes, légères crampes abdominales.',
                categoryId: 'pregnancy_check',
              ),
              ContentQuestion(
                id: 'pregnancy_check_5',
                question: 'Quels symptômes précoces de la grossesse doivent inciter à consulter un médecin ?',
                answer: 'Douleurs intenses, saignements, forte fièvre, étourdissements, nausées soudaines et intenses.',
                categoryId: 'pregnancy_check',
              ),
            ],
          ),
          ContentCategory(
            id: 'nutrition',
            title: 'Nutrition pendant la grossesse',
            description: 'Lignes directrices pour une bonne nutrition de la mère et du bébé pendant la grossesse.',
            imageUrl: 'assets/images/nutrition.png',
            sectionId: 'pregnancy_progress',
            questions: [
              ContentQuestion(
                id: 'nutrition_1',
                question: 'Pourquoi la nutrition est-elle importante pendant la grossesse ?',
                answer: 'Une nutrition adéquate pendant la grossesse garantit que le bébé reçoit les nutriments essentiels à son développement et aide à maintenir la santé de la mère. Cela peut réduire le risque de malformations et de complications.',
                categoryId: 'nutrition',
              ),
              ContentQuestion(
                id: 'nutrition_2',
                question: 'Quels aliments doivent être évités pendant la grossesse ?',
                answer: 'Éviter la viande crue ou insuffisamment cuite, les poissons à forte teneur en mercure, les produits laitiers non pasteurisés, les œufs crus, les fruits et légumes non lavés et l’excès de caféine.',
                categoryId: 'nutrition',
              ),
              ContentQuestion(
                id: 'nutrition_3',
                question: 'Quels nutriments sont particulièrement importants pendant la grossesse ?',
                answer: 'Les nutriments clés comprennent l’acide folique, le fer, le calcium, la vitamine D, les protéines et les acides gras oméga-3. Ils soutiennent le développement fœtal et l’adaptation du corps maternel.',
                categoryId: 'nutrition',
              ),
              ContentQuestion(
                id: 'nutrition_4',
                question: 'Comment devrais-je m’alimenter pendant la grossesse ?',
                answer: 'Les femmes enceintes doivent consommer beaucoup de fruits, légumes, protéines, acide folique et fer, et éviter la viande crue, les œufs crus et les produits laitiers non pasteurisés.',
                categoryId: 'nutrition',
              ),
              ContentQuestion(
                id: 'nutrition_5',
                question: 'Quels aliments sont sains pendant la grossesse ?',
                answer: 'Les aliments sains comprennent les fruits et légumes frais (vitamines et fibres), les céréales complètes (glucides complexes et fibres), les viandes maigres, le poisson (en particulier les poissons gras comme le saumon pour les oméga-3), les œufs, les légumineuses et les noix (protéines et graisses saines), les produits laitiers (calcium et vitamine D).',
                categoryId: 'nutrition',
              ),
              ContentQuestion(
                id: 'nutrition_6',
                question: 'Quels aliments sont malsains pendant la grossesse ?',
                answer: 'Les aliments malsains ou à éviter incluent la viande crue, le poisson cru (ex. sushi), les œufs crus, les produits laitiers non pasteurisés (risque de listériose et de toxoplasmose), le foie et ses produits (trop riche en vitamine A), de grandes quantités de caféine (max 200 mg par jour), l’alcool et les poissons à forte teneur en mercure (ex. thon, espadon).',
                categoryId: 'nutrition',
              ),
            ],
          ),
          ContentCategory(
            id: 'exercise',
            title: 'Exercice pendant la grossesse',
            description: 'Pratiques d’exercice sûres et recommandations pour les femmes enceintes.',
            imageUrl: 'assets/images/exercise.png',
            sectionId: 'pregnancy_progress',
            questions: [
              ContentQuestion(
                id: 'exercise_1',
                question: 'L’exercice est-il sûr pendant la grossesse ?',
                answer: 'L’exercice pendant la grossesse n’est pas seulement autorisé, il est également très bénéfique, tant qu’il est adapté aux besoins individuels et au stade de la grossesse.',
                categoryId: 'exercise',
              ),
              ContentQuestion(
                id: 'exercise_2',
                question: 'Quels types d’exercice conviennent pendant la grossesse ?',
                answer: 'Les activités sûres incluent la natation, la marche, le yoga prénatal, la gymnastique légère ou le vélo sur terrain plat.',
                categoryId: 'exercise',
              ),
              ContentQuestion(
                id: 'exercise_3',
                question: 'Quelle quantité d’exercice devrais-je faire à chaque stade de la grossesse ?',
                answer: '1. Premier trimestre (semaines 1-12) :\n• Adapté : activité légère à modérée comme la marche, la natation, le yoga, le Pilates, le vélo sur terrain plat\n• Précaution : éviter la surchauffe, les efforts extrêmes, les sports à risque élevé de chute\n• Non recommandé : sports de contact, musculation intense, activités à fort impact (ex. équitation)\n\n2. Deuxième trimestre (semaines 13-27) :\n• Adapté : yoga prénatal, renforcement modéré (notamment dos et plancher pelvien), aquagym, marche\n• Précaution : pas d’exercices allongée sur le dos après la 20ᵉ semaine (peut gêner le flux sanguin vers l’utérus)\n• Non recommandé : sports avec changements de direction brusques ou risque élevé de blessure\n\n3. Troisième trimestre (semaines 28-40) :\n• Adapté : yoga doux, natation, renforcement léger, exercices du plancher pelvien\n• Précaution : éviter les étirements excessifs car les articulations sont plus relâchées sous l’effet de la relaxine\n• Non recommandé : sports à haut risque de chute ou à fort impact\n\nConseils généraux :\n✔ Écoutez votre corps et réduisez l’intensité si vous vous sentez fatiguée\n✔ Buvez beaucoup d’eau\n✔ Évitez l’exercice en cas de chaleur extrême\n✔ Consultez votre médecin ou sage-femme en cas de doute',
                categoryId: 'exercise',
              ),
            ],
          ),
        ],
      ),

      // SECTION 4: Special Situations & Complications
      ContentSection(
        id: 'complications',
        title: 'Situations spéciales et complications',
        description: 'Informations sur les complications possibles et les situations particulières pendant la grossesse.',
        imageUrl: 'assets/images/complications.png',
        categories: [
          ContentCategory(
            id: 'pregnancy_complications',
            title: 'Complications de la grossesse',
            description: 'Informations sur les complications et affections possibles pendant la grossesse.',
            imageUrl: 'assets/images/complications.png',
            sectionId: 'complications',
            questions: [
              ContentQuestion(
                id: 'pregnancy_complications_1',
                question: 'Quelles sont les affections les plus courantes pendant la grossesse ?',
                answer: 'Les affections courantes pendant la grossesse comprennent la prééclampsie, les infections urinaires et le diabète gestationnel.',
                categoryId: 'pregnancy_complications',
              ),
              ContentQuestion(
                id: 'pregnancy_complications_2',
                question: 'Quels facteurs de risque sont courants ?',
                answer: 'Les facteurs de risque incluent un âge maternel supérieur à 35 ans, les maladies chroniques, le tabagisme, la consommation d’alcool et l’obésité sévère.',
                categoryId: 'pregnancy_complications',
              ),
              ContentQuestion(
                id: 'pregnancy_complications_3',
                question: 'Quelles complications peuvent survenir au début de la grossesse ?',
                answer: 'Fausses couches, grossesse extra-utérine, saignements, hyperémèse gravidique (nausées sévères de grossesse).',
                categoryId: 'pregnancy_complications',
              ),
              ContentQuestion(
                id: 'pregnancy_complications_4',
                question: 'Existe-t-il des traitements médicaux pour les complications de la grossesse ?',
                answer: 'Oui, par exemple soutien hormonal, chirurgie pour grossesse extra-utérine, perfusions pour nausées sévères.',
                categoryId: 'pregnancy_complications',
              ),
              ContentQuestion(
                id: 'pregnancy_complications_5',
                question: 'Quelles maladies peuvent nuire à ma grossesse ?',
                answer: 'La rubéole, la toxoplasmose, la listériose, le virus Zika, le diabète ou les troubles thyroïdiens.',
                categoryId: 'pregnancy_complications',
              ),
            ],
          ),
          ContentCategory(
            id: 'premature_birth',
            title: 'Accouchement prématuré',
            description: 'Informations sur les naissances prématurées, leurs causes et les soins.',
            imageUrl: 'assets/images/premature_birth.png',
            sectionId: 'complications',
            questions: [
              ContentQuestion(
                id: 'premature_birth_1',
                question: 'Qu’est-ce qu’un accouchement prématuré ?',
                answer: 'Un accouchement prématuré survient lorsque la naissance a lieu avant 37 semaines de gestation.',
                categoryId: 'premature_birth',
              ),
              ContentQuestion(
                id: 'premature_birth_2',
                question: 'Quand une naissance est-elle considérée comme prématurée ?',
                answer: 'Une naissance est considérée prématurée si le bébé naît avant d’avoir atteint 37 semaines de grossesse.',
                categoryId: 'premature_birth',
              ),
              ContentQuestion(
                id: 'premature_birth_3',
                question: 'Quelles sont les causes d’un accouchement prématuré ?',
                answer: 'Les causes d’un accouchement prématuré peuvent inclure les infections, les grossesses multiples, les anomalies utérines, le stress, un traumatisme ou des affections maternelles chroniques comme l’hypertension ou le diabète.',
                categoryId: 'premature_birth',
              ),
              ContentQuestion(
                id: 'premature_birth_4',
                question: 'Y a-t-il des signes physiques de travail prématuré ?',
                answer: 'Les signes peuvent inclure des contractions régulières, des saignements vaginaux, des maux de dos, une sensation de pression pelvienne et une fuite de liquide amniotique.',
                categoryId: 'premature_birth',
              ),
              ContentQuestion(
                id: 'premature_birth_5',
                question: 'Quelles sont les possibles conséquences d’un accouchement prématuré pour la mère ?',
                answer: 'Les conséquences pour la mère incluent un risque accru de naissances prématurées récurrentes, un stress psychologique et des complications post-partum.',
                categoryId: 'premature_birth',
              ),
              ContentQuestion(
                id: 'premature_birth_6',
                question: 'Quelles sont les possibles conséquences d’un accouchement prématuré pour le bébé ?',
                answer: 'Les conséquences possibles pour le bébé incluent des problèmes respiratoires, des organes sous-développés, des retards de développement et un risque accru d’infections.',
                categoryId: 'premature_birth',
              ),
              ContentQuestion(
                id: 'premature_birth_7',
                question: 'Peut-on prévenir un accouchement prématuré ?',
                answer: 'Les stratégies de prévention incluent un suivi prénatal régulier, le traitement des infections, le repos, la réduction du stress et la thérapie à la progestérone lorsque c’est médicalement indiqué.',
                categoryId: 'premature_birth',
              ),
              ContentQuestion(
                id: 'premature_birth_8',
                question: 'Que peut faire une femme enceinte pour prévenir un accouchement prématuré ?',
                answer: 'Maintenir une alimentation saine, éviter l’alcool et le tabac, réduire le stress et assister aux rendez-vous médicaux réguliers pour minimiser les risques.',
                categoryId: 'premature_birth',
              ),
              ContentQuestion(
                id: 'premature_birth_9',
                question: 'Problèmes de santé ?',
                answer: 'Les préoccupations de santé incluent des problèmes de développement, des affections respiratoires, une susceptibilité accrue aux infections chez le bébé et un stress psychologique pour la mère.',
                categoryId: 'premature_birth',
              ),
            ],
          ),
          ContentCategory(
            id: 'late_birth',
            title: 'Accouchement post-terme',
            description: 'Informations sur les accouchements post-terme et leurs conséquences potentielles.',
            imageUrl: 'assets/images/late_birth.png',
            sectionId: 'complications',
            questions: [
              ContentQuestion(
                id: 'late_birth_1',
                question: 'Quand une naissance est-elle considérée post-terme ?',
                answer: 'Une naissance est post-terme lorsque la grossesse dépasse 42 semaines.',
                categoryId: 'late_birth',
              ),
              ContentQuestion(
                id: 'late_birth_2',
                question: 'Quels problèmes de santé surviennent en cas d’accouchement post-terme ?',
                answer: 'Les problèmes incluent un risque accru de complications lors de l’accouchement, une privation d’oxygène pour le bébé et un poids de naissance plus important rendant l’accouchement plus difficile.',
                categoryId: 'late_birth',
              ),
            ],
          ),
        ],
      ),

      // SECTION 5: Medical Care
      ContentSection(
        id: 'medical_care',
        title: 'Soins médicaux',
        description: 'Informations sur les examens prénataux et les soins médicaux pendant la grossesse.',
        imageUrl: 'assets/images/prenatal_care.png',
        categories: [
          ContentCategory(
            id: 'prenatal_care',
            title: 'Examens prénataux',
            description: 'Informations sur les examens prénataux pendant la grossesse.',
            imageUrl: 'assets/images/prenatal_care.png',
            sectionId: 'medical_care',
            questions: [
              ContentQuestion(
                id: 'prenatal_care_1',
                question: 'Quels examens spéciaux sont disponibles pendant la grossesse ?',
                answer: 'Les examens spéciaux incluent les échographies, les prises de sang, le test de tolérance au glucose, le dépistage du premier trimestre et les diagnostics prénataux possibles comme le DPNI ou l’amniocentèse.',
                categoryId: 'prenatal_care',
              ),
              ContentQuestion(
                id: 'prenatal_care_2',
                question: 'Qu’est-ce que le diagnostic prénatal ?',
                answer: 'Le diagnostic prénatal comprend des examens spéciaux comme l’amniocentèse pour identifier les risques génétiques.',
                categoryId: 'prenatal_care',
              ),
              ContentQuestion(
                id: 'prenatal_care_3',
                question: 'Quels examens font partie du diagnostic prénatal ?',
                answer: 'Le diagnostic prénatal comprend le dépistage du premier trimestre, le DPNI (test prénatal non invasif), le prélèvement de villosités choriales, l’amniocentèse et l’échographie détaillée.',
                categoryId: 'prenatal_care',
              ),
              ContentQuestion(
                id: 'prenatal_care_4',
                question: 'Qu’est-ce qu’un CTG ?',
                answer: 'Un CTG (cardiotocographie) mesure le rythme cardiaque du bébé et les contractions de la mère à partir de la 26ᵉ semaine de grossesse.',
                categoryId: 'prenatal_care',
              ),
              ContentQuestion(
                id: 'prenatal_care_5',
                question: 'L’échographie est-elle sans danger pendant la grossesse ?',
                answer: 'Une échographie n’est pas nocive et aide à surveiller le développement du bébé.',
                categoryId: 'prenatal_care',
              ),
            ],
          ),
        ],
      ),

      // SECTION 6: Birth and Postpartum Care
      ContentSection(
        id: 'birth_and_postpartum',
        title: 'Accouchement et soins post-partum',
        description: 'Informations sur le travail, la période post-partum et la récupération après.',
        imageUrl: 'assets/images/birth_preparation.png',
        categories: [
          ContentCategory(
            id: 'birth_preparation',
            title: 'Préparation à l’accouchement',
            description: 'Informations sur la préparation à l’accouchement et les différentes méthodes d’accouchement.',
            imageUrl: 'assets/images/birth_preparation.png',
            sectionId: 'birth_and_postpartum',
            questions: [
              ContentQuestion(
                id: 'birth_preparation_1',
                question: 'Quelles méthodes d’accouchement sont disponibles pour moi ?',
                answer: 'Les méthodes d’accouchement incluent l’accouchement vaginal, la césarienne, l’accouchement dans l’eau et les accouchements assistés comme l’extraction par ventouse ou les forceps.',
                categoryId: 'birth_preparation',
              ),
              ContentQuestion(
                id: 'birth_preparation_2',
                question: 'Comment puis-je me préparer mentalement et physiquement à l’accouchement ?',
                answer: 'Les cours de préparation à la naissance, les exercices de respiration, les techniques de relaxation et l’apprentissage de stratégies de gestion de la douleur peuvent être utiles. Partager des expériences avec d’autres mères peut offrir un soutien émotionnel.',
                categoryId: 'birth_preparation',
              ),
              ContentQuestion(
                id: 'birth_preparation_3',
                question: 'Quand dois-je me présenter à l’hôpital pendant la grossesse ?',
                answer: 'En général, vous vous présentez entre la 32ᵉ et la 36ᵉ semaine pour planifier l’accouchement.',
                categoryId: 'birth_preparation',
              ),
              ContentQuestion(
                id: 'birth_preparation_4',
                question: 'Quels objets personnels dois-je apporter à l’hôpital ?',
                answer: 'Il est conseillé d’apporter votre dossier de maternité, votre carte d’assurance maladie, toute ordonnance, des documents personnels et des vêtements confortables.',
                categoryId: 'birth_preparation',
              ),
            ],
          ),
          ContentCategory(
            id: 'postpartum',
            title: 'Post-partum et allaitement',
            description: 'Informations sur la période post-partum et l’allaitement après la naissance.',
            imageUrl: 'assets/images/postpartum.png',
            sectionId: 'birth_and_postpartum',
            questions: [
              ContentQuestion(
                id: 'postpartum_1',
                question: 'Quelle est la durée de la période post-partum et à quoi dois-je faire attention ?',
                answer: 'La période post-partum dure environ six à huit semaines et sert à la récupération physique et émotionnelle. Concentrez-vous sur le repos, une alimentation saine et les soins de la plaie.',
                categoryId: 'postpartum',
              ),
              ContentQuestion(
                id: 'postpartum_2',
                question: 'Quel rôle joue la sage-femme pendant la période post-partum ?',
                answer: 'La sage-femme accompagne la récupération, les soins de la plaie, l’allaitement, les soins au bébé et fournit des conseils précieux pour la nouvelle situation.',
                categoryId: 'postpartum',
              ),
              ContentQuestion(
                id: 'postpartum_3',
                question: 'Comment fonctionne l’allaitement et à quelle fréquence dois-je allaiter mon bébé ?',
                answer: 'L’allaitement fonctionne sur un principe d’offre et de demande : plus vous allaitez, plus le lait est produit. Les nouveau-nés doivent être allaités au moins huit à douze fois en 24 heures, selon leurs besoins.',
                categoryId: 'postpartum',
              ),
              ContentQuestion(
                id: 'postpartum_4',
                question: 'Que puis-je faire si l’allaitement ne se passe pas bien ?',
                answer: 'Concentrez-vous sur une bonne mise au sein, car c’est crucial pour la réussite. Le soutien d’une sage-femme ou d’une consultante en lactation peut être très utile.',
                categoryId: 'postpartum',
              ),
            ],
          ),
          ContentCategory(
            id: 'post_pregnancy',
            title: 'Après la grossesse',
            description: 'Informations sur la période post-naissance et la récupération post-partum.',
            imageUrl: 'assets/images/post_pregnancy.png',
            sectionId: 'birth_and_postpartum',
            questions: [
              ContentQuestion(
                id: 'post_pregnancy_1',
                question: 'Que se passe-t-il après la grossesse ?',
                answer: 'Après la grossesse, l’utérus se rétracte, les hormones se stabilisent et la production de lait commence.',
                categoryId: 'post_pregnancy',
              ),
              ContentQuestion(
                id: 'post_pregnancy_2',
                question: 'Combien de temps dure la récupération physique après l’accouchement ?',
                answer: 'La récupération physique complète peut prendre jusqu’à six semaines ou plus, selon le type d’accouchement (vaginal ou césarienne) et les éventuelles complications.',
                categoryId: 'post_pregnancy',
              ),
              ContentQuestion(
                id: 'post_pregnancy_3',
                question: 'Comment puis-je faire face émotionnellement après la naissance ?',
                answer: 'Prendre du temps pour soi, obtenir suffisamment de repos et de soutien, et parler ouvertement de ses émotions peut aider à gérer le "baby blues" ou d’autres ajustements. Consultez un médecin si vous éprouvez de fortes variations d’humeur.',
                categoryId: 'post_pregnancy',
              ),
            ],
          ),
        ],
      ),

      // SECTION 7: The Newborn Baby
      ContentSection(
        id: 'newborn_care',
        title: 'Le nouveau-né',
        description: 'Informations sur les soins et le soutien du nouveau-né.',
        imageUrl: 'assets/images/newborn.png',
        categories: [
          ContentCategory(
            id: 'newborn',
            title: 'Le nouveau-né',
            description: 'Informations sur les soins et l’accompagnement du nouveau-né.',
            imageUrl: 'assets/images/newborn.png',
            sectionId: 'newborn_care',
            questions: [
              ContentQuestion(
                id: 'newborn_1',
                question: 'À quelle fréquence un nouveau-né doit-il être nourri ?',
                answer: 'Un nouveau-né doit être nourri toutes les 2-3 heures, soit environ 8-12 fois en 24 heures.',
                categoryId: 'newborn',
              ),
              ContentQuestion(
                id: 'newborn_2',
                question: 'Comment puis-je apaiser mon bébé lorsqu’il pleure ?',
                answer: 'Les méthodes pour apaiser incluent le contact physique, des bercements doux ou un chantonnement discret.',
                categoryId: 'newborn',
              ),
              ContentQuestion(
                id: 'newborn_3',
                question: 'Quels sont les rythmes de sommeil normaux pour un nouveau-né ?',
                answer: 'Les nouveau-nés dorment de manière irrégulière, généralement 16-18 heures par jour, en courtes phases de sommeil.',
                categoryId: 'newborn',
              ),
              ContentQuestion(
                id: 'newborn_4',
                question: 'À quelle fréquence dois-je emmener mon nouveau-né chez le pédiatre ?',
                answer: 'Vous devez assister aux examens pédiatriques programmés selon le calendrier standard des consultations.',
                categoryId: 'newborn',
              ),
              ContentQuestion(
                id: 'newborn_5',
                question: 'Quels examens sont importants au cours des premiers mois ?',
                answer: 'U1, immédiatement après la naissance, vérifie la respiration, le rythme cardiaque, le tonus musculaire, les réflexes, la couleur de la peau (score d’Apgar) et les soins initiaux.\n\nU2 (3-10 jours) : examen physique complet, bilan des organes et des réflexes, dépistage métabolique du nouveau-né.\n\nU4 (3-4 mois) : évalue le développement physique et moteur, le statut vaccinal et inclut les premières vaccinations.',
                categoryId: 'newborn',
              ),
            ],
          ),
        ],
      ),

      // SECTION 8: Guidelines
      ContentSection(
        id: 'guidelines',
        title: 'Recommandations',
        description: 'Lignes directrices et recommandations pour la grossesse.',
        imageUrl: 'assets/images/dont_dos.png',
        categories: [
          ContentCategory(
            id: 'dont_dos',
            title: 'À ne pas faire',
            description: 'Activités à éviter pendant la grossesse.',
            imageUrl: 'assets/images/dont_dos.png',
            sectionId: 'guidelines',
            questions: [
              ContentQuestion(
                id: 'dont_dos_1',
                question: 'Quelles sont les choses à ne pas faire une fois que vous savez que vous êtes enceinte ?',
                answer: 'Les femmes enceintes doivent éviter l’alcool, les drogues, la viande et le poisson crus, le port de charges lourdes et la consommation excessive de caféine.',
                categoryId: 'dont_dos',
              ),
            ],
          ),
        ],
      ),
    ]);
  }
}