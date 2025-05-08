import 'package:flutter/material.dart';
import 'package:mypd_2/screens/settings_screen.dart';
import '../utils/app_theme.dart';
import '../services/localization_service.dart';
import '../models/patient_data.dart'; // Diese Datei werden wir als nächstes erstellen

class MedicalRecordsScreen extends StatelessWidget {
  const MedicalRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Bildschirmgröße für responsive Anpassungen
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    // Responsive Textstile
    final titleFontSize = isSmallScreen ? 20.0 : 24.0;
    final subtitleFontSize = isSmallScreen ? 16.0 : 18.0;
    final bodyFontSize = isSmallScreen ? 14.0 : 16.0;
    final padding = isSmallScreen ? 12.0 : 16.0;

    // Beispiel-Patientendaten laden
    final patientData = PatientData.getSampleData(context: context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('medicalRecords'),

          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600,),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
            tooltip: context.tr('settings'),
          ),
        ],
        backgroundColor: AppTheme.primaryColor,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Patienteninformations-Karte
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                onTap: () {
                  _showPatientDetailsDialog(context, patientData);
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: isSmallScreen ? 30 : 40,
                            backgroundColor: AppTheme.primaryColor.withOpacity(0.2),
                            child: Icon(
                              Icons.person,
                              size: isSmallScreen ? 36 : 50,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                          SizedBox(width: isSmallScreen ? 12 : 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  patientData.fullName,
                                  style: TextStyle(
                                    fontSize: subtitleFontSize,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.textPrimaryColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${context.tr('age')}: ${patientData.age} ${context.tr('years')}',
                                  style: TextStyle(
                                    fontSize: bodyFontSize,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${context.tr('insuranceNumber')}: ${patientData.insuranceNumber}',
                                  style: TextStyle(
                                    fontSize: bodyFontSize,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: isSmallScreen ? 16 : 20,
                            color: AppTheme.primaryColor,
                          ),
                        ],
                      ),
                      SizedBox(height: isSmallScreen ? 12 : 16),
                      const Divider(),
                      SizedBox(height: isSmallScreen ? 8 : 12),
                      // Schwangerschaftsdaten
                      Text(
                        context.tr('pregnancyInfo'),
                        style: TextStyle(
                          fontSize: subtitleFontSize,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      SizedBox(height: isSmallScreen ? 8 : 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child:
                          _buildInfoItem(
                            context: context,
                            title: context.tr('gestationalAge'),
                            value: '${patientData.pregnancyData.gestationalWeeks} ${context.tr('weeks')}',
                            icon: Icons.calendar_today,
                            isSmallScreen: isSmallScreen,
                          ),
                          ),
                          Expanded(child:
                          _buildInfoItem(
                            context: context,
                            title: context.tr('dueDate'),
                            value: patientData.pregnancyData.dueDateFormatted,
                            icon: Icons.event,
                            isSmallScreen: isSmallScreen,
                          ),
                          ),
                        ],
                      ),
                      SizedBox(height: isSmallScreen ? 12 : 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child:
                          _buildInfoItem(
                            context: context,
                            title: context.tr('lastVisit'),
                            value: patientData.pregnancyData.lastVisitDateFormatted,
                            icon: Icons.history,
                            isSmallScreen: isSmallScreen,
                          ),
                          ),
                          Expanded(child:
                          _buildInfoItem(
                            context: context,
                            title: context.tr('nextVisit'),
                            value: patientData.pregnancyData.nextVisitDateFormatted,
                            icon: Icons.date_range,
                            isSmallScreen: isSmallScreen,
                          ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Vital-Informationen Abschnitt
            Text(
              context.tr('vitalInformation'),
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimaryColor,
              ),
            ),
            SizedBox(height: isSmallScreen ? 12 : 16),

            // Gesundheitskarten
            ...patientData.vitalData.map((vital) => _buildVitalCard(
              context: context,
              title: vital.name,
              value: vital.value,
              unit: vital.unit,
              date: vital.dateFormatted,
              trend: vital.trend,
              isNormal: vital.isNormal,
              isSmallScreen: isSmallScreen,
              padding: padding,
            )),

            const SizedBox(height: 24),

            // Labor-Ergebnisse Abschnitt
            Text(
              context.tr('labResults'),
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimaryColor,
              ),
            ),
            SizedBox(height: isSmallScreen ? 12 : 16),

            // Labor-Ergebnis-Karte
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: InkWell(
                onTap: () {
                  _showLabResultsDialog(context, patientData);
                },
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            context.tr('latestResults'),
                            style: TextStyle(
                              fontSize: subtitleFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            patientData.labResults.dateFormatted,
                            style: TextStyle(
                              fontSize: bodyFontSize,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: isSmallScreen ? 8 : 12),
                      Text(
                        '${context.tr('labTestsPerformed')}: ${patientData.labResults.testCount}',
                        style: TextStyle(
                          fontSize: bodyFontSize,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            patientData.labResults.hasAbnormalities
                                ? Icons.warning_amber_rounded
                                : Icons.check_circle_outline,
                            color: patientData.labResults.hasAbnormalities
                                ? Colors.amber
                                : Colors.green,
                            size: isSmallScreen ? 16 : 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            patientData.labResults.hasAbnormalities
                                ? context.tr('someAbnormalResults')
                                : context.tr('allResultsNormal'),
                            style: TextStyle(
                              fontSize: bodyFontSize,
                              color: patientData.labResults.hasAbnormalities
                                  ? Colors.amber[800]
                                  : Colors.green,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: isSmallScreen ? 8 : 12),
                      OutlinedButton(
                        onPressed: () {
                          _showLabResultsDialog(context, patientData);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppTheme.primaryColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(context.tr('viewDetails')),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Ultraschall-Abschnitt
            Text(
              context.tr('ultrasounds'),
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimaryColor,
              ),
            ),
            SizedBox(height: isSmallScreen ? 12 : 16),

            // Ultraschall-Karte
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: InkWell(
                onTap: () {
                  _showUltrasoundDialog(context, patientData);
                },
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            context.tr('latestUltrasound'),
                            style: TextStyle(
                              fontSize: subtitleFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            patientData.ultrasoundData.last.dateFormatted,
                            style: TextStyle(
                              fontSize: bodyFontSize,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: isSmallScreen ? 12 : 16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/ultrasound.jpg',
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 150,
                              width: double.infinity,
                              color: Colors.grey[200],
                              child: Icon(
                                Icons.image_not_supported,
                                size: 50,
                                color: Colors.grey[400],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: isSmallScreen ? 12 : 16),
                      _buildKeyValueText(
                        context.tr('estimatedWeight'),
                        '${patientData.ultrasoundData.last.estimatedWeight} g',
                        isSmallScreen: isSmallScreen,
                      ),
                      SizedBox(height: isSmallScreen ? 4 : 6),
                      _buildKeyValueText(
                        context.tr('fetalHeartRate'),
                        '${patientData.ultrasoundData.last.fetalHeartRate} bpm',
                        isSmallScreen: isSmallScreen,
                      ),
                      SizedBox(height: isSmallScreen ? 8 : 12),
                      OutlinedButton(
                        onPressed: () {
                          _showUltrasoundDialog(context, patientData);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppTheme.primaryColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(context.tr('viewAllUltrasounds')),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required BuildContext context,
    required String title,
    required String value,
    required IconData icon,
    required bool isSmallScreen,
  }) {
    return SizedBox(
      width: isSmallScreen ? 150 : 170,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: AppTheme.primaryColor,
              size: isSmallScreen ? 16 : 18,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 12 : 13,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 13 : 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVitalCard({
    required BuildContext context,
    required String title,
    required String value,
    required String unit,
    required String date,
    required VitalTrend trend,
    required bool isNormal,
    required bool isSmallScreen,
    required double padding,
  }) {
    IconData trendIcon;
    Color trendColor;

    switch (trend) {
      case VitalTrend.up:
        trendIcon = Icons.arrow_upward;
        trendColor = Colors.orange;
        break;
      case VitalTrend.down:
        trendIcon = Icons.arrow_downward;
        trendColor = Colors.blue;
        break;
      case VitalTrend.stable:
        trendIcon = Icons.drag_handle;
        trendColor = Colors.green;
        break;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isNormal ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(
                  isNormal ? Icons.check_circle_outline : Icons.warning_amber_rounded,
                  color: isNormal ? Colors.green : Colors.orange,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 14 : 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '$value $unit',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 16 : 18,
                          fontWeight: FontWeight.bold,
                          color: isNormal ? AppTheme.textPrimaryColor : Colors.orange[800],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        trendIcon,
                        color: trendColor,
                        size: isSmallScreen ? 16 : 18,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              date,
              style: TextStyle(
                fontSize: isSmallScreen ? 12 : 13,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyValueText(String key, String value, {required bool isSmallScreen}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          key,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: isSmallScreen ? 13 : 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isSmallScreen ? 13 : 14,
          ),
        ),
      ],
    );
  }

  void _showPatientDetailsDialog(BuildContext context, PatientData patientData) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: double.maxFinite,
            constraints: const BoxConstraints(maxHeight: 500),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.person, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        context.tr('patientDetails'),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isSmallScreen ? 18 : 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Personal Information
                        _buildSectionTitle(context.tr('personalInfo'), isSmallScreen),
                        const SizedBox(height: 8),
                        _buildDetailRow(context.tr('name'), patientData.fullName, isSmallScreen),
                        _buildDetailRow(context.tr('birthdate'), patientData.birthdateFormatted, isSmallScreen),
                        _buildDetailRow(context.tr('age'), '${patientData.age} ${context.tr('years')}', isSmallScreen),
                        _buildDetailRow(context.tr('bloodType'), patientData.bloodType, isSmallScreen),
                        _buildDetailRow(context.tr('height'), '${patientData.height} cm', isSmallScreen),
                        _buildDetailRow(context.tr('prePregnancyWeight'), '${patientData.prePregnancyWeight} kg', isSmallScreen),
                        _buildDetailRow(context.tr('currentWeight'), '${patientData.currentWeight} kg', isSmallScreen),
                        const SizedBox(height: 16),

                        // Contact Information
                        _buildSectionTitle(context.tr('contactInfo'), isSmallScreen),
                        const SizedBox(height: 8),
                        _buildDetailRow(context.tr('phone'), patientData.phone, isSmallScreen),
                        _buildDetailRow(context.tr('email'), patientData.email, isSmallScreen),
                        _buildDetailRow(context.tr('address'), patientData.address, isSmallScreen),
                        const SizedBox(height: 16),

                        // Medical Information
                        _buildSectionTitle(context.tr('medicalInfo'), isSmallScreen),
                        const SizedBox(height: 8),
                        _buildDetailRow(context.tr('insurance'), patientData.insuranceName, isSmallScreen),
                        _buildDetailRow(context.tr('insuranceNumber'), patientData.insuranceNumber, isSmallScreen),
                        _buildDetailRow(context.tr('allergies'), patientData.allergies.isEmpty ? context.tr('none') : patientData.allergies.join(', '), isSmallScreen),
                        _buildDetailRow(context.tr('medications'), patientData.medications.isEmpty ? context.tr('none') : patientData.medications.join(', '), isSmallScreen),
                        const SizedBox(height: 16),

                        // Pregnancy Information
                        _buildSectionTitle(context.tr('pregnancyDetails'), isSmallScreen),
                        const SizedBox(height: 8),
                        _buildDetailRow(context.tr('gestationalAge'), '${patientData.pregnancyData.gestationalWeeks} ${context.tr('weeks')}', isSmallScreen),
                        _buildDetailRow(context.tr('dueDate'), patientData.pregnancyData.dueDateFormatted, isSmallScreen),
                        _buildDetailRow(context.tr('gravidaAndPara'), patientData.pregnancyData.gravidaAndPara, isSmallScreen),
                        _buildDetailRow(context.tr('lastVisitDate'), patientData.pregnancyData.lastVisitDateFormatted, isSmallScreen),
                        _buildDetailRow(context.tr('nextVisitDate'), patientData.pregnancyData.nextVisitDateFormatted, isSmallScreen),
                        _buildDetailRow(context.tr('riskFactors'), patientData.pregnancyData.riskFactors.isEmpty ? context.tr('none') : patientData.pregnancyData.riskFactors.join(', '), isSmallScreen),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(context.tr('close')),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showLabResultsDialog(BuildContext context, PatientData patientData) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: double.maxFinite,
            constraints: const BoxConstraints(maxHeight: 500),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.science, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        context.tr('laboratoryResults'),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isSmallScreen ? 18 : 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              context.tr('dateCollected'),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: isSmallScreen ? 14 : 16,
                              ),
                            ),
                            Text(
                              patientData.labResults.dateFormatted,
                              style: TextStyle(
                                fontSize: isSmallScreen ? 14 : 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Lab Results Table
                        Table(
                          border: TableBorder.all(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                          columnWidths: const {
                            0: FlexColumnWidth(2),
                            1: FlexColumnWidth(1),
                            2: FlexColumnWidth(1),
                            3: FlexColumnWidth(1.5),
                          },
                          children: [
                            TableRow(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    context.tr('test'),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: isSmallScreen ? 12 : 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    context.tr('result'),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: isSmallScreen ? 12 : 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    context.tr('unit'),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: isSmallScreen ? 12 : 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    context.tr('referenceRange'),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: isSmallScreen ? 12 : 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            ...patientData.labResults.tests.map((test) => TableRow(
                              decoration: BoxDecoration(
                                color: test.isAbnormal ? Colors.amber.withOpacity(0.1) : null,
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    test.name,
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 12 : 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    test.result,
                                    style: TextStyle(
                                      fontWeight: test.isAbnormal ? FontWeight.bold : FontWeight.normal,
                                      color: test.isAbnormal ? Colors.red[700] : null,
                                      fontSize: isSmallScreen ? 12 : 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    test.unit,
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 12 : 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    test.referenceRange,
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 12 : 14,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                          ],
                        ),

                        const SizedBox(height: 16),
                        if (patientData.labResults.doctorNotes.isNotEmpty) ...[
                          Text(
                            context.tr('doctorNotes'),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: isSmallScreen ? 14 : 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Text(
                              patientData.labResults.doctorNotes,
                              style: TextStyle(
                                fontSize: isSmallScreen ? 13 : 14,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(context.tr('close')),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showUltrasoundDialog(BuildContext context, PatientData patientData) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: double.maxFinite,
            constraints: const BoxConstraints(maxHeight: 500),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.surround_sound_outlined, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        context.tr('ultrasoundHistory'),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isSmallScreen ? 18 : 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: patientData.ultrasoundData.length,
                    separatorBuilder: (context, index) => const Divider(height: 32),
                    itemBuilder: (context, index) {
                      final ultrasound = patientData.ultrasoundData[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${context.tr('week')} ${ultrasound.gestationalWeek}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isSmallScreen ? 16 : 18,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                              Text(
                                ultrasound.dateFormatted,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: isSmallScreen ? 12 : 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          if (index == 0) // Only show image for the most recent ultrasound
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'assets/images/ultrasound.jpg',
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 150,
                                    width: double.infinity,
                                    color: Colors.grey[200],
                                    child: Icon(
                                      Icons.image_not_supported,
                                      size: 50,
                                      color: Colors.grey[400],
                                    ),
                                  );
                                },
                              ),
                            ),
                          const SizedBox(height: 12),
                          _buildUltrasoundDetail(
                            context.tr('estimatedWeight'),
                            '${ultrasound.estimatedWeight} g',
                            isSmallScreen,
                          ),
                          _buildUltrasoundDetail(
                            context.tr('fetalHeartRate'),
                            '${ultrasound.fetalHeartRate} bpm',
                            isSmallScreen,
                          ),
                          _buildUltrasoundDetail(
                            context.tr('fetalLength'),
                            '${ultrasound.fetalLength} cm',
                            isSmallScreen,
                          ),
                          _buildUltrasoundDetail(
                            context.tr('headCircumference'),
                            '${ultrasound.headCircumference} cm',
                            isSmallScreen,
                          ),
                          _buildUltrasoundDetail(
                            context.tr('abdominalCircumference'),
                            '${ultrasound.abdominalCircumference} cm',
                            isSmallScreen,
                          ),
                          _buildUltrasoundDetail(
                            context.tr('fetalPosition'),
                            ultrasound.fetalPosition,
                            isSmallScreen,
                          ),
                          _buildUltrasoundDetail(
                            context.tr('placentaPosition'),
                            ultrasound.placentaPosition,
                            isSmallScreen,
                          ),
                          _buildUltrasoundDetail(
                            context.tr('amniotic'),
                            ultrasound.amnioticFluid,
                            isSmallScreen,
                          ),
                          if (ultrasound.notes.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Text(
                              context.tr('notes'),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: isSmallScreen ? 13 : 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              ultrasound.notes,
                              style: TextStyle(
                                fontSize: isSmallScreen ? 13 : 14,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(context.tr('close')),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title, bool isSmallScreen) {
    return Text(
      title,
      style: TextStyle(
        fontSize: isSmallScreen ? 16 : 18,
        fontWeight: FontWeight.bold,
        color: AppTheme.primaryColor,
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, bool isSmallScreen) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: isSmallScreen ? 13 : 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: isSmallScreen ? 13 : 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUltrasoundDetail(String label, String value, bool isSmallScreen) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: isSmallScreen ? 13 : 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: isSmallScreen ? 13 : 14,
            ),
          ),
        ],
      ),
    );
  }
}