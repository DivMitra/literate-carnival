class FileItem {
  final String type;
  final double sizeGB;
  final int count;
  bool isSelected;

  FileItem({
    required this.type,
    required this.sizeGB,
    required this.count,
    this.isSelected = true,
  });

  String get displaySize => '${sizeGB.toStringAsFixed(2)} GB';
  String get displayCount => '$count items';
}
