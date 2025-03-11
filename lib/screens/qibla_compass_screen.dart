import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class QiblaCompassScreen extends StatefulWidget {
  const QiblaCompassScreen({Key? key}) : super(key: key);

  @override
  _QiblaCompassScreenState createState() => _QiblaCompassScreenState();
}

class _QiblaCompassScreenState extends State<QiblaCompassScreen> {
  bool _hasPermissions = false;
  double _direction = 0;
  double _qiblaDirection = 0;
  Position? _currentPosition;
  bool _isLoading = true;
  String _status = "Loading...";

  // Kaaba coordinates
  final double kaabaLat = 21.4225;
  final double kaabaLng = 39.8262;

  @override
  void initState() {
    super.initState();
    _checkAndRequestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qibla Compass'),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) {
          if (_isLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 20),
                  Text(_status, style: const TextStyle(fontSize: 18)),
                ],
              ),
            );
          }

          if (!_hasPermissions) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Location and sensors permissions are required',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _checkAndRequestPermissions,
                    child: const Text('Request Permissions'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: StreamBuilder<CompassEvent>(
                  stream: FlutterCompass.events,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    _direction = snapshot.data?.heading ?? 0;

                    // Calculate the angle to point to Qibla relative to current compass direction
                    double qiblaAngle = (_qiblaDirection - _direction) % 360;

                    return Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade200,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Compass outer circle
                                Container(
                                  width: 280,
                                  height: 280,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey.shade400,
                                      width: 2,
                                    ),
                                  ),
                                ),

                                // Compass cardinal points
                                Positioned(
                                    top: 20,
                                    child: Text('N', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
                                ),
                                Positioned(
                                    bottom: 20,
                                    child: Text('S', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
                                ),
                                Positioned(
                                    right: 20,
                                    child: Text('E', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
                                ),
                                Positioned(
                                    left: 20,
                                    child: Text('W', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
                                ),

                                // Rotating compass elements (showing true north)
                                Transform.rotate(
                                  angle: (_direction * (pi / 180) * -1),
                                  child: CustomPaint(
                                    size: const Size(240, 240),
                                    painter: CompassPainter(),
                                  ),
                                ),

                                // Qibla direction indicator
                                Transform.rotate(
                                  angle: (qiblaAngle * (pi / 180) * -1),
                                  child: Container(
                                    width: 280,
                                    height: 280,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Positioned(
                                          top: 0,
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              shape: BoxShape.circle,
                                            ),
                                            // child: Icon(
                                            //   Icons.location_on,
                                            //   color: Colors.white,
                                            //   size: 30,
                                            // ),
                                            child: Image.asset('assets/kaba_sharif.png', height: 30,width: 30,),
                                          ),
                                        ),
                                        // Line pointing to Qibla
                                        Positioned(
                                          top: 40,
                                          child: Container(
                                            width: 4,
                                            height: 100,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // Center point
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade800,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Qibla Direction: ${_qiblaDirection.toStringAsFixed(1)}°',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Current Direction: ${_direction.toStringAsFixed(1)}°',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Point the green arrow towards the Kaaba',
                      style: const TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _recalculateQibla,
                      child: const Text('Recalculate Qibla Direction'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _checkAndRequestPermissions() async {
    setState(() {
      _isLoading = true;
      _status = "Checking permissions...";
    });

    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _status = "Location services are disabled";
        _isLoading = false;
        _hasPermissions = false;
      });
      // Show dialog to open location settings
      await _showLocationServicesDialog();
      return;
    }

    // Check location permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _status = "Location permission denied";
          _isLoading = false;
          _hasPermissions = false;
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _status = "Location permissions permanently denied";
        _isLoading = false;
        _hasPermissions = false;
      });
      // Show dialog to open app settings
      await _showAppSettingsDialog();
      return;
    }

    // Check compass availability
    if (FlutterCompass.events == null) {
      setState(() {
        _status = "Compass sensor not available on this device";
        _isLoading = false;
        _hasPermissions = false;
      });
      return;
    }

    // All permissions granted and sensors available
    setState(() {
      _hasPermissions = true;
    });

    // Fetch location and calculate Qibla direction
    await _fetchCurrentLocation();
  }

  Future<void> _showLocationServicesDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Services Disabled'),
          content: const Text(
              'Location services are required for this app to function. Please enable location services in your device settings.'
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Open Settings'),
              onPressed: () {
                Navigator.of(context).pop();
                Geolocator.openLocationSettings();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAppSettingsDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Permission Required'),
          content: const Text(
              'Location permission is required for Qibla direction calculation. Please grant permission in app settings.'
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Open Settings'),
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _fetchCurrentLocation() async {
    setState(() {
      _status = "Getting your location...";
    });

    try {
      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      _calculateQiblaDirection();
    } catch (e) {
      setState(() {
        _isLoading = false;
        _status = "Error: $e";
      });
    }
  }

  void _recalculateQibla() {
    setState(() {
      _isLoading = true;
      _status = "Recalculating Qibla direction...";
    });
    _fetchCurrentLocation();
  }

  void _calculateQiblaDirection() {
    if (_currentPosition != null) {
      // Convert degrees to radians
      double lat1 = _currentPosition!.latitude * pi / 180;
      double lon1 = _currentPosition!.longitude * pi / 180;
      double lat2 = kaabaLat * pi / 180;
      double lon2 = kaabaLng * pi / 180;

      // Calculate the Qibla direction using the spherical law of cosines
      double y = sin(lon2 - lon1);
      double x = cos(lat1) * tan(lat2) - sin(lat1) * cos(lon2 - lon1);
      double qiblaRad = atan2(y, x);
      double qiblaDeg = qiblaRad * 180 / pi;

      // Normalize to 0-360
      _qiblaDirection = (qiblaDeg + 360) % 360;

      setState(() {
        _isLoading = false;
      });
    }
  }
}

class CompassPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;

    // Draw tick marks
    final tickPaint = Paint()
      ..color = Colors.grey.shade600
      ..strokeWidth = 1.5;

    for (int i = 0; i < 360; i += 15) {
      final angle = i * pi / 180;
      final outerPoint = Offset(
        center.dx + cos(angle) * radius,
        center.dy + sin(angle) * radius,
      );
      final innerPoint = Offset(
        center.dx + cos(angle) * (radius - (i % 90 == 0 ? 20 : 10)),
        center.dy + sin(angle) * (radius - (i % 90 == 0 ? 20 : 10)),
      );
      canvas.drawLine(innerPoint, outerPoint, tickPaint);

      // Draw degree numbers for major angles
      if (i % 45 == 0 && i != 0 && i != 90 && i != 180 && i != 270) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: '$i°',
            style: TextStyle(color: Colors.black87, fontSize: 12),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();

        final textPoint = Offset(
          center.dx + cos(angle) * (radius - 35) - textPainter.width / 2,
          center.dy + sin(angle) * (radius - 35) - textPainter.height / 2,
        );
        textPainter.paint(canvas, textPoint);
      }
    }
  }

  @override
  bool shouldRepaint(CompassPainter oldDelegate) => false;
}