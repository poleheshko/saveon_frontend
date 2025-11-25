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
        folderId: json['fodlerId'] as int,
        userId: json['userId'] as int,
        folderName: json['folderName'] as String,
        folderIconPath: json['folderIconPath'] as String,
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}