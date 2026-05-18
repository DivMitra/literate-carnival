import 'package:flutter/material.dart';
import '../models/file_model.dart';

class ResultsScreen extends StatefulWidget {
  final List<FileItem> files;
  final Function(List<FileItem>) onClean;

  const ResultsScreen({
    Key? key,
    required this.files,
    required this.onClean,
  }) : super(key: key);

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  late List<FileItem> _files;

  @override
  void initState() {
    super.initState();
    _files = List.from(widget.files);
  }

  double getTotalSizeGB() {
    return _files
        .where((file) => file.isSelected)
        .fold(0, (sum, file) => sum + file.sizeGB);
  }

  int getTotalCount() {
    return _files
        .where((file) => file.isSelected)
        .fold(0, (sum, file) => sum + file.count);
  }

  void _toggleFile(int index) {
    setState(() {
      _files[index].isSelected = !_files[index].isSelected;
    });
  }

  void _selectAll() {
    setState(() {
      for (var file in _files) {
        file.isSelected = true;
      }
    });
  }

  void _deselectAll() {
    setState(() {
      for (var file in _files) {
        file.isSelected = false;
      }
    });
  }

  void _cleanFiles() async {
    final selectedFiles = _files.where((f) => f.isSelected).toList();
    if (selectedFiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select files to clean')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Cleanup'),
        content: Text(
          'Delete ${selectedFiles.length} items and free ${getTotalSizeGB().toStringAsFixed(2)} GB?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _performCleanup(selectedFiles);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _performCleanup(List<FileItem> files) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            const Text('Cleaning...'),
          ],
        ),
      ),
    );

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.pop(context);
      widget.onClean(files);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Scan Results'),
          elevation: 0,
        ),
        body: Column(
          children: [
            // Summary Card
            Container(
              padding: const EdgeInsets.all(24),
              color: Colors.blue.shade50,
              child: Column(
                children: [
                  Text(
                    'Total Cleanup',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${getTotalSizeGB().toStringAsFixed(2)} GB',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${getTotalCount()} files selected',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _selectAll,
                      child: const Text('Select All'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _deselectAll,
                      child: const Text('Deselect All'),
                    ),
                  ),
                ],
              ),
            ),
            // File List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _files.length,
                itemBuilder: (context, index) {
                  return _buildFileCard(index);
                },
              ),
            ),
            // Clean Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _cleanFiles,
                  icon: const Icon(Icons.delete),
                  label: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text('Clean Selected Files'),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileCard(int index) {
    final file = _files[index];
    final IconData icon = _getIconForType(file.type);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: CheckboxListTile(
        value: file.isSelected,
        onChanged: (_) => _toggleFile(index),
        title: Text(
          file.type,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${file.count} files • ${file.sizeGB.toStringAsFixed(2)} GB',
        ),
        secondary: Icon(icon, color: Colors.blue),
        contentPadding: const EdgeInsets.all(8),
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'Duplicates':
        return Icons.copy;
      case 'Blurry Photos':
        return Icons.blur_on;
      case 'Screenshots':
        return Icons.screenshot;
      case 'Large Videos':
        return Icons.video_library;
      case 'Old Downloads':
        return Icons.download;
      default:
        return Icons.file_copy;
    }
  }
}
