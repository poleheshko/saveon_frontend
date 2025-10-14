class Album {
  final int id;
  final String name;
  final String iconPath;

  Album({
    required this.id,
    required this.name,
    required this.iconPath,
  });
}

List<Album> ListAlbums =[
  Album(
    id: 1,
    name: "Vacation Greece 2025",
    iconPath: "lib/assets/album_icons/album_purple.svg",
  ),
  Album(
    id: 2,
    name: "New Year Party",
    iconPath: "lib/assets/album_icons/album_orange.svg",
  ),
  Album(
    id: 3,
    name: "Investments in the future",
    iconPath: "lib/assets/album_icons/album_black.svg",
  )
];