import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionInfo extends StatefulWidget {
  final TextStyle? style;
  final bool showBuildNumber;

  const VersionInfo({
    Key? key,
    this.style,
    this.showBuildNumber = false,
  }) : super(key: key);

  @override
  State<VersionInfo> createState() => _VersionInfoState();
}

class _VersionInfoState extends State<VersionInfo> {
  String _version = '';
  String _buildNumber = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getVersionInfo();
  }

  Future<void> _getVersionInfo() async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _version = packageInfo.version;
        _buildNumber = packageInfo.buildNumber;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _version = 'Unknown';
        _buildNumber = '';
        _isLoading = false;
      });
      print('Error getting package info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return SizedBox(
        height: 18,
        width: 18,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    }

    final displayText = widget.showBuildNumber
        ? 'Version $_version (Build $_buildNumber)'
        : 'Version $_version';

    return Text(
      displayText,
      style: widget.style ?? Theme.of(context).textTheme.bodySmall,
    );
  }
}