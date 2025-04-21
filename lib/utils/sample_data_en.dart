// utils/sample_data_en.dart
import '../models/content_model.dart';

class SampleDataEN {
  static ContentData getSampleContent() {
    return ContentData(sections: [
      // SECTION 1: Basics of Pregnancy
      ContentSection(
        id: 'basics',
        title: 'Introduction and Basics',
        description: 'Basic information about pregnancy, gynecologists, and the process.',
        imageUrl: 'assets/images/pregnancy_basics.png',
        categories: [
          ContentCategory(
            id: 'gynecologist',
            title: 'Roles of a Gynecologist',
            description: 'Information about the gynecologist and gynecological examinations.',
            imageUrl: 'assets/images/gynecologist.png',
            sectionId: 'basics',
            questions: [
              ContentQuestion(
                id: 'gynecologist_1',
                question: 'What is the role of a gynecologist?',
                answer: 'A gynecologist cares for the reproductive health of women at every stage of life. Their main responsibilities include:\n\n• Preventive care: cancer screening, ultrasound, gynecological exams\n• Pregnancy & childbirth: prenatal care, ultrasound, delivery, postpartum follow-up\n• Treatment of conditions: hormonal disorders, infections, endometriosis, fibroids\n• Contraception & fertility counseling\n• Support during menopause\n• Psychosomatic care\n• Surgeries: cesarean section, sterilization, tumor removal\n\nGynecologists often accompany women medically throughout their lives.',
                categoryId: 'gynecologist',
              ),
              ContentQuestion(
                id: 'gynecologist_2',
                question: 'What does the first prenatal visit include?',
                answer: 'The first prenatal visit includes:\n\n• A detailed medical history\n• Recording weight, height, and blood pressure\n• A comprehensive clinical examination\n• Ultrasound examination (if technically possible) to assess internal organs, position, and pregnancy development.',
                categoryId: 'gynecologist',
              ),
              ContentQuestion(
                id: 'gynecologist_3',
                question: 'Which questions should I ask my doctor as a pregnant woman?',
                answer: '1. Is the pregnancy developing normally? This question confirms the regular progression of the pregnancy.\n\n2. What should I pay attention to during pregnancy? This provides personalized advice from the doctor.\n\n3. What should I avoid doing while pregnant? This helps you understand any specific restrictions based on your individual pregnancy.',
                categoryId: 'gynecologist',
              ),
            ],
          ),
          ContentCategory(
            id: 'pregnancy_basics',
            title: 'Basics of Pregnancy',
            description: 'What is pregnancy and how does it work?',
            imageUrl: 'assets/images/pregnancy_basics.png',
            sectionId: 'basics',
            questions: [
              ContentQuestion(
                id: 'pregnancy_basics_1',
                question: 'What is pregnancy?',
                answer: 'Pregnancy begins when a sperm fertilizes an egg. The fertilized egg implants in the uterus and starts to grow. It gradually develops into an embryo and later into a baby. The mother’s body supplies the baby with all it needs through the umbilical cord. After around nine months, the baby is ready to be born.',
                categoryId: 'pregnancy_basics',
              ),
              ContentQuestion(
                id: 'pregnancy_basics_2',
                question: 'How does pregnancy work?',
                answer: 'During pregnancy, a woman’s hormone levels change dramatically. Key hormones like hCG, progesterone, and estrogen rise significantly. They prepare the body for the baby. The uterus grows along with the baby. The placenta provides the baby with essential nutrients. The baby develops month by month from a cluster of cells into a fully formed little human.',
                categoryId: 'pregnancy_basics',
              ),
              ContentQuestion(
                id: 'pregnancy_basics_3',
                question: 'How and when can I tell I am pregnant?',
                answer: 'Pregnancy is often detected by the following signs:\n\n• Missed period (especially with a regular cycle)\n• Nausea and vomiting, especially in the morning\n• Fatigue and increased need for sleep\n• Frequent urination\n• Breast tenderness\n• Sometimes light spotting at implantation\n\nAn over-the-counter pregnancy test can be taken from the first day of the missed period, preferably in the morning when urine is more concentrated.',
                categoryId: 'pregnancy_basics',
              ),
            ],
          ),
          ContentCategory(
            id: 'pregnancy_stages',
            title: 'Pregnancy Stages',
            description: 'Information about the different stages of pregnancy.',
            imageUrl: 'assets/images/pregnancy_stages.png',
            sectionId: 'basics',
            questions: [
              ContentQuestion(
                id: 'pregnancy_stages_1',
                question: 'How long does a pregnancy last?',
                answer: 'A pregnancy lasts about 40 weeks (gestational weeks), sometimes up to 42 weeks. This corresponds to about 9-10 months, calculated from the first day of the last menstrual period.',
                categoryId: 'pregnancy_stages',
              ),
              ContentQuestion(
                id: 'pregnancy_stages_2',
                question: 'What is a trimester?',
                answer: 'A trimester refers to one of the three phases of pregnancy, each lasting about three months.\n\n1. First Trimester (weeks 1-12): Fertilization occurs and early development of the embryo and organs begin. Symptoms like nausea and fatigue may appear.\n\n2. Second Trimester (weeks 13-26): The fetus continues to grow, and many early discomforts subside. The baby bump becomes visible.\n\n3. Third Trimester (weeks 27-40): The baby grows further and the mother’s body prepares for birth. Physical discomforts such as back pain or sleep problems may increase.',
                categoryId: 'pregnancy_stages',
              ),
              ContentQuestion(
                id: 'pregnancy_stages_3',
                question: 'How do examinations differ by trimester?',
                answer: '1. First Trimester (weeks 1-12):\n• Initial exam: blood pressure, weight, urine, blood tests (Rh factor, infections)\n• Ultrasound to confirm pregnancy\n• Optional tests: nuchal translucency measurement, first-trimester screening, non-invasive prenatal testing (NIPT)\n\n2. Second Trimester (weeks 13-28):\n• Check-ups every 4 weeks: blood pressure, weight, urine, growth monitoring\n• 20-22 weeks: detailed ultrasound\n• 24-28 weeks: glucose tolerance test to exclude diabetes\n\n3. Third Trimester (weeks 29-40):\n• From week 29, check-ups every 3 weeks, from week 36 weekly\n• CTG monitoring, assessment of fetal position\n• From week 40, close monitoring until birth\n\nAll examinations aim to monitor the health of mother and child.',
                categoryId: 'pregnancy_stages',
              ),
              ContentQuestion(
                id: 'pregnancy_stages_4',
                question: 'What physical changes can be expected during pregnancy?',
                answer: 'The body prepares for birth: the uterus grows, hormones shift, and weight increases. Typical changes by trimester:\n\n1. First Trimester (weeks 1-12): nausea, fatigue, breast tenderness.\n\n2. Second Trimester (weeks 13-28): growing belly, fewer discomforts, feeling fetal movements.\n\n3. Third Trimester (weeks 29-40): heavier belly, back pain, frequent urination, preparing for birth.',
                categoryId: 'pregnancy_stages',
              ),
            ],
          ),
        ],
      ),

      // SECTION 2: Family Planning and Preparation
      ContentSection(
        id: 'planning',
        title: 'Family Planning and Preparation',
        description: 'Information on preparing and planning for a pregnancy.',
        imageUrl: 'assets/images/pre_pregnancy.png',
        categories: [
          ContentCategory(
            id: 'pre_pregnancy',
            title: 'Pre-Pregnancy',
            description: 'Information on preparing and planning for a pregnancy.',
            imageUrl: 'assets/images/pre_pregnancy.png',
            sectionId: 'planning',
            questions: [
              ContentQuestion(
                id: 'pre_pregnancy_1',
                question: 'What should I consider before becoming pregnant?',
                answer: 'Before pregnancy, the woman’s body prepares for ovulation and the uterine lining builds up. To increase your chances of a healthy pregnancy, consider the following:\n\n• Healthy diet rich in fruits, vegetables, and whole grains\n• Regular exercise without overexertion\n• Avoid alcohol, nicotine, and other drugs\n• Take folic acid before pregnancy\n• Routine check-ups with your gynecologist\n• Verify immunity to measles and chickenpox',
                categoryId: 'pre_pregnancy',
              ),
              ContentQuestion(
                id: 'pre_pregnancy_2',
                question: 'Which preconception screenings should I have done?',
                answer: 'Before pregnancy, you should undergo the following screenings to rule out diseases and identify risks:\n\n1. General check-up: blood pressure, blood count, thyroid function (TSH)\n2. Gynecological check-up: smear test, ultrasound, possible cycle monitoring\n3. Blood tests: measles, chickenpox, toxoplasmosis, hepatitis B/C, HIV\n4. Vaccinations: measles, mumps, rubella, chickenpox, tetanus, pertussis, flu\n5. Dental check-up: examine dental health',
                categoryId: 'pre_pregnancy',
              ),
              ContentQuestion(
                id: 'pre_pregnancy_3',
                question: 'How can I optimize my lifestyle to improve fertility?',
                answer: 'Before and especially during pregnancy, pay attention to:\n\n• Healthy diet with fruits, vegetables, whole grains, healthy fats (e.g., avocado), and proteins\n• Healthy body weight (BMI 18.5-24.9)\n• Moderate exercise (regular but not excessive)\n• Stress reduction (meditation, yoga, acupuncture)\n• Avoid harmful substances (no nicotine, alcohol; limit caffeine)\n• Minimize environmental toxins\n• Adequate sleep (7-9 hours)',
                categoryId: 'pre_pregnancy',
              ),
              ContentQuestion(
                id: 'pre_pregnancy_4',
                question: 'Which vitamins and nutrients should I take before pregnancy?',
                answer: 'Important vitamins and nutrients for pregnancy include:\n\n• Folic acid: 400-800 μg (at least 3 months prior)\n• Vitamin D: 800-1000 IU daily\n• Omega-3 fatty acids: 500-1000 mg EPA/DHA\n• Iron: as needed based on blood values\n• Zinc & vitamin E: for egg quality\n• Vitamin C: supports iron absorption\n• Iodine: 150-200 μg daily\n\nTake these supplements in consultation with your doctor.',
                categoryId: 'pre_pregnancy',
              ),
              ContentQuestion(
                id: 'pre_pregnancy_5',
                question: 'What role does the partner play in preparing for pregnancy?',
                answer: 'The following factors can affect pregnancy:\n\n• Smoking and alcohol reduce sperm quality\n• Stress can decrease sperm production\n• Balanced diet improves fertility\n• Heat exposure (e.g., sauna, laptop on lap) can damage sperm\n• Regular exercise promotes hormonal balance\n\nReview your lifestyle together and make improvements if necessary.',
                categoryId: 'pre_pregnancy',
              ),
            ],
          ),
          ContentCategory(
            id: 'fertility',
            title: 'Fertility and Contraception',
            description: 'Information on fertility, contraceptive methods, and family planning.',
            imageUrl: 'assets/images/fertility.png',
            sectionId: 'planning',
            questions: [
              ContentQuestion(
                id: 'fertility_1',
                question: 'What is fertility?',
                answer: 'Fertility describes the ability to conceive and carry a pregnancy to term.',
                categoryId: 'fertility',
              ),
              ContentQuestion(
                id: 'fertility_2',
                question: 'How does the female cycle work and when are the fertile days?',
                answer: 'The cycle starts with menstruation and lasts about 28 days. The fertile days are around ovulation, usually between days 12 and 16, when the chance of pregnancy is highest.',
                categoryId: 'fertility',
              ),
              ContentQuestion(
                id: 'fertility_3',
                question: 'What factors influence fertility?',
                answer: 'Various factors can influence fertility:\n\n• Stress disrupts hormones – relaxation and breaks help\n• Overweight or underweight affects the cycle – a healthy diet balances it\n• Smoking lowers fertility – quitting improves chances\n• Alcohol can reduce egg quality – better to avoid it\n• Age matters – earlier is better',
                categoryId: 'fertility',
              ),
              ContentQuestion(
                id: 'fertility_4',
                question: 'Why use contraception?',
                answer: 'Contraception is used to prevent unintended pregnancies and sexually transmitted infections.',
                categoryId: 'fertility',
              ),
              ContentQuestion(
                id: 'fertility_5',
                question: 'What different contraceptive methods are available and what are their pros and cons?',
                answer: 'Contraceptive methods like condoms, the pill, or IUDs each have specific advantages and disadvantages, such as infection protection, effectiveness, or side effects.',
                categoryId: 'fertility',
              ),
            ],
          ),
        ],
      ),

      // SECTION 3: Pregnancy Progress
      ContentSection(
        id: 'pregnancy_progress',
        title: 'Pregnancy Progress',
        description: 'Information about the course of pregnancy and baby development.',
        imageUrl: 'assets/images/pregnancy_stages.png',
        categories: [
          ContentCategory(
            id: 'pregnancy_check',
            title: 'Pregnancy Detection',
            description: 'Information on detecting and confirming pregnancy.',
            imageUrl: 'assets/images/pregnancy_check.png',
            sectionId: 'pregnancy_progress',
            questions: [
              ContentQuestion(
                id: 'pregnancy_check_1',
                question: 'How can I detect pregnancy myself?',
                answer: '• Missed period – often the first sign, especially with a regular cycle\n• Early symptoms – nausea, fatigue, breast tenderness, frequent urination can be indicators\n• Pregnancy test – a home urine test from a pharmacy gives results in minutes; best taken in the morning',
                categoryId: 'pregnancy_check',
              ),
              ContentQuestion(
                id: 'pregnancy_check_2',
                question: 'When should I have a pregnancy confirmed by a doctor?',
                answer: 'The ideal time depends on how far along you are and how certain you want to be:\n\n1. Early detection (from missed period):\n- Urine test: home pregnancy tests measure hCG in urine from the first missed period day.\n- Doctor visit: for confirmation or uncertainty, a blood test detects pregnancy earlier (about 7-10 days after ovulation).\n\n2. First prenatal appointment (around 6-8 weeks): schedule 2-3 weeks after missed period. An ultrasound can confirm pregnancy by visualizing the gestational sac or embryo; a heartbeat is often visible from week 6.',
                categoryId: 'pregnancy_check',
              ),
              ContentQuestion(
                id: 'pregnancy_check_3',
                question: 'How does the doctor assess pregnancy development?',
                answer: 'Through symptoms like missed period, nausea, breast tenderness. Confirmation via pregnancy test (hCG detection) and ultrasound.',
                categoryId: 'pregnancy_check',
              ),
              ContentQuestion(
                id: 'pregnancy_check_4',
                question: 'What signs can occur in early pregnancy?',
                answer: 'Nausea, fatigue, breast tenderness, frequent urination, mild abdominal cramps.',
                categoryId: 'pregnancy_check',
              ),
              ContentQuestion(
                id: 'pregnancy_check_5',
                question: 'Which early pregnancy symptoms should prompt a doctor visit?',
                answer: 'Severe pain, bleeding, high fever, dizziness, sudden intense nausea.',
                categoryId: 'pregnancy_check',
              ),
            ],
          ),
          ContentCategory(
            id: 'nutrition',
            title: 'Nutrition During Pregnancy',
            description: 'Guidelines for proper nutrition for mother and baby during pregnancy.',
            imageUrl: 'assets/images/nutrition.png',
            sectionId: 'pregnancy_progress',
            questions: [
              ContentQuestion(
                id: 'nutrition_1',
                question: 'Why is nutrition important during pregnancy?',
                answer: 'Proper nutrition during pregnancy ensures the baby gets essential nutrients for development and helps maintain maternal health. It can reduce the risk of birth defects and complications.',
                categoryId: 'nutrition',
              ),
              ContentQuestion(
                id: 'nutrition_2',
                question: 'Which foods should be avoided during pregnancy?',
                answer: 'Avoid raw or undercooked meat, high-mercury fish, unpasteurized dairy products, raw eggs, unwashed fruits and vegetables, and excessive caffeine.',
                categoryId: 'nutrition',
              ),
              ContentQuestion(
                id: 'nutrition_3',
                question: 'Which nutrients are especially important during pregnancy?',
                answer: 'Key nutrients include folic acid, iron, calcium, vitamin D, protein, and omega-3 fatty acids. They support fetal development and the changing maternal body.',
                categoryId: 'nutrition',
              ),
              ContentQuestion(
                id: 'nutrition_4',
                question: 'How should I eat during pregnancy?',
                answer: 'Pregnant women should eat plenty of fruits, vegetables, protein, folic acid, and iron, and avoid raw meat, raw eggs, and unpasteurized dairy.',
                categoryId: 'nutrition',
              ),
              ContentQuestion(
                id: 'nutrition_5',
                question: 'Which foods are healthy during pregnancy?',
                answer: 'Healthy foods include fresh fruits and vegetables (vitamins and fiber), whole grains (complex carbs and fiber), lean meats, fish (especially fatty fish like salmon for omega-3), eggs, legumes and nuts (protein and healthy fats), dairy (calcium and vitamin D).',
                categoryId: 'nutrition',
              ),
              ContentQuestion(
                id: 'nutrition_6',
                question: 'Which foods are unhealthy during pregnancy?',
                answer: 'Unhealthy or avoidable foods include raw meat, raw fish (e.g., sushi), raw eggs, unpasteurized dairy (risk of listeriosis and toxoplasmosis), liver and liver products (high vitamin A), large amounts of caffeine (max 200 mg per day), alcohol, and high-mercury fish (e.g., tuna, swordfish).',
                categoryId: 'nutrition',
              ),
            ],
          ),
          ContentCategory(
            id: 'exercise',
            title: 'Exercise During Pregnancy',
            description: 'Safe exercise practices and recommendations for pregnant women.',
            imageUrl: 'assets/images/exercise.png',
            sectionId: 'pregnancy_progress',
            questions: [
              ContentQuestion(
                id: 'exercise_1',
                question: 'Is exercise safe during pregnancy?',
                answer: 'Exercise during pregnancy is not only allowed but also very healthy, as long as it is adapted to individual needs and the pregnancy stage.',
                categoryId: 'exercise',
              ),
              ContentQuestion(
                id: 'exercise_2',
                question: 'Which types of exercise are suitable during pregnancy?',
                answer: 'Safe activities include swimming, walking, prenatal yoga, light gymnastics, or cycling on flat terrain.',
                categoryId: 'exercise',
              ),
              ContentQuestion(
                id: 'exercise_3',
                question: 'How much exercise should I do at each stage of pregnancy?',
                answer: '1. First Trimester (weeks 1-12):\n• Suitable: light to moderate activity like walking, swimming, yoga, Pilates, cycling on flat ground\n• Caution: avoid overheating, extreme exertion, high-fall-risk sports\n• Not recommended: contact sports, intense weightlifting, high-impact activities (e.g., horseback riding)\n\n2. Second Trimester (weeks 13-27):\n• Suitable: prenatal yoga, moderate strength training (especially back and pelvic floor), water aerobics, walking\n• Caution: no exercises lying on your back after week 20 (can impede blood flow to uterus)\n• Not recommended: sports with sudden direction changes or high injury risk\n\n3. Third Trimester (weeks 28-40):\n• Suitable: gentle yoga, swimming, light strength training, pelvic floor exercises\n• Caution: avoid excessive stretching as joints are more relaxed due to relaxin hormone\n• Not recommended: high-fall-risk or high-impact sports\n\nGeneral tips:\n✔ Listen to your body and reduce intensity if you feel tired\n✔ Drink plenty of water\n✔ Avoid exercising in extreme heat\n✔ Consult your doctor or midwife if in doubt',
                categoryId: 'exercise',
              ),
            ],
          ),
        ],
      ),

      // SECTION 4: Special Situations & Complications
      ContentSection(
        id: 'complications',
        title: 'Special Situations & Complications',
        description: 'Information on possible complications and special situations during pregnancy.',
        imageUrl: 'assets/images/complications.png',
        categories: [
          ContentCategory(
            id: 'pregnancy_complications',
            title: 'Pregnancy Complications',
            description: 'Information on possible complications and conditions during pregnancy.',
            imageUrl: 'assets/images/complications.png',
            sectionId: 'complications',
            questions: [
              ContentQuestion(
                id: 'pregnancy_complications_1',
                question: 'What are the most common conditions during pregnancy?',
                answer: 'Common conditions during pregnancy include preeclampsia, urinary tract infections, and gestational diabetes.',
                categoryId: 'pregnancy_complications',
              ),
              ContentQuestion(
                id: 'pregnancy_complications_2',
                question: 'Which risk factors are common?',
                answer: 'Risk factors include maternal age over 35, chronic diseases, smoking, alcohol use, and severe overweight.',
                categoryId: 'pregnancy_complications',
              ),
              ContentQuestion(
                id: 'pregnancy_complications_3',
                question: 'What complications can occur in early pregnancy?',
                answer: 'Miscarriage, ectopic pregnancy, bleeding, hyperemesis gravidarum (severe pregnancy nausea).',
                categoryId: 'pregnancy_complications',
              ),
              ContentQuestion(
                id: 'pregnancy_complications_4',
                question: 'Are there medical treatments for pregnancy complications?',
                answer: 'Yes, e.g., hormonal support, surgery for ectopic pregnancy, intravenous fluids for severe nausea.',
                categoryId: 'pregnancy_complications',
              ),
              ContentQuestion(
                id: 'pregnancy_complications_5',
                question: 'Which illnesses can harm my pregnancy?',
                answer: 'Rubella, toxoplasmosis, listeriosis, Zika virus, diabetes, or thyroid disorders.',
                categoryId: 'pregnancy_complications',
              ),
            ],
          ),
          ContentCategory(
            id: 'premature_birth',
            title: 'Preterm Birth',
            description: 'Information on preterm births, causes, and care.',
            imageUrl: 'assets/images/premature_birth.png',
            sectionId: 'complications',
            questions: [
              ContentQuestion(
                id: 'premature_birth_1',
                question: 'What is a preterm birth?',
                answer: 'A preterm birth is when birth occurs before 37 weeks of gestation.',
                categoryId: 'premature_birth',
              ),
              ContentQuestion(
                id: 'premature_birth_2',
                question: 'When is a birth considered preterm?',
                answer: 'A birth is preterm if the baby is born before completing 37 weeks of pregnancy.',
                categoryId: 'premature_birth',
              ),
              ContentQuestion(
                id: 'premature_birth_3',
                question: 'What causes preterm birth?',
                answer: 'Causes of preterm birth can include infections, multiple pregnancies, uterine abnormalities, stress, trauma, or chronic maternal conditions like hypertension or diabetes.',
                categoryId: 'premature_birth',
              ),
              ContentQuestion(
                id: 'premature_birth_4',
                question: 'Are there physical signs of preterm labor?',
                answer: 'Signs can include regular contractions, vaginal bleeding, back pain, pelvic pressure, and leaking amniotic fluid.',
                categoryId: 'premature_birth',
              ),
              ContentQuestion(
                id: 'premature_birth_5',
                question: 'What are possible consequences of preterm birth for the mother?',
                answer: 'Consequences for the mother include an increased risk of repeat preterm births, psychological stress, and postpartum complications.',
                categoryId: 'premature_birth',
              ),
              ContentQuestion(
                id: 'premature_birth_6',
                question: 'What are possible consequences of preterm birth for the baby?',
                answer: 'Potential consequences for the baby include respiratory problems, underdeveloped organs, developmental delays, and higher risk of infections.',
                categoryId: 'premature_birth',
              ),
              ContentQuestion(
                id: 'premature_birth_7',
                question: 'Can preterm birth be prevented?',
                answer: 'Prevention strategies include regular prenatal care, treating infections, rest, stress reduction, and progesterone therapy when medically indicated.',
                categoryId: 'premature_birth',
              ),
              ContentQuestion(
                id: 'premature_birth_8',
                question: 'What can a pregnant woman do to prevent preterm birth?',
                answer: 'Maintain a healthy diet, avoid alcohol and cigarettes, reduce stress, and attend regular medical appointments to minimize risk.',
                categoryId: 'premature_birth',
              ),
              ContentQuestion(
                id: 'premature_birth_9',
                question: 'Health concerns?',
                answer: 'Health concerns include developmental issues, respiratory conditions, increased susceptibility to infections in the baby, and psychological stress for the mother.',
                categoryId: 'premature_birth',
              ),
            ],
          ),
          ContentCategory(
            id: 'late_birth',
            title: 'Post-term Birth',
            description: 'Information on post-term births and potential consequences.',
            imageUrl: 'assets/images/late_birth.png',
            sectionId: 'complications',
            questions: [
              ContentQuestion(
                id: 'late_birth_1',
                question: 'When is a birth considered post-term?',
                answer: 'A birth is post-term when pregnancy exceeds 42 weeks.',
                categoryId: 'late_birth',
              ),
              ContentQuestion(
                id: 'late_birth_2',
                question: 'What health concerns arise with post-term birth?',
                answer: 'Concerns include higher risk of delivery complications, oxygen deprivation for the baby, and larger birth weight making delivery more difficult.',
                categoryId: 'late_birth',
              ),
            ],
          ),
        ],
      ),

      // SECTION 5: Medical Care
      ContentSection(
        id: 'medical_care',
        title: 'Medical Care',
        description: 'Information on prenatal check-ups and medical care during pregnancy.',
        imageUrl: 'assets/images/prenatal_care.png',
        categories: [
          ContentCategory(
            id: 'prenatal_care',
            title: 'Prenatal Check-ups',
            description: 'Information on prenatal exams during pregnancy.',
            imageUrl: 'assets/images/prenatal_care.png',
            sectionId: 'medical_care',
            questions: [
              ContentQuestion(
                id: 'prenatal_care_1',
                question: 'What special examinations are available during pregnancy?',
                answer: 'Special examinations include ultrasounds, blood tests, the glucose tolerance test, first-trimester screening, and possible prenatal diagnostics like NIPT or amniocentesis.',
                categoryId: 'prenatal_care',
              ),
              ContentQuestion(
                id: 'prenatal_care_2',
                question: 'What is prenatal diagnostics?',
                answer: 'Prenatal diagnostics includes special tests like amniocentesis to identify genetic risks.',
                categoryId: 'prenatal_care',
              ),
              ContentQuestion(
                id: 'prenatal_care_3',
                question: 'Which exams are part of prenatal diagnostics?',
                answer: 'Prenatal diagnostics includes first-trimester screening, NIPT (non-invasive prenatal testing), chorionic villus sampling, amniocentesis, and detailed ultrasound.',
                categoryId: 'prenatal_care',
              ),
              ContentQuestion(
                id: 'prenatal_care_4',
                question: 'What is a CTG?',
                answer: 'A CTG (cardiotocography) measures the baby’s heart rate and the mother’s contractions from the 26th week of pregnancy.',
                categoryId: 'prenatal_care',
              ),
              ContentQuestion(
                id: 'prenatal_care_5',
                question: 'Is ultrasound safe during pregnancy?',
                answer: 'An ultrasound is not harmful and helps monitor the baby’s development.',
                categoryId: 'prenatal_care',
              ),
            ],
          ),
        ],
      ),

      // SECTION 6: Birth and Postpartum Care
      ContentSection(
        id: 'birth_and_postpartum',
        title: 'Birth and Postpartum Care',
        description: 'Information on labor, the postpartum period, and recovery afterwards.',
        imageUrl: 'assets/images/birth_preparation.png',
        categories: [
          ContentCategory(
            id: 'birth_preparation',
            title: 'Birth Preparation',
            description: 'Information on preparing for childbirth and different delivery methods.',
            imageUrl: 'assets/images/birth_preparation.png',
            sectionId: 'birth_and_postpartum',
            questions: [
              ContentQuestion(
                id: 'birth_preparation_1',
                question: 'Which delivery methods are available to me?',
                answer: 'Delivery methods include vaginal birth, cesarean section, water birth, and assisted deliveries such as vacuum extraction or forceps.',
                categoryId: 'birth_preparation',
              ),
              ContentQuestion(
                id: 'birth_preparation_2',
                question: 'How can I prepare mentally and physically for childbirth?',
                answer: 'Childbirth classes, breathing exercises, relaxation techniques, and learning pain management strategies can be helpful. Sharing experiences with other mothers can provide emotional support.',
                categoryId: 'birth_preparation',
              ),
              ContentQuestion(
                id: 'birth_preparation_3',
                question: 'When should I check in at the hospital during pregnancy?',
                answer: 'Typically you check in between weeks 32 and 36 to plan the delivery.',
                categoryId: 'birth_preparation',
              ),
              ContentQuestion(
                id: 'birth_preparation_4',
                question: 'What personal items should I bring to the hospital?',
                answer: 'It is advisable to bring your maternity record, health insurance card, any referrals, personal documents, and comfortable clothing.',
                categoryId: 'birth_preparation',
              ),
            ],
          ),
          ContentCategory(
            id: 'postpartum',
            title: 'Postpartum and Breastfeeding',
            description: 'Information on the postpartum period and breastfeeding after birth.',
            imageUrl: 'assets/images/postpartum.png',
            sectionId: 'birth_and_postpartum',
            questions: [
              ContentQuestion(
                id: 'postpartum_1',
                question: 'How long is the postpartum period and what should I pay attention to?',
                answer: 'The postpartum period lasts about six to eight weeks and is for physical and emotional recovery. Focus on rest, healthy nutrition, and wound care.',
                categoryId: 'postpartum',
              ),
              ContentQuestion(
                id: 'postpartum_2',
                question: 'What role does the midwife play during the postpartum period?',
                answer: 'The midwife supports recovery, wound care, breastfeeding, baby care, and provides valuable tips for the new situation.',
                categoryId: 'postpartum',
              ),
              ContentQuestion(
                id: 'postpartum_3',
                question: 'How does breastfeeding work and how often should I breastfeed my baby?',
                answer: 'Breastfeeding works on supply and demand: the more you nurse, the more milk is produced. Newborns should breastfeed at least eight to twelve times in 24 hours, depending on their needs.',
                categoryId: 'postpartum',
              ),
              ContentQuestion(
                id: 'postpartum_4',
                question: 'What can I do if breastfeeding is not going well?',
                answer: 'Focus on proper latch technique, as it is crucial for success. Support from a midwife or lactation consultant can be very helpful.',
                categoryId: 'postpartum',
              ),
            ],
          ),
          ContentCategory(
            id: 'post_pregnancy',
            title: 'After Pregnancy',
            description: 'Information on the period after birth and postpartum recovery.',
            imageUrl: 'assets/images/post_pregnancy.png',
            sectionId: 'birth_and_postpartum',
            questions: [
              ContentQuestion(
                id: 'post_pregnancy_1',
                question: 'What happens after pregnancy?',
                answer: 'After pregnancy, the uterus involutes, hormones stabilize, and milk production begins.',
                categoryId: 'post_pregnancy',
              ),
              ContentQuestion(
                id: 'post_pregnancy_2',
                question: 'How long does physical recovery after birth take?',
                answer: 'Complete physical recovery can take up to six weeks or longer, depending on delivery type (vaginal or cesarean) and any complications.',
                categoryId: 'post_pregnancy',
              ),
              ContentQuestion(
                id: 'post_pregnancy_3',
                question: 'How can I cope emotionally after birth?',
                answer: 'Taking time for yourself, getting enough rest and support, and talking openly about emotions can help manage the "baby blues" or other adjustments. Consult a doctor if you experience severe mood swings.',
                categoryId: 'post_pregnancy',
              ),
            ],
          ),
        ],
      ),

      // SECTION 7: The Newborn Baby
      ContentSection(
        id: 'newborn_care',
        title: 'The Newborn Baby',
        description: 'Information on care and support for the newborn.',
        imageUrl: 'assets/images/newborn.png',
        categories: [
          ContentCategory(
            id: 'newborn',
            title: 'The Newborn',
            description: 'Information on caring for and supporting the newborn.',
            imageUrl: 'assets/images/newborn.png',
            sectionId: 'newborn_care',
            questions: [
              ContentQuestion(
                id: 'newborn_1',
                question: 'How often does a newborn need to be fed?',
                answer: 'A newborn should be fed every 2-3 hours, about 8-12 times in 24 hours.',
                categoryId: 'newborn',
              ),
              ContentQuestion(
                id: 'newborn_2',
                question: 'How can I soothe my baby when they cry?',
                answer: 'Soothing methods include physical contact, gentle rocking, or quiet humming.',
                categoryId: 'newborn',
              ),
              ContentQuestion(
                id: 'newborn_3',
                question: 'What sleep patterns are normal for a newborn?',
                answer: 'Newborns sleep irregularly, typically 16-18 hours per day, in short sleep phases.',
                categoryId: 'newborn',
              ),
              ContentQuestion(
                id: 'newborn_4',
                question: 'How often should I take my newborn to the pediatrician?',
                answer: 'You should attend scheduled pediatric check-ups according to the standard examination schedule.',
                categoryId: 'newborn',
              ),
              ContentQuestion(
                id: 'newborn_5',
                question: 'Which exams are important in the first months?',
                answer: 'U1, immediately after birth, checks breathing, heartbeat, muscle tone, reflexes, skin color (Apgar score), and initial care.\n\nU2 (3-10 days): thorough physical exam, organ and reflex check, newborn metabolic screening.\n\nU4 (3-4 months): assesses physical and motor development, vaccination status, and includes first immunizations.',
                categoryId: 'newborn',
              ),
            ],
          ),
        ],
      ),

      // SECTION 8: Guidelines
      ContentSection(
        id: 'guidelines',
        title: 'Guidelines',
        description: 'Guidelines and recommendations for pregnancy.',
        imageUrl: 'assets/images/dont_dos.png',
        categories: [
          ContentCategory(
            id: 'dont_dos',
            title: 'Guidelines',
            description: 'Guidelines and activities to avoid during pregnancy.',
            imageUrl: 'assets/images/dont_dos.png',
            sectionId: 'guidelines',
            questions: [
              ContentQuestion(
                id: 'dont_dos_1',
                question: 'What are the don’ts once you know you are pregnant?',
                answer: 'Pregnant women should avoid alcohol, drugs, raw meat and fish, lifting heavy objects, and excessive caffeine consumption.',
                categoryId: 'dont_dos',
              ),
            ],
          ),
        ],
      ),
    ]);
  }
}
