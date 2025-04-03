import '../models/content_model.dart';

class SampleData {
  static ContentData getSampleContent() {
    return ContentData(categories: [
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
            question: 'Is it safe to exercise during pregnancy?',
            answer: 'Yes, exercise is generally safe and beneficial during pregnancy for women with uncomplicated pregnancies. It helps manage weight, reduce discomfort, and prepare for childbirth.',
            categoryId: 'exercise',
          ),
          ContentQuestion(
            id: 'exercise_2',
            question: 'What types of exercises are recommended?',
            answer: 'Recommended exercises include walking, swimming, stationary cycling, low-impact aerobics, prenatal yoga, and modified strength training with light weights.',
            categoryId: 'exercise',
          ),
          ContentQuestion(
            id: 'exercise_3',
            question: 'What exercises should be avoided?',
            answer: 'Avoid exercises with high fall risk, contact sports, activities requiring lying flat on your back after the first trimester, hot yoga, and exercises with extreme jumping, bouncing, or quick direction changes.',
            categoryId: 'exercise',
          ),
        ],
      ),
    ]);
  }
}