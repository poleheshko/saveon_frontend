class AlbumType {
  final int albumId;
  final String albumName;
  final String albumIconPath;

  AlbumType({
    required this.albumId,
    required this.albumName,
    required this.albumIconPath,
  });
}

List<AlbumType> ListOfAlbums =[
  AlbumType(
    albumId: 1,
    albumName: "Vacation Greece 2025",
    albumIconPath: "lib/assets/album_icons/album_purple.svg",
  ),
  AlbumType(
    albumId: 2,
    albumName: "New Year Party",
    albumIconPath: "lib/assets/album_icons/album_orange.svg",
  ),
  AlbumType(
    albumId: 3,
    albumName: "Investments in the future",
    albumIconPath: "lib/assets/album_icons/album_black.svg",
  )
];