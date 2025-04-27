import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../services/localization_service.dart'; // Lokalisierungsdienst importieren

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

  // Wir verwenden eine Methode, um lokalisierte Beispieldaten zu bekommen
  static PatientData getSampleData({BuildContext? context}) {
    bool isGerman = context == null ? false : context.loc.locale.languageCode == 'de';
    bool isFrench = context == null ? false : context.loc.locale.languageCode == 'fr';

    // Standard-Medikamente in allen Sprachen
    final List<String> medicationsDE = ['Folsäure 400µg täglich', 'Eisen 30mg zweimal täglich'];
    final List<String> medicationsEN = ['Folic acid 400µg daily', 'Iron 30mg twice daily'];
    final List<String> medicationsFR = ['Acide folique 400µg par jour', 'Fer 30mg deux fois par jour'];

    // Standard-Risikofaktoren in allen Sprachen
    final List<String> riskFactorsDE = ['Leicht erhöhter Blutdruck'];
    final List<String> riskFactorsEN = ['Slightly elevated blood pressure'];
    final List<String> riskFactorsFR = ['Tension artérielle légèrement élevée'];

    // Arztnotizen in allen Sprachen
    const String doctorNotesDE = 'Leicht erniedrigter Hämoglobinwert. Eisenpräparate wurden verschrieben. Bitte verfolgen Sie die Werte weiter.';
    const String doctorNotesEN = 'Slightly decreased hemoglobin value. Iron supplements have been prescribed. Please continue to monitor the values.';
    const String doctorNotesFR = 'Valeur d\'hémoglobine légèrement diminuée. Des suppléments de fer ont été prescrits. Veuillez continuer à surveiller les valeurs.';

    // Ultraschall-Notizen in allen Sprachen
    final Map<int, String> ultrasoundNotesDE = {
      0: 'Alle Wachstumsmessungen im normalen Bereich. Fetale Aktivität und Bewegungen normal.',
      1: 'Normales Wachstum, keine Auffälligkeiten feststellbar.',
      2: 'Alle Messungen entsprechen dem Gestationsalter. Keine strukturellen Anomalien erkennbar.'
    };

    final Map<int, String> ultrasoundNotesEN = {
      0: 'All growth measurements within normal range. Fetal activity and movements normal.',
      1: 'Normal growth, no abnormalities detected.',
      2: 'All measurements correspond to gestational age. No structural anomalies visible.'
    };

    final Map<int, String> ultrasoundNotesFR = {
      0: 'Toutes les mesures de croissance dans la plage normale. Activité fœtale et mouvements normaux.',
      1: 'Croissance normale, aucune anomalie détectée.',
      2: 'Toutes les mesures correspondent à l\'âge gestationnel. Aucune anomalie structurelle visible.'
    };

    // Plazentaposition in allen Sprachen
    final Map<int, String> placentaPositionDE = {
      0: 'Vorderwand, oben',
      1: 'Vorderwand, oben',
      2: 'Vorderwand'
    };

    final Map<int, String> placentaPositionEN = {
      0: 'Anterior wall, upper',
      1: 'Anterior wall, upper',
      2: 'Anterior wall'
    };

    final Map<int, String> placentaPositionFR = {
      0: 'Paroi antérieure, supérieure',
      1: 'Paroi antérieure, supérieure',
      2: 'Paroi antérieure'
    };

    // Fetale Position in allen Sprachen
    final Map<int, String> fetalPositionDE = {
      0: 'Kopflage',
      1: 'Kopflage',
      2: 'Variabel'
    };

    final Map<int, String> fetalPositionEN = {
      0: 'Head down',
      1: 'Head down',
      2: 'Variable'
    };

    final Map<int, String> fetalPositionFR = {
      0: 'Tête en bas',
      1: 'Tête en bas',
      2: 'Variable'
    };

    // Fruchtwasser in allen Sprachen
    const String amnioticFluidDE = 'Normal';
    const String amnioticFluidEN = 'Normal';
    const String amnioticFluidFR = 'Normal';

    // Vitalwerte-Namen in allen Sprachen
    final List<String> vitalNamesDE = ['Blutdruck', 'Blutzucker', 'Gewichtszunahme', 'Hämoglobin'];
    final List<String> vitalNamesEN = ['Blood pressure', 'Blood sugar', 'Weight gain', 'Hemoglobin'];
    final List<String> vitalNamesFR = ['Tension artérielle', 'Glycémie', 'Prise de poids', 'Hémoglobine'];

    // Labortest-Namen in allen Sprachen
    final List<String> labTestNamesDE = ['Hämoglobin', 'Hämatokrit', 'Leukozyten', 'Thrombozyten', 'Glukose', 'Eisen'];
    final List<String> labTestNamesEN = ['Hemoglobin', 'Hematocrit', 'Leukocytes', 'Platelets', 'Glucose', 'Iron'];
    final List<String> labTestNamesFR = ['Hémoglobine', 'Hématocrite', 'Leucocytes', 'Plaquettes', 'Glucose', 'Fer'];

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
      insuranceName: isGerman ? 'AOK Gesundheit' : (isFrench ? 'AOK Assurance Santé' : 'AOK Health Insurance'),
      insuranceNumber: 'AOK123456789',
      allergies: ['Penicillin'],
      medications: isGerman ? medicationsDE : (isFrench ? medicationsFR : medicationsEN),

      pregnancyData: PregnancyData(
        gestationalWeeks: 28,
        dueDate: DateTime.now().add(const Duration(days: 84)), // ungefähr 12 Wochen in der Zukunft
        gravidaAndPara: 'G2P1',
        lastVisitDate: DateTime.now().subtract(const Duration(days: 14)),
        nextVisitDate: DateTime.now().add(const Duration(days: 14)),
        riskFactors: isGerman ? riskFactorsDE : (isFrench ? riskFactorsFR : riskFactorsEN),
      ),

      vitalData: [
        VitalData(
          name: isGerman ? vitalNamesDE[0] : (isFrench ? vitalNamesFR[0] : vitalNamesEN[0]),
          value: '125/82',
          unit: 'mmHg',
          date: DateTime.now().subtract(const Duration(days: 14)),
          trend: VitalTrend.stable,
          isNormal: true,
        ),
        VitalData(
          name: isGerman ? vitalNamesDE[1] : (isFrench ? vitalNamesFR[1] : vitalNamesEN[1]),
          value: '110',
          unit: 'mg/dL',
          date: DateTime.now().subtract(const Duration(days: 14)),
          trend: VitalTrend.up,
          isNormal: true,
        ),
        VitalData(
          name: isGerman ? vitalNamesDE[2] : (isFrench ? vitalNamesFR[2] : vitalNamesEN[2]),
          value: '9.5',
          unit: 'kg',
          date: DateTime.now().subtract(const Duration(days: 14)),
          trend: VitalTrend.stable,
          isNormal: true,
        ),
        VitalData(
          name: isGerman ? vitalNamesDE[3] : (isFrench ? vitalNamesFR[3] : vitalNamesEN[3]),
          value: '10.8',
          unit: 'g/dL',
          date: DateTime.now().subtract(const Duration(days: 14)),
          trend: VitalTrend.down,
          isNormal: false,
        ),
      ],

      labResults: LabResults(
        dateCollected: DateTime.now().subtract(const Duration(days: 14)),
        testCount: 12,
        hasAbnormalities: true,
        doctorNotes: isGerman ? doctorNotesDE : (isFrench ? doctorNotesFR : doctorNotesEN),
        tests: [
          LabTest(
            name: isGerman ? labTestNamesDE[0] : (isFrench ? labTestNamesFR[0] : labTestNamesEN[0]),
            result: '10.8',
            unit: 'g/dL',
            referenceRange: '11.0-15.0',
            isAbnormal: true,
          ),
          LabTest(
            name: isGerman ? labTestNamesDE[1] : (isFrench ? labTestNamesFR[1] : labTestNamesEN[1]),
            result: '33',
            unit: '%',
            referenceRange: '33-45',
            isAbnormal: false,
          ),
          LabTest(
            name: isGerman ? labTestNamesDE[2] : (isFrench ? labTestNamesFR[2] : labTestNamesEN[2]),
            result: '9.5',
            unit: '10^3/µL',
            referenceRange: '4.0-11.0',
            isAbnormal: false,
          ),
          LabTest(
            name: isGerman ? labTestNamesDE[3] : (isFrench ? labTestNamesFR[3] : labTestNamesEN[3]),
            result: '230',
            unit: '10^3/µL',
            referenceRange: '150-450',
            isAbnormal: false,
          ),
          LabTest(
            name: isGerman ? labTestNamesDE[4] : (isFrench ? labTestNamesFR[4] : labTestNamesEN[4]),
            result: '110',
            unit: 'mg/dL',
            referenceRange: '70-120',
            isAbnormal: false,
          ),
          LabTest(
            name: isGerman ? labTestNamesDE[5] : (isFrench ? labTestNamesFR[5] : labTestNamesEN[5]),
            result: '45',
            unit: 'µg/dL',
            referenceRange: '50-170',
            isAbnormal: true,
          ),
        ],
      ),

      ultrasoundData: [
        UltrasoundData(
          date: DateTime.now().subtract(const Duration(days: 14)),
          gestationalWeek: 28,
          estimatedWeight: 1100,
          fetalHeartRate: 150,
          fetalLength: 38,
          headCircumference: 27,
          abdominalCircumference: 23,
          fetalPosition: isGerman ? fetalPositionDE[0] ?? 'Kopflage' : (isFrench ? fetalPositionFR[0] ?? 'Tête en bas' : fetalPositionEN[0] ?? 'Head down'),
          placentaPosition: isGerman ? placentaPositionDE[0] ?? 'Vorderwand, oben' : (isFrench ? placentaPositionFR[0] ?? 'Paroi antérieure, supérieure' : placentaPositionEN[0] ?? 'Anterior wall, upper'),
          amnioticFluid: isGerman ? amnioticFluidDE : (isFrench ? amnioticFluidFR : amnioticFluidEN),
          notes: isGerman ? (ultrasoundNotesDE[0] ?? '') : (isFrench ? (ultrasoundNotesFR[0] ?? '') : (ultrasoundNotesEN[0] ?? '')),
        ),
        UltrasoundData(
          date: DateTime.now().subtract(const Duration(days: 42)), // -6 Wochen
          gestationalWeek: 22,
          estimatedWeight: 680,
          fetalHeartRate: 148,
          fetalLength: 32,
          headCircumference: 22,
          abdominalCircumference: 19,
          fetalPosition: isGerman ? fetalPositionDE[1] ?? 'Kopflage' : (isFrench ? fetalPositionFR[1] ?? 'Tête en bas' : fetalPositionEN[1] ?? 'Head down'),
          placentaPosition: isGerman ? placentaPositionDE[1] ?? 'Vorderwand, oben' : (isFrench ? placentaPositionFR[1] ?? 'Paroi antérieure, supérieure' : placentaPositionEN[1] ?? 'Anterior wall, upper'),
          amnioticFluid: isGerman ? amnioticFluidDE : (isFrench ? amnioticFluidFR : amnioticFluidEN),
          notes: isGerman ? (ultrasoundNotesDE[1] ?? '') : (isFrench ? (ultrasoundNotesFR[1] ?? '') : (ultrasoundNotesEN[1] ?? '')),
        ),
        UltrasoundData(
          date: DateTime.now().subtract(const Duration(days: 84)), // -12 Wochen
          gestationalWeek: 16,
          estimatedWeight: 250,
          fetalHeartRate: 155,
          fetalLength: 23,
          headCircumference: 15,
          abdominalCircumference: 13,
          fetalPosition: isGerman ? fetalPositionDE[2] ?? 'Variabel' : (isFrench ? fetalPositionFR[2] ?? 'Variable' : fetalPositionEN[2] ?? 'Variable'),
          placentaPosition: isGerman ? placentaPositionDE[2] ?? 'Vorderwand' : (isFrench ? placentaPositionFR[2] ?? 'Paroi antérieure' : placentaPositionEN[2] ?? 'Anterior wall'),
          amnioticFluid: isGerman ? amnioticFluidDE : (isFrench ? amnioticFluidFR : amnioticFluidEN),
          notes: isGerman ? (ultrasoundNotesDE[2] ?? '') : (isFrench ? (ultrasoundNotesFR[2] ?? '') : (ultrasoundNotesEN[2] ?? '')),
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

  // Lokalisierte Anzeige des Gestationsalters
  String getFormattedGestationalAge(BuildContext context) {
    return '${gestationalWeeks} ${context.tr('weeks')}';
  }
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

  // Lokalisierte Trendbezeichnung
  String getTrendName(BuildContext context) {
    switch (trend) {
      case VitalTrend.up:
        return context.tr('increasing');
      case VitalTrend.down:
        return context.tr('decreasing');
      case VitalTrend.stable:
        return context.tr('stable');
    }
  }
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

  // Lokalisierte Status-Anzeige
  String getStatusText(BuildContext context) {
    return hasAbnormalities
        ? context.tr('someAbnormalResults')
        : context.tr('allResultsNormal');
  }
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

  // Lokalisierter Status
  String getStatusText(BuildContext context) {
    return isAbnormal ? context.tr('abnormal') : context.tr('normal');
  }
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

  // Lokalisierte Anzeige des Gestationsalters
  String getFormattedGestationalWeek(BuildContext context) {
    return '${context.tr('week')} $gestationalWeek';
  }

  // Lokalisierte Formatierung des geschätzten Gewichts
  String getFormattedWeight(BuildContext context) {
    return '$estimatedWeight g';
  }
}