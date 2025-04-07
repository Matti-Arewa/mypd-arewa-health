// utils/sample_data_en.dart
import '../models/content_model.dart';

class SampleDataEN {
  static ContentData getSampleContent() {
    return ContentData(categories: [
      // Original categories
      ContentCategory(
        id: 'premature_birth',
        title: 'Premature Birth',
        description: 'Information about premature births, causes, and care.',
        imageUrl: 'assets/images/premature_birth.png',
        questions: [
          ContentQuestion(
            id: 'premature_birth_1',
            question: 'What is a premature birth?',
            answer: 'A premature birth is a birth that occurs before the 37th week of pregnancy (gestational week).',
            categoryId: 'premature_birth',
          ),
          ContentQuestion(
            id: 'premature_birth_2',
            question: 'When is a birth defined as a premature birth?',
            answer: 'A birth is defined as a premature birth when the child is born before the completion of the 37th gestational week.',
            categoryId: 'premature_birth',
          ),
          ContentQuestion(
            id: 'premature_birth_3',
            question: 'What are the causes of premature birth?',
            answer: 'Causes of premature birth can include infections, multiple pregnancies, anatomical anomalies of the uterus, stress, trauma, or chronic maternal conditions such as high blood pressure or diabetes.',
            categoryId: 'premature_birth',
          ),
          ContentQuestion(
            id: 'premature_birth_4',
            question: 'Are there physical signs of premature birth?',
            answer: 'Physical signs of premature birth can include regular contractions, vaginal bleeding, back pain, a feeling of pressure in the pelvis, and loss of amniotic fluid.',
            categoryId: 'premature_birth',
          ),
          ContentQuestion(
            id: 'premature_birth_5',
            question: 'What are possible consequences of premature birth for the mother?',
            answer: 'Possible consequences for the mother include an increased risk of further premature births, psychological stress, and postpartum complications.',
            categoryId: 'premature_birth',
          ),
          ContentQuestion(
            id: 'premature_birth_6',
            question: 'What are possible consequences of premature birth for the child?',
            answer: 'Possible consequences for the child include breathing problems, underdevelopment of organs, developmental delays, and an increased risk of infection.',
            categoryId: 'premature_birth',
          ),
          ContentQuestion(
            id: 'premature_birth_7',
            question: 'Are there ways to prevent a premature birth?',
            answer: 'Ways to prevent a premature birth include regular prenatal check-ups, treatment of infections, rest, stress reduction, and taking progesterone if medically necessary.',
            categoryId: 'premature_birth',
          ),
          ContentQuestion(
            id: 'premature_birth_8',
            question: 'What can the pregnant woman do to prevent a premature birth?',
            answer: 'Pregnant women can maintain a healthy diet, avoid alcohol and cigarettes, reduce stress, and attend regular doctor visits to minimize the risk of premature birth.',
            categoryId: 'premature_birth',
          ),
          ContentQuestion(
            id: 'premature_birth_9',
            question: 'Health concerns?',
            answer: 'Health concerns related to premature birth include developmental problems in the child, respiratory illnesses, increased susceptibility to infections, and psychological stress for the mother.',
            categoryId: 'premature_birth',
          ),
        ],
      ),
      ContentCategory(
        id: 'nutrition',
        title: 'Nutrition During Pregnancy',
        description: 'Guidance on proper nutrition for mother and baby during pregnancy.',
        imageUrl: 'assets/images/nutrition.png',
        questions: [
          ContentQuestion(
            id: 'nutrition_1',
            question: 'Why is nutrition important during pregnancy?',
            answer: 'Proper nutrition during pregnancy ensures the baby gets essential nutrients for development and helps maintain the mother\'s health. It can reduce the risk of birth defects and complications.',
            categoryId: 'nutrition',
          ),
          ContentQuestion(
            id: 'nutrition_2',
            question: 'What foods should be avoided during pregnancy?',
            answer: 'Foods to avoid include raw or undercooked meat, fish with high mercury content, unpasteurized dairy products, raw eggs, unwashed fruits and vegetables, and excessive caffeine.',
            categoryId: 'nutrition',
          ),
          ContentQuestion(
            id: 'nutrition_3',
            question: 'What nutrients are especially important during pregnancy?',
            answer: 'Key nutrients include folic acid, iron, calcium, vitamin D, protein, and omega-3 fatty acids. These support the baby\'s development and the mother\'s changing body.',
            categoryId: 'nutrition',
          ),
          ContentQuestion(
            id: 'nutrition_4',
            question: 'How should I eat during pregnancy?',
            answer: 'Pregnant women should eat plenty of fruits, vegetables, proteins, folic acid, and iron, while avoiding foods like raw meat, raw eggs, and unpasteurized dairy products.',
            categoryId: 'nutrition',
          ),
          ContentQuestion(
            id: 'nutrition_5',
            question: 'What foods are healthy during pregnancy?',
            answer: 'Healthy foods include: Fresh fruits and vegetables (for vitamins and fiber), whole grains (for complex carbohydrates and fiber), lean meat, fish (especially fatty fish like salmon for omega-3), eggs, legumes and nuts (for proteins and healthy fats), dairy products (for calcium and vitamin D), legumes (for iron and protein).',
            categoryId: 'nutrition',
          ),
          ContentQuestion(
            id: 'nutrition_6',
            question: 'What foods are unhealthy during pregnancy?',
            answer: 'Unhealthy or foods to avoid include: Raw meat, raw fish (e.g., sushi), raw eggs, and unpasteurized dairy products (risk of listeriosis and toxoplasmosis), liver and liver-containing products (due to high vitamin A content), caffeine in large amounts (maximum 200 mg per day, about one cup of coffee), alcohol and cigarettes (harmful to the baby\'s development), fish with high mercury content (e.g., tuna, swordfish).',
            categoryId: 'nutrition',
          ),
        ],
      ),
      // New categories from brochure
      ContentCategory(
        id: 'gynecologist',
        title: 'Gynecologist',
        description: 'Information about the gynecologist and gynecological examinations.',
        imageUrl: 'assets/images/gynecologist.png',
        questions: [
          ContentQuestion(
            id: 'gynecologist_1',
            question: 'What is the role of a gynecologist?',
            answer: 'A gynecologist cares for women\'s reproductive health throughout all stages of life. Their main responsibilities include preventive care (cancer screening, ultrasound, gynecological examinations), pregnancy & childbirth (care, ultrasound, delivery, aftercare), treatment of conditions (hormonal disorders, infections, endometriosis, fibroids), counseling on contraception & fertility, support during menopause, psychosomatic care, and operations such as cesarean section, sterilization, or tumor removal.',
            categoryId: 'gynecologist',
          ),
          ContentQuestion(
            id: 'gynecologist_2',
            question: 'What is included in a first gynecological appointment during pregnancy?',
            answer: 'The first gynecological appointment includes a detailed medical history, recording of weight, height, and blood pressure, as well as a comprehensive clinical examination, including ultrasound examination (if technically possible) to assess the internal organs, position, and development of the pregnancy.',
            categoryId: 'gynecologist',
          ),
          ContentQuestion(
            id: 'gynecologist_3',
            question: 'What questions should I ask the doctor as a pregnant woman?',
            answer: '1. Is the pregnancy developing according to schedule? This question serves to confirm the normal development of the pregnancy.\n2. What should I be aware of as a pregnant woman? This question serves for individual counseling by the doctor.\n3. What should I not do as a pregnant woman? This question serves to advise you on your individual pregnancy progression.',
            categoryId: 'gynecologist',
          ),
        ],
      ),
      ContentCategory(
        id: 'pregnancy_stages',
        title: 'Pregnancy Stages',
        description: 'Information about the different stages of pregnancy (trimesters).',
        imageUrl: 'assets/images/pregnancy_stages.png',
        questions: [
          ContentQuestion(
            id: 'pregnancy_stages_1',
            question: 'What is a trimester?',
            answer: 'A trimester is a term that describes the three phases of pregnancy, each lasting about three months.\n\n1. First Trimester (first 12 weeks): During this phase, fertilization occurs, and the early developments of the embryo and organs begin. The woman may experience initial symptoms such as nausea and fatigue.\n\n2. Second Trimester (13th to 26th week): The fetus continues to grow, and many of the discomforts of the first phase subside. During this phase, many women begin to show their baby bump.\n\n3. Third Trimester (27th week to birth): The baby continues to grow, and the mother\'s body prepares for birth. There may be increased physical discomforts such as back pain or sleep problems.',
            categoryId: 'pregnancy_stages',
          ),
          ContentQuestion(
            id: 'pregnancy_stages_2',
            question: 'How many weeks of pregnancy are there?',
            answer: 'A pregnancy lasts about 40 weeks (gestational weeks), sometimes up to 42 weeks.',
            categoryId: 'pregnancy_stages',
          ),
          ContentQuestion(
            id: 'pregnancy_stages_3',
            question: 'How do examinations differ depending on the trimester?',
            answer: '1st Trimester (1-12 weeks):\n• Initial examination: Blood pressure, weight, urine, blood tests (Rhesus factor, infections)\n• Ultrasound to confirm pregnancy\n• Optional tests: Nuchal translucency measurement, first-trimester screening, non-invasive prenatal test (NIPT)\n\n2nd Trimester (13-28 weeks):\n• Prenatal care every 4 weeks: Blood pressure, weight, urine, growth monitoring\n• 20-22 weeks: Detailed ultrasound examination\n• 24-28 weeks: Diabetes exclusion (glucose tolerance test)\n\n3rd Trimester (29-40 weeks):\n• From 29 weeks, prenatal care every 3 weeks, from 36 weeks weekly\n• CTG controls, determination of the baby\'s position\n• From 40 weeks, close monitoring until birth\n\nAll examinations serve to monitor the health of mother and child.',
            categoryId: 'pregnancy_stages',
          ),
          ContentQuestion(
            id: 'pregnancy_stages_4',
            question: 'What physical changes can be expected during pregnancy?',
            answer: 'The body prepares for birth: the uterus grows, hormones change, and weight increases. Typical changes during pregnancy can include:\n\n1st Trimester (1-12 weeks): Nausea, fatigue, sensitive breasts.\n\n2nd Trimester (13-28 weeks): Growing belly, fewer discomforts, baby movements can be felt.\n\n3rd Trimester (29-40 weeks): Belly becomes heavier, back pain, frequent urination, preparation for birth.',
            categoryId: 'pregnancy_stages',
          ),
        ],
      ),
      ContentCategory(
        id: 'late_birth',
        title: 'Late Birth',
        description: 'Information about late births and their possible consequences.',
        imageUrl: 'assets/images/late_birth.png',
        questions: [
          ContentQuestion(
            id: 'late_birth_1',
            question: 'When is a birth defined as a late birth?',
            answer: 'A late birth is defined when the pregnancy lasts longer than 42 weeks.',
            categoryId: 'late_birth',
          ),
          ContentQuestion(
            id: 'late_birth_2',
            question: 'Health concerns with late birth?',
            answer: 'Health concerns with a late birth include an increased risk of complications during birth, oxygen deficiency for the child, and a larger birth weight that can make the birth more difficult.',
            categoryId: 'late_birth',
          ),
        ],
      ),
      ContentCategory(
        id: 'pregnancy_basics',
        title: 'Pregnancy Basics',
        description: 'Basic information about pregnancy and its recognition.',
        imageUrl: 'assets/images/pregnancy_basics.png',
        questions: [
          ContentQuestion(
            id: 'pregnancy_basics_1',
            question: 'How does pregnancy work?',
            answer: 'A pregnancy begins when a fertilized egg implants in the uterine lining and develops into an embryo.',
            categoryId: 'pregnancy_basics',
          ),
          ContentQuestion(
            id: 'pregnancy_basics_2',
            question: 'How and when can I tell that I am pregnant?',
            answer: 'Pregnancy is often recognized by the absence of a period, nausea, fatigue, frequent urination, and a feeling of tension in the breasts.',
            categoryId: 'pregnancy_basics',
          ),
          ContentQuestion(
            id: 'pregnancy_basics_3',
            question: 'What are the first symptoms that appear in a potential pregnancy?',
            answer: 'Early symptoms of pregnancy can include nausea, vomiting, mood swings, and spotting.',
            categoryId: 'pregnancy_basics',
          ),
        ],
      ),
      ContentCategory(
        id: 'pre_pregnancy',
        title: 'Before Pregnancy',
        description: 'Information on preparation and planning for pregnancy.',
        imageUrl: 'assets/images/pre_pregnancy.png',
        questions: [
          ContentQuestion(
            id: 'pre_pregnancy_1',
            question: 'What happens before pregnancy?',
            answer: 'Before pregnancy, the woman\'s body prepares for ovulation, and the uterine lining builds up.',
            categoryId: 'pre_pregnancy',
          ),
          ContentQuestion(
            id: 'pre_pregnancy_2',
            question: 'What preliminary examinations should I have done before I become pregnant?',
            answer: 'Before pregnancy, you should have the following examinations done to rule out diseases and identify risks:\n\n1. General check: Blood pressure, blood count, thyroid function (TSH)\n2. Gynecological check: Pap smear, ultrasound, possibly cycle monitoring\n3. Blood tests: Rubella, chicken pox, toxoplasmosis, hepatitis B/C, HIV\n4. Vaccinations: Measles, mumps, rubella, chicken pox, tetanus, whooping cough, flu\n5. Dental check: Check dental health',
            categoryId: 'pre_pregnancy',
          ),
          ContentQuestion(
            id: 'pre_pregnancy_3',
            question: 'How can I optimize my lifestyle to improve fertility?',
            answer: 'Before and especially during pregnancy, you should consider the following: healthy nutrition with plenty of fruits, vegetables, whole grains, healthy fats (e.g., avocado) and proteins, healthy body weight (BMI 18.5-24.9), moderate exercise (regular, but don\'t overdo it), stress reduction (meditation, yoga, acupuncture), avoiding harmful substances (no nicotine and alcohol, little caffeine), minimizing environmental toxins, and adequate sleep (7-9 hours).',
            categoryId: 'pre_pregnancy',
          ),
          ContentQuestion(
            id: 'pre_pregnancy_4',
            question: 'Which vitamins and nutrients should I already take before pregnancy?',
            answer: 'The following vitamins and nutrients are important in the context of pregnancy:\n\n1. Folic acid: 400-800 μg (at least 3 months in advance)\n2. Vitamin D: 800-1,000 IU daily\n3. Omega-3 fatty acids: 500-1,000 mg EPA/DHA\n4. Iron: according to blood values\n5. Zinc & Vitamin E: for egg quality\n6. Vitamin C: supports iron absorption\n7. Iodine: 150-200 μg daily\n\nThese supplements should be taken in consultation with your doctor.',
            categoryId: 'pre_pregnancy',
          ),
        ],
      ),
      ContentCategory(
        id: 'post_pregnancy',
        title: 'After Pregnancy',
        description: 'Information about the time after birth and postpartum recovery.',
        imageUrl: 'assets/images/post_pregnancy.png',
        questions: [
          ContentQuestion(
            id: 'post_pregnancy_1',
            question: 'What happens after pregnancy?',
            answer: 'After pregnancy, the uterus regresses, the hormone balance stabilizes, and milk production begins.',
            categoryId: 'post_pregnancy',
          ),
          ContentQuestion(
            id: 'post_pregnancy_2',
            question: 'How long does physical recovery take after birth?',
            answer: 'Complete physical recovery can take up to six weeks or longer, depending on the type of birth (vaginal or cesarean) and any complications.',
            categoryId: 'post_pregnancy',
          ),
          ContentQuestion(
            id: 'post_pregnancy_3',
            question: 'How can I manage the emotional adjustment after birth?',
            answer: 'Taking time for yourself, getting adequate rest and support, and openly discussing emotions can help manage the "baby blues" or emotional adjustments. If you experience severe mood swings, you should consult a doctor.',
            categoryId: 'post_pregnancy',
          ),
        ],
      ),
      ContentCategory(
        id: 'fertility',
        title: 'Fertility and Contraception',
        description: 'Information about fertility, contraception methods, and family planning.',
        imageUrl: 'assets/images/fertility.png',
        questions: [
          ContentQuestion(
            id: 'fertility_1',
            question: 'What is fertility?',
            answer: 'Fertility describes the ability to become pregnant and carry a child to term.',
            categoryId: 'fertility',
          ),
          ContentQuestion(
            id: 'fertility_2',
            question: 'Why use contraception?',
            answer: 'Contraception is used to prevent unwanted pregnancies and sexually transmitted diseases.',
            categoryId: 'fertility',
          ),
          ContentQuestion(
            id: 'fertility_3',
            question: 'What different contraception methods are there and what are their pros and cons?',
            answer: 'Contraception methods such as condoms, the pill, or IUDs each have specific advantages and disadvantages, such as protection against infections, safety, or side effects.',
            categoryId: 'fertility',
          ),
        ],
      ),
      ContentCategory(
        id: 'exercise',
        title: 'Exercise During Pregnancy',
        description: 'Safe exercise practices and recommendations for pregnant women.',
        imageUrl: 'assets/images/exercise.png',
        questions: [
          ContentQuestion(
            id: 'exercise_1',
            question: 'Is exercise safe during pregnancy?',
            answer: 'Exercise during pregnancy is not only allowed but also very healthy - as long as it is adapted to your individual needs and the respective pregnancy phase.',
            categoryId: 'exercise',
          ),
          ContentQuestion(
            id: 'exercise_2',
            question: 'What types of exercise are suitable during pregnancy?',
            answer: 'Safe activities include swimming, walking, pregnancy yoga, light gymnastics, or cycling on level ground.',
            categoryId: 'exercise',
          ),
          ContentQuestion(
            id: 'exercise_3',
            question: 'How much exercise should I do at what point in pregnancy?',
            answer: '1. First Trimester (1-12 weeks):\n• Suitable: Light to moderate movement, e.g., walking, swimming, yoga, Pilates, cycling on level ground\n• Caution: Avoid overheating, extreme exertion, and sports with high risk of falling\n• Not recommended: Contact sports, intensive strength training, sports with high impact (e.g., show jumping)\n\n2. Second Trimester (13-27 weeks):\n• Suitable: Pregnancy yoga, moderate strength training (especially for back and pelvic floor), water gymnastics, walking\n• Caution: No exercises lying on your back after the 20th week (can affect blood flow to the uterus)\n• Not recommended: Sports with sudden changes of direction or high risk of injury\n\n3. Third Trimester (28-40 weeks):\n• Suitable: Gentle yoga, swimming, light strength training, pelvic floor exercises\n• Caution: No excessive stretching, as joints are looser due to the hormone relaxin\n• Not recommended: Sports with high risk of falling or impact\n\nGeneral tips:\n✔ Listen to your body and reduce intensity if you feel tired\n✔ Drink plenty of water\n✔ Avoid exercise in extreme heat\n✔ Consult your doctor or midwife if you are unsure',
            categoryId: 'exercise',
          ),
        ],
      ),
      ContentCategory(
        id: 'pregnancy_check',
        title: 'Pregnancy Detection',
        description: 'Information about detecting and confirming a pregnancy.',
        imageUrl: 'assets/images/pregnancy_check.png',
        questions: [
          ContentQuestion(
            id: 'pregnancy_check_1',
            question: 'When should I have a pregnancy confirmed?',
            answer: 'The ideal time to confirm a pregnancy depends on how far along you are and how certain you want the result to be. Here are some general guidelines:\n\n1. Early detection (from when your period is missed):\nUrine test: Home pregnancy tests can be done from the first day your period is missed. These tests measure the hormone hCG in urine, which is produced early in pregnancy.\nDoctor\'s appointment: If the pregnancy test is positive or there is uncertainty, confirmation by a doctor can be useful. A blood test at the doctor\'s is more sensitive and can often detect a pregnancy earlier (about 7-10 days after ovulation).\nFirst doctor\'s visit (approx. 6-8 weeks of pregnancy): It is recommended to schedule the first appointment with the gynecologist about 2-3 weeks after your period is missed. At this point, the doctor can confirm the pregnancy with an ultrasound and make the gestational sac or embryo visible. The heartbeat is often detectable from the 6th week.',
            categoryId: 'pregnancy_check',
          ),
          ContentQuestion(
            id: 'pregnancy_check_2',
            question: 'How does the doctor determine the development of a pregnancy?',
            answer: 'Through symptoms such as missed period, nausea, tension in the breasts. Confirmation through pregnancy test (hCG detection) and ultrasound.',
            categoryId: 'pregnancy_check',
          ),
          ContentQuestion(
            id: 'pregnancy_check_3',
            question: 'What signs may appear in early pregnancy?',
            answer: 'Nausea, fatigue, breast tenderness, frequent urination, mild abdominal pain.',
            categoryId: 'pregnancy_check',
          ),
          ContentQuestion(
            id: 'pregnancy_check_4',
            question: 'With which symptoms in early pregnancy should I see a doctor?',
            answer: 'Severe pain, bleeding, high fever, dizziness, sudden severe nausea.',
            categoryId: 'pregnancy_check',
          ),
        ],
      ),
      ContentCategory(
        id: 'pregnancy_complications',
        title: 'Complications in Pregnancy',
        description: 'Information about possible complications and illnesses during pregnancy.',
        imageUrl: 'assets/images/complications.png',
        questions: [
          ContentQuestion(
            id: 'pregnancy_complications_1',
            question: 'What are the most common illnesses that appear during pregnancy?',
            answer: 'Common illnesses in pregnancy include preeclampsia, urinary tract infections, and gestational diabetes.',
            categoryId: 'pregnancy_complications',
          ),
          ContentQuestion(
            id: 'pregnancy_complications_2',
            question: 'What risk factors frequently occur?',
            answer: 'Risk factors include maternal age over 35, chronic diseases, smoking, alcohol consumption, and severe overweight.',
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
            question: 'Are there medical treatments for complications in pregnancy?',
            answer: 'Yes, e.g., hormonal support, surgery for ectopic pregnancy, IV fluids for severe nausea.',
            categoryId: 'pregnancy_complications',
          ),
          ContentQuestion(
            id: 'pregnancy_complications_5',
            question: 'Which diseases can harm my pregnancy?',
            answer: 'Rubella, toxoplasmosis, listeriosis, Zika virus, diabetes, or thyroid diseases.',
            categoryId: 'pregnancy_complications',
          ),
        ],
      ),
      ContentCategory(
        id: 'prenatal_care',
        title: 'Prenatal Care',
        description: 'Information about prenatal care during pregnancy.',
        imageUrl: 'assets/images/prenatal_care.png',
        questions: [
          ContentQuestion(
            id: 'prenatal_care_1',
            question: 'What special examinations are there during pregnancy?',
            answer: 'There are special examinations such as ultrasounds, blood tests, the glucose test (glucose tolerance test), the first-trimester screening, and possible prenatal diagnostics, such as NIPT or amniocentesis.',
            categoryId: 'prenatal_care',
          ),
          ContentQuestion(
            id: 'prenatal_care_2',
            question: 'What is prenatal diagnostics?',
            answer: 'Prenatal diagnostics includes special tests such as amniotic fluid examinations to detect genetic risks.',
            categoryId: 'prenatal_care',
          ),
          ContentQuestion(
            id: 'prenatal_care_3',
            question: 'What examinations are part of prenatal diagnostics?',
            answer: 'Prenatal diagnostics include first-trimester screening, NIPT (non-invasive prenatal tests), chorionic villus sampling, amniocentesis (amniotic fluid examination), and detailed ultrasound.',
            categoryId: 'prenatal_care',
          ),
          ContentQuestion(
            id: 'prenatal_care_4',
            question: 'What is a CTG?',
            answer: 'A CTG (cardiotocography) measures the baby\'s heart rate and the mother\'s contractions from the 26th week of pregnancy.',
            categoryId: 'prenatal_care',
          ),
          ContentQuestion(
            id: 'prenatal_care_5',
            question: 'Is ultrasound dangerous during pregnancy?',
            answer: 'An ultrasound is not dangerous and helps monitor the development of the child.',
            categoryId: 'prenatal_care',
          ),
        ],
      ),
      ContentCategory(
        id: 'birth_preparation',
        title: 'Birth Preparation',
        description: 'Information about preparing for birth and different birth methods.',
        imageUrl: 'assets/images/birth_preparation.png',
        questions: [
          ContentQuestion(
            id: 'birth_preparation_1',
            question: 'What birth methods are available to me?',
            answer: 'Birth methods include vaginal birth, cesarean section, water birth, and births with assistance such as vacuum extraction or forceps.',
            categoryId: 'birth_preparation',
          ),
          ContentQuestion(
            id: 'birth_preparation_2',
            question: 'How can I prepare mentally and physically for birth?',
            answer: 'Birth preparation classes, breathing exercises, relaxation exercises, and learning pain management techniques can be helpful. Exchanging experiences with other mothers can also provide psychological strength.',
            categoryId: 'birth_preparation',
          ),
          ContentQuestion(
            id: 'birth_preparation_3',
            question: 'When should I present myself at the hospital during pregnancy?',
            answer: 'Usually, you present yourself at the hospital from the 32nd to 36th week of pregnancy to plan the birth.',
            categoryId: 'birth_preparation',
          ),
          ContentQuestion(
            id: 'birth_preparation_4',
            question: 'What personal items should I bring to a hospital visit?',
            answer: 'It is advisable to bring your maternity record book, health insurance card, possibly a referral, and personal documents as well as comfortable clothing.',
            categoryId: 'birth_preparation',
          ),
        ],
      ),
      ContentCategory(
        id: 'postpartum',
        title: 'Postpartum Period and Breastfeeding',
        description: 'Information about the postpartum period and breastfeeding after birth.',
        imageUrl: 'assets/images/postpartum.png',
        questions: [
          ContentQuestion(
            id: 'postpartum_1',
            question: 'How long does the postpartum period last and what should I be aware of during this time?',
            answer: 'The postpartum period lasts about six to eight weeks and serves for physical and emotional recovery after birth. During this time, attention should be paid to adequate rest, healthy nutrition, and wound healing.',
            categoryId: 'postpartum',
          ),
          ContentQuestion(
            id: 'postpartum_2',
            question: 'What role does the midwife play in the postpartum period?',
            answer: 'The midwife supports in the postpartum period with recovery, wound care, breastfeeding, as well as the care of the baby, and provides valuable tips for the new life situation.',
            categoryId: 'postpartum',
          ),
          ContentQuestion(
            id: 'postpartum_3',
            question: 'How does breastfeeding work and how often should I breastfeed my baby?',
            answer: 'Breastfeeding works according to the principle of supply and demand: The more often you put your baby to the breast, the more milk is produced. Newborns should be breastfed at least eight to twelve times within 24 hours in the first weeks, following your baby\'s needs.',
            categoryId: 'postpartum',
          ),
          ContentQuestion(
            id: 'postpartum_4',
            question: 'What can I do if breastfeeding doesn\'t go well?',
            answer: 'If breastfeeding doesn\'t go well, it can be helpful to pay attention to correct latching technique, as this is crucial for breastfeeding success. Support from a midwife or lactation consultant can provide valuable help.',
            categoryId: 'postpartum',
          ),
        ],
      ),
      ContentCategory(
        id: 'newborn',
        title: 'The Newborn',
        description: 'Information about the care and support of the newborn.',
        imageUrl: 'assets/images/newborn.png',
        questions: [
          ContentQuestion(
            id: 'newborn_1',
            question: 'How often does a newborn need to be fed?',
            answer: 'A newborn should be fed about every 2-3 hours, so 8-12 times in 24 hours.',
            categoryId: 'newborn',
          ),
          ContentQuestion(
            id: 'newborn_2',
            question: 'How can I calm my baby when it cries?',
            answer: 'For calming, physical contact, gentle rocking, or soft humming can help.',
            categoryId: 'newborn',
          ),
          ContentQuestion(
            id: 'newborn_3',
            question: 'What sleep patterns are normal for a newborn?',
            answer: 'Newborns sleep irregularly and usually 16-18 hours a day, distributed over short sleep phases.',
            categoryId: 'newborn',
          ),
          ContentQuestion(
            id: 'newborn_4',
            question: 'How often should I take my newborn to the pediatrician?',
            answer: 'With a newborn, you should regularly attend the well-baby check-ups at the pediatrician, which take place according to a fixed schedule.',
            categoryId: 'newborn',
          ),
          ContentQuestion(
            id: 'newborn_5',
            question: 'What examinations are important at the pediatrician in the first months?',
            answer: 'The U1, immediately after birth, includes checking breathing, heartbeat, muscle tone, reflexes, and skin color (APGAR score) as well as initial care, including cutting the umbilical cord and keeping warm.\n\nThe U2 (3rd-10th day of life) includes a thorough physical examination, checking the organs, reflexes, and a newborn screening for metabolic diseases.\n\nThe U4 (3rd-4th month of life) checks physical and motor development, vaccination status, and often includes the first vaccinations.',
            categoryId: 'newborn',
          ),
        ],
      ),
      ContentCategory(
        id: 'dont_dos',
        title: 'Behavioral Guidelines',
        description: 'Guidelines and activities to avoid during pregnancy.',
        imageUrl: 'assets/images/dont_dos.png',
        questions: [
          ContentQuestion(
            id: 'dont_dos_1',
            question: 'What are don\'ts once you know you\'re pregnant?',
            answer: 'Pregnant women should avoid alcohol, drugs, and raw meat and fish, not lift heavy objects, and limit excessive caffeine consumption.',
            categoryId: 'dont_dos',
          ),
        ],
      ),
    ]);
  }
}