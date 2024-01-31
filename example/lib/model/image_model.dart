class Collage {
  final int id;
  final int maincrossAxisCellCount;
  final int totalImage;
  final List<CollageTileData> tiles;

  Collage({
    required this.totalImage,
    required this.maincrossAxisCellCount,
    required this.id,
    required this.tiles,
  });
}

class CollageTileData {
  final int imageId;
  final int crossAxisCellCount;
  final int mainAxisCellCount;
  String imagePath;
  CollageTileData({
    required this.imageId,
    required this.crossAxisCellCount,
    required this.mainAxisCellCount,
    required this.imagePath,
  });
}

List<Collage> dummyData = [
  Collage(
    id: 1,
    maincrossAxisCellCount: 2,
    totalImage: 2,
    tiles: [
      CollageTileData(imageId: 1, crossAxisCellCount: 1, mainAxisCellCount: 2, imagePath: ''),
      CollageTileData(imageId: 2, crossAxisCellCount: 1, mainAxisCellCount: 2, imagePath: ''),
    ],
  ),
  Collage(
    id: 2,
    maincrossAxisCellCount: 2,
    totalImage: 2,
    tiles: [
      CollageTileData(imageId: 1, crossAxisCellCount: 2, mainAxisCellCount: 1, imagePath: ''),
      CollageTileData(imageId: 2, crossAxisCellCount: 2, mainAxisCellCount: 1, imagePath: ''),
    ],
  ),
  Collage(
    id: 3,
    maincrossAxisCellCount: 2,
    totalImage: 3,
    tiles: [
      CollageTileData(imageId: 1, crossAxisCellCount: 1, mainAxisCellCount: 2, imagePath: ''),
      CollageTileData(imageId: 2, crossAxisCellCount: 1, mainAxisCellCount: 1, imagePath: ''),
      CollageTileData(imageId: 3, crossAxisCellCount: 1, mainAxisCellCount: 1, imagePath: ''),
    ],
  ),
  Collage(
    id: 4,
    maincrossAxisCellCount: 2,
    totalImage: 3,
    tiles: [
      CollageTileData(imageId: 1, crossAxisCellCount: 1, mainAxisCellCount: 1, imagePath: ''),
      CollageTileData(imageId: 2, crossAxisCellCount: 1, mainAxisCellCount: 2, imagePath: ''),
      CollageTileData(imageId: 3, crossAxisCellCount: 1, mainAxisCellCount: 1, imagePath: ''),
    ],
  ),
  Collage(
    id: 5,
    maincrossAxisCellCount: 2,
    totalImage: 3,
    tiles: [
      CollageTileData(imageId: 1, crossAxisCellCount: 2, mainAxisCellCount: 1, imagePath: ''),
      CollageTileData(imageId: 2, crossAxisCellCount: 1, mainAxisCellCount: 1, imagePath: ''),
      CollageTileData(imageId: 3, crossAxisCellCount: 1, mainAxisCellCount: 1, imagePath: ''),
    ],
  ),
  Collage(
    id: 6,
    maincrossAxisCellCount: 2,
    totalImage: 3,
    tiles: [
      CollageTileData(imageId: 1, crossAxisCellCount: 1, mainAxisCellCount: 1, imagePath: ''),
      CollageTileData(imageId: 2, crossAxisCellCount: 1, mainAxisCellCount: 1, imagePath: ''),
      CollageTileData(imageId: 3, crossAxisCellCount: 2, mainAxisCellCount: 1, imagePath: ''),
    ],
  ),
  Collage(
    id: 7,
    maincrossAxisCellCount: 2,
    totalImage: 4,
    tiles: [
      CollageTileData(imageId: 1, crossAxisCellCount: 1, mainAxisCellCount: 1, imagePath: ''),
      CollageTileData(imageId: 2, crossAxisCellCount: 1, mainAxisCellCount: 1, imagePath: ''),
      CollageTileData(imageId: 3, crossAxisCellCount: 1, mainAxisCellCount: 1, imagePath: ''),
      CollageTileData(imageId: 4, crossAxisCellCount: 1, mainAxisCellCount: 1, imagePath: ''),
    ],
  ),
  Collage(
    id: 8,
    maincrossAxisCellCount: 5,
    totalImage: 8,
    tiles: [
      CollageTileData(imageId: 1, crossAxisCellCount: 2, mainAxisCellCount: 2, imagePath: ''),
      CollageTileData(imageId: 2, crossAxisCellCount: 1, mainAxisCellCount: 2, imagePath: ''),
      CollageTileData(imageId: 3, crossAxisCellCount: 2, mainAxisCellCount: 2, imagePath: ''),
      CollageTileData(imageId: 4, crossAxisCellCount: 2, mainAxisCellCount: 2, imagePath: ''),
      CollageTileData(imageId: 5, crossAxisCellCount: 1, mainAxisCellCount: 2, imagePath: ''),
      CollageTileData(imageId: 6, crossAxisCellCount: 2, mainAxisCellCount: 2, imagePath: ''),
      CollageTileData(imageId: 7, crossAxisCellCount: 5, mainAxisCellCount: 1, imagePath: ''),
    ],
  ),
  Collage(
    id: 9,
    maincrossAxisCellCount: 5,
    totalImage: 6,
    tiles: [
      CollageTileData(imageId: 1, crossAxisCellCount: 3, mainAxisCellCount: 1, imagePath: ''),
      CollageTileData(imageId: 2, crossAxisCellCount: 2, mainAxisCellCount: 3, imagePath: ''),
      CollageTileData(imageId: 3, crossAxisCellCount: 3, mainAxisCellCount: 3, imagePath: ''),
      CollageTileData(imageId: 4, crossAxisCellCount: 2, mainAxisCellCount: 1, imagePath: ''),
      CollageTileData(imageId: 5, crossAxisCellCount: 1, mainAxisCellCount: 1, imagePath: ''),
      CollageTileData(imageId: 6, crossAxisCellCount: 4, mainAxisCellCount: 1, imagePath: ''),
    ],
  ),
  Collage(
    id: 10,
    maincrossAxisCellCount: 5,
    totalImage: 5,
    tiles: [
      CollageTileData(imageId: 1, crossAxisCellCount: 1, mainAxisCellCount: 5, imagePath: ''),
      CollageTileData(imageId: 2, crossAxisCellCount: 3, mainAxisCellCount: 2, imagePath: ''),
      CollageTileData(imageId: 3, crossAxisCellCount: 1, mainAxisCellCount: 5, imagePath: ''),
      CollageTileData(imageId: 4, crossAxisCellCount: 3, mainAxisCellCount: 1, imagePath: ''),
      CollageTileData(imageId: 5, crossAxisCellCount: 3, mainAxisCellCount: 2, imagePath: ''),
    ],
  ),
  Collage(
    id: 11,
    maincrossAxisCellCount: 5,
    totalImage: 6,
    tiles: [
      CollageTileData(imageId: 1, crossAxisCellCount: 2, mainAxisCellCount: 3, imagePath: ''),
      CollageTileData(imageId: 2, crossAxisCellCount: 1, mainAxisCellCount: 2, imagePath: ''),
      CollageTileData(imageId: 3, crossAxisCellCount: 2, mainAxisCellCount: 2, imagePath: ''),
      CollageTileData(imageId: 4, crossAxisCellCount: 3, mainAxisCellCount: 1, imagePath: ''),
      CollageTileData(imageId: 5, crossAxisCellCount: 3, mainAxisCellCount: 2, imagePath: ''),
      CollageTileData(imageId: 6, crossAxisCellCount: 2, mainAxisCellCount: 2, imagePath: ''),
    ],
  ),
];
