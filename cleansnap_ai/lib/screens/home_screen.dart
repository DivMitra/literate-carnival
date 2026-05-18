import 'package:flutter/material.dart';
import '../models/file_model.dart';
import 'results_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isScanning = false;
  List<FileItem> junkFiles = [];
  double totalSizeGB = 0;

  Future<void> scanPhotos() async {
    setState(() {
      isScanning = true;
    });

    // Simulate scanning delay
    await Future.delayed(const Duration(seconds: 3));

    // Mock AI results
    junkFiles = [
      FileItem(
        type: 'Duplicates',
        sizeGB: 3.2,
        count: 145,
        isSelected: true,
      ),
      FileItem(
        type: 'Blurry Photos',
        sizeGB: 1.1,
        count: 52,
        isSelected: true,
      ),
      FileItem(
        type: 'Screenshots',
        sizeGB: 2.5,
        count: 234,
        isSelected: true,
      ),
      FileItem(
        type: 'Large Videos',
        sizeGB: 5.8,
        count: 18,
        isSelected: false,
      ),
      FileItem(
        type: 'Old Downloads',
        sizeGB: 1.9,
        count: 67,
        isSelected: true,
      ),
    ];

    calculateTotalSize();

    setState(() {
      isScanning = false;
    });

    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsScreen(
            files: junkFiles,
            onClean: _handleClean,
          ),
        ),
      );
    }
  }

  void calculateTotalSize() {
    totalSizeGB = junkFiles.fold(0, (sum, file) => sum + file.sizeGB);
  }

  void _handleClean(List<FileItem> filesToClean) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Cleaned ${filesToClean.length} categories! Storage freed 🚀',
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CleanSnap AI',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings coming soon!')),
              );
            },
          ),
        ],
      ),
      body: isScanning
          ? _buildScanningScreen()
          : _buildIdleScreen(),
    );
  }

  Widget _buildIdleScreen() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.cleaning_services,
                  size: 60,
                  color: Colors.blue.shade700,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Free Up Storage Space',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Remove duplicates, blurry photos, and junk files with AI-powered analysis',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              ElevatedButton.icon(
                onPressed: scanPhotos,
                icon: const Icon(Icons.search),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  child: Text(
                    'Start Scan',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 48),
              _buildFeaturesList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScanningScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            strokeWidth: 3,
          ),
          const SizedBox(height: 24),
          const Text(
            'Scanning Your Device...',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Analyzing photos and files',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesList() {
    final features = [
      {'icon': Icons.copy, 'title': 'Find Duplicates', 'subtitle': 'Same photos stored multiple times'},
      {'icon': Icons.blur_on, 'title': 'Detect Blurry', 'subtitle': 'AI-powered blur detection'},
      {'icon': Icons.video_library, 'title': 'Remove Large Files', 'subtitle': 'Free up space instantly'},
    ];

    return Column(
      children: features.map((feature) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  feature['icon'] as IconData,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feature['title'].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      feature['subtitle'].toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
