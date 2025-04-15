import 'package:intl/intl.dart';

enum VitalTrend { up, down, stable }

class PatientData {
  final String firstName;
  final String lastName;
  final DateTime birthdate;
  final String bloodType;
  final double height;
  final double prePregnancyWeight;
  final double currentWeight;
  final String phone;
  final String email;
  final String address;
  final String insuranceName;
  final String insuranceNumber;
  final List<String> allergies;
  final List<String> medications;
  final PregnancyData pregnancyData;
  final List<VitalData> vitalData;
  final LabResults labResults;
  final List<UltrasoundData> ultrasoundData;

  PatientData({
    required this.firstName,
    required this.lastName,
    required this.birthdate,
    required this.bloodType,
    required this.height,
    required this.prePregnancyWeight,
    required this.currentWeight,
    required this.phone,
    required this.email,
    required this.address,
    required this.insuranceName,
    required this.insuranceNumber,
    required this.allergies,
    required this.medications,
    required this.pregnancyData,
    required this.vitalData,
    required this.labResults,
    required this.ultrasoundData,
  });

  String get fullName => '$firstName $lastName';

  int get age {
    final today = DateTime.now();
    int age = today.year - birthdate.year;

    if (today.month < birthdate.month ||
        (today.month == birthdate.month && today.day < birthdate.day)) {
      age--;
    }

    return age;
  }

  String get birthdateFormatted => DateFormat('dd.MM.yyyy').format(birthdate);

  static PatientData getSampleData() {
    return PatientData(
      firstName: 'Maria',
      lastName: 'Schmidt',
      birthdate: DateTime(1990, 5, 15),
      bloodType: 'A+',
      height: 168,
      prePregnancyWeight: 62,
      currentWeight: 71.5,
      phone: '+49 123 4567890',
      email: 'maria.schmidt@example.com',
      address: 'Musterstraße 123, 10115 Berlin',
      insuranceName: 'AOK Gesundheit',
      insuranceNumber: 'AOK123456789',
      allergies: ['Penicillin'],
      medications: ['Folsäure 400µg täglich', 'Eisen 30mg zweimal täglich'],

      pregnancyData: PregnancyData(
        gestationalWeeks: 28,
        dueDate: DateTime.now().add(Duration(days: 84)), // ungefähr 12 Wochen in der Zukunft
        gravidaAndPara: 'G2P1',
        lastVisitDate: DateTime.now().subtract(Duration(days: 14)),
        nextVisitDate: DateTime.now().add(Duration(days: 14)),
        riskFactors: ['Leicht erhöhter Blutdruck'],
      ),

      vitalData: [
        VitalData(
          name: 'Blutdruck',
          value: '125/82',
          unit: 'mmHg',
          date: DateTime.now().subtract(Duration(days: 14)),
          trend: VitalTrend.stable,
          isNormal: true,
        ),
        VitalData(
          name: 'Blutzucker',
          value: '110',
          unit: 'mg/dL',
          date: DateTime.now().subtract(Duration(days: 14)),
          trend: VitalTrend.up,
          isNormal: true,
        ),
        VitalData(
          name: 'Gewichtszunahme',
          value: '9.5',
          unit: 'kg',
          date: DateTime.now().subtract(Duration(days: 14)),
          trend: VitalTrend.stable,
          isNormal: true,
        ),
        VitalData(
          name: 'Hämoglobin',
          value: '10.8',
          unit: 'g/dL',
          date: DateTime.now().subtract(Duration(days: 14)),
          trend: VitalTrend.down,
          isNormal: false,
        ),
      ],

      labResults: LabResults(
        dateCollected: DateTime.now().subtract(Duration(days: 14)),
        testCount: 12,
        hasAbnormalities: true,
        doctorNotes: 'Leicht erniedrigter Hämoglobinwert. Eisenpräparate wurden verschrieben. Bitte verfolgen Sie die Werte weiter.',
        tests: [
          LabTest(
            name: 'Hämoglobin',
            result: '10.8',
            unit: 'g/dL',
            referenceRange: '11.0-15.0',
            isAbnormal: true,
          ),
          LabTest(
            name: 'Hämatokrit',
            result: '33',
            unit: '%',
            referenceRange: '33-45',
            isAbnormal: false,
          ),
          LabTest(
            name: 'Leukozyten',
            result: '9.5',
            unit: '10^3/µL',
            referenceRange: '4.0-11.0',
            isAbnormal: false,
          ),
          LabTest(
            name: 'Thrombozyten',
            result: '230',
            unit: '10^3/µL',
            referenceRange: '150-450',
            isAbnormal: false,
          ),
          LabTest(
            name: 'Glukose',
            result: '110',
            unit: 'mg/dL',
            referenceRange: '70-120',
            isAbnormal: false,
          ),
          LabTest(
            name: 'Eisen',
            result: '45',
            unit: 'µg/dL',
            referenceRange: '50-170',
            isAbnormal: true,
          ),
        ],
      ),

      ultrasoundData: [
        UltrasoundData(
          date: DateTime.now().subtract(Duration(days: 14)),
          gestationalWeek: 28,
          estimatedWeight: 1100,
          fetalHeartRate: 150,
          fetalLength: 38,
          headCircumference: 27,
          abdominalCircumference: 23,
          fetalPosition: 'Kopflage',
          placentaPosition: 'Vorderwand, oben',
          amnioticFluid: 'Normal',
          notes: 'Alle Wachstumsmessungen im normalen Bereich. Fetale Aktivität und Bewegungen normal.',
        ),
        UltrasoundData(
          date: DateTime.now().subtract(Duration(days: 42)), // -6 Wochen
          gestationalWeek: 22,
          estimatedWeight: 680,
          fetalHeartRate: 148,
          fetalLength: 32,
          headCircumference: 22,
          abdominalCircumference: 19,
          fetalPosition: 'Kopflage',
          placentaPosition: 'Vorderwand, oben',
          amnioticFluid: 'Normal',
          notes: 'Normales Wachstum, keine Auffälligkeiten feststellbar.',
        ),
        UltrasoundData(
          date: DateTime.now().subtract(Duration(days: 84)), // -12 Wochen
          gestationalWeek: 16,
          estimatedWeight: 250,
          fetalHeartRate: 155,
          fetalLength: 23,
          headCircumference: 15,
          abdominalCircumference: 13,
          fetalPosition: 'Variabel',
          placentaPosition: 'Vorderwand',
          amnioticFluid: 'Normal',
          notes: 'Alle Messungen entsprechen dem Gestationsalter. Keine strukturellen Anomalien erkennbar.',
        ),
      ],
    );
  }
}

class PregnancyData {
  final int gestationalWeeks;
  final DateTime dueDate;
  final String gravidaAndPara;
  final DateTime lastVisitDate;
  final DateTime nextVisitDate;
  final List<String> riskFactors;

  PregnancyData({
    required this.gestationalWeeks,
    required this.dueDate,
    required this.gravidaAndPara,
    required this.lastVisitDate,
    required this.nextVisitDate,
    required this.riskFactors,
  });

  String get dueDateFormatted => DateFormat('dd.MM.yyyy').format(dueDate);
  String get lastVisitDateFormatted => DateFormat('dd.MM.yyyy').format(lastVisitDate);
  String get nextVisitDateFormatted => DateFormat('dd.MM.yyyy').format(nextVisitDate);
}

class VitalData {
  final String name;
  final String value;
  final String unit;
  final DateTime date;
  final VitalTrend trend;
  final bool isNormal;

  VitalData({
    required this.name,
    required this.value,
    required this.unit,
    required this.date,
    required this.trend,
    required this.isNormal,
  });

  String get dateFormatted => DateFormat('dd.MM.yyyy').format(date);
}

class LabResults {
  final DateTime dateCollected;
  final int testCount;
  final bool hasAbnormalities;
  final String doctorNotes;
  final List<LabTest> tests;

  LabResults({
    required this.dateCollected,
    required this.testCount,
    required this.hasAbnormalities,
    required this.doctorNotes,
    required this.tests,
  });

  String get dateFormatted => DateFormat('dd.MM.yyyy').format(dateCollected);
}

class LabTest {
  final String name;
  final String result;
  final String unit;
  final String referenceRange;
  final bool isAbnormal;

  LabTest({
    required this.name,
    required this.result,
    required this.unit,
    required this.referenceRange,
    required this.isAbnormal,
  });
}

class UltrasoundData {
  final DateTime date;
  final int gestationalWeek;
  final int estimatedWeight;
  final int fetalHeartRate;
  final int fetalLength;
  final int headCircumference;
  final int abdominalCircumference;
  final String fetalPosition;
  final String placentaPosition;
  final String amnioticFluid;
  final String notes;

  UltrasoundData({
    required this.date,
    required this.gestationalWeek,
    required this.estimatedWeight,
    required this.fetalHeartRate,
    required this.fetalLength,
    required this.headCircumference,
    required this.abdominalCircumference,
    required this.fetalPosition,
    required this.placentaPosition,
    required this.amnioticFluid,
    required this.notes,
  });

  String get dateFormatted => DateFormat('dd.MM.yyyy').format(date);
}