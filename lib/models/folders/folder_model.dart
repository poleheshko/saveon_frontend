class FolderModel {
  final int folderId;
  final int userId;
  final String folderName;
  final String folderIconPath;
  final DateTime createdAt;
  final DateTime updatedAt;

  FolderModel({
    required this.folderId,
    required this.userId,
    required this.folderName,
    required this.folderIconPath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FolderModel.fromJson(Map<String, dynamic> json) {
    return FolderModel(
      folderId: json['folderId'] as int? ?? json['fodlerId'] as int? ?? 0,
      userId: json['userId'] as int? ?? 0,
      folderName: json['folderName'] as String? ?? '',
      folderIconPath: json['folderIconPath'] as String? ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
    );
  }
}