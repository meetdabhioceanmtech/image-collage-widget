import 'dart:io';
import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_collage_widget/utils/permission_type.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_package/model/image_model.dart';
part 'collage_cubit_state.dart';

enum CollageType {
  vSplit,
  hSplit,
  fourSquare,
  nineSquare,
  threeVertical,
  leftBig,
  rightBig,
  threeHorizontal,
  fourLeftBig,
  vMiddleTwo,
  centerBig
}

enum ImageSource { camera, gallery }

class CollageCubit extends Cubit<CollageCubitState> {
  CollageCubit() : super(CollageCubitInitial());

  void inistall({required CollageType selectedCollageType}) {
    Map<String, List<Images>> allImageSave = {};
    for (var collage in CollageType.values) {
      List<Images> tempImageList = <Images>[];
      for (int i = 0; i < getImageCount(collageType: collage); i++) {
        var images = Images();
        images.id = i + 1;
        tempImageList.add(images);
      }
      allImageSave.addAll({collage.toString(): tempImageList});
    }
    emit(
      ImageListState(
        allImageSave: allImageSave,
        selectedImage: allImageSave[selectedCollageType.toString()] ?? [],
        selectedCollageType: CollageType.values.first,
        random: Random().nextDouble(),
      ),
    );
  }

  void openPicker({
    required PermissionType permissionType,
    required int index,
    required CollageType selectedCollageType,
    required ImageListState state,
  }) async {
    XFile? image = await ImagePicker().pickImage(
      source: permissionType == PermissionType.storage
          ? ImageSource.gallery
          : ImageSource.camera,
    );

    if (image != null) {
      Map<String, List<Images>> updatedAllImageSave = {};

      for (var entry in state.allImageSave.entries) {
        List<Images> tempList = entry.value;
        if (tempList.length > index) {
          tempList[index].imageUrl = File(image.path);
        }
        updatedAllImageSave[entry.key] = tempList;
      }

      emit(
        state.copyWith(
          allImageSave: updatedAllImageSave,
          selectedCollageType: selectedCollageType,
          random: Random().nextDouble(),
        ),
      );
    }
  }

  void dispatchRemovePhotoEvent({
    required int index,
    required CollageType selectedCollageType,
    required ImageListState state,
  }) {
    Map<String, List<Images>> allImageSave = {};
    List<Images> imageList = [];
    allImageSave.addAll(state.allImageSave);
    imageList.addAll(allImageSave[selectedCollageType.toString()] ?? []);

    imageList[index].imageUrl = null;
    allImageSave.update(selectedCollageType.toString(), (value) => imageList);

    emit(
      state.copyWith(
        allImageSave: allImageSave,
        selectedCollageType: selectedCollageType,
        random: Random().nextDouble(),
      ),
    );
  }

  ///Show blank images (Thumbnails)
  void blankList({
    required CollageType selectedCollageType,
    required ImageListState state,
  }) {
    List<Images>? selectedImage =
        state.allImageSave[selectedCollageType.toString()];
    emit(
      state.copyWith(
        allImageSave: state.allImageSave,
        selectedImage: selectedImage,
        selectedCollageType: selectedCollageType,
        random: Random().nextDouble(),
      ),
    );
  }

  /// The no. of image return as per collage type.
  int getImageCount({required CollageType collageType}) {
    if (collageType == CollageType.hSplit ||
        collageType == CollageType.vSplit) {
      return 2;
    } else if (collageType == CollageType.fourSquare ||
        collageType == CollageType.fourLeftBig) {
      return 4;
    } else if (collageType == CollageType.nineSquare) {
      return 9;
    } else if (collageType == CollageType.threeVertical ||
        collageType == CollageType.threeHorizontal) {
      return 3;
    } else if (collageType == CollageType.leftBig ||
        collageType == CollageType.rightBig) {
      return 6;
    } else if (collageType == CollageType.vMiddleTwo ||
        collageType == CollageType.centerBig) {
      return 7;
    }
    return 0;
  }

  int getCellCount({
    required int index,
    required bool isForCrossAxis,
    required CollageType type,
  }) {
    /// total cell count :- 2
    /// Column and Row :- 2*1 = 2 (Cross axis count)

    if (type == CollageType.vSplit) {
      if (isForCrossAxis) {
        /// Cross axis cell count
        return 1;
      } else {
        /// Main axis cell count
        return 2;
      }
    }

    /// total cell count :- 2
    /// Column and Row :- 1*2 = 2 (Cross axis count)

    else if (type == CollageType.hSplit) {
      if (isForCrossAxis) {
        /// Cross axis cell count
        return 2;
      } else {
        /// Main axis cell count
        return 1;
      }
    }

    /// total cell count :- 4
    /// Column and Row :- 2*2 (Cross axis count)

    else if (type == CollageType.fourSquare) {
      /// cross axis and main axis cell count
      return 2;
    }

    /// total cell count :- 9
    /// Column and Row :- 3*3 (Cross axis count)
    else if (type == CollageType.nineSquare) {
      return 3;
    }

    /// total cell count :- 3
    /// Column and Row :- 2 * 2
    /// First index taking 2 cell count in main axis and also in cross axis.
    else if (type == CollageType.threeVertical) {
      if (isForCrossAxis) {
        return 1;
      } else {
        return (index == 0) ? 2 : 1;
      }
    } else if (type == CollageType.threeHorizontal) {
      if (isForCrossAxis) {
        return (index == 0) ? 2 : 1;
      } else {
        return 1;
      }
    }

    /// total cell count :- 6
    /// Column and Row :- 3 * 3
    /// First index taking 2 cell in main axis and also in cross axis.
    /// Cross axis count = 3

    else if (type == CollageType.leftBig) {
      if (isForCrossAxis) {
        return (index == 0) ? 2 : 1;
      } else {
        return (index == 0) ? 2 : 1;
      }
    } else if (type == CollageType.rightBig) {
      if (isForCrossAxis) {
        return (index == 1) ? 2 : 1;
      } else {
        return (index == 1) ? 2 : 1;
      }
    } else if (type == CollageType.fourLeftBig) {
      if (isForCrossAxis) {
        return (index == 0) ? 2 : 1;
      } else {
        return (index == 0) ? 3 : 1;
      }

      /// total tile count (image count)--> 7
      /// Column: Row (2:3)
      /// First column :- 3 tile
      /// Second column :- 4 tile
      /// First column 3 tile taking second column's 4 tile space. So total tile count is 4*3=12(cross axis count).
      /// First column each cross axis tile count = cross axis count/ total tile count(In cross axis)  {12/3 = 4]
      /// Second column cross axis cell count :- 12/4 = 3
      /// Main axis count : Cross axis count / column count {12/2 = 6}
    } else if (type == CollageType.vMiddleTwo) {
      if (isForCrossAxis) {
        return 6;
      } else {
        return (index == 0 || index == 3 || index == 5) ? 4 : 3;
      }
    }

    /// total tile count (image count)--> 7
    /// left, right and center  - 3/3/1
    /// total column:- 3
    /// total row :- 4 (total row is 3 but column 2 taking 2 row space so left + center + right = 1+2+1 {4}).
    /// cross axis count = total column * total row {3*4 = 12}.
    /// First/Third column each cross axis tile count = cross axis count / total tile count(In cross axis) = 12 / 3 = 4
    /// First/Third column each main axis tile count = cross axis count / total tile count(In main axis) = 12 / 4 = 3
    /// Second each cross axis tile count = cross axis count / total tile count(In cross axis) = 12/1 = 12
    /// Second each main axis tile count = cross axis count / total tile count(In main axis) = 12/2 = 6

    else if (type == CollageType.centerBig) {
      if (isForCrossAxis) {
        return (index == 1) ? 6 : 3;
      } else {
        return (index == 1) ? 12 : 4;
      }
    }
    return 0;
  }

  ///Find cross axis count for arrange items to Grid
  int getCrossAxisCount({required CollageType type}) {
    // Use crossAxisCount based on collage type
    if (type == CollageType.hSplit ||
        type == CollageType.vSplit ||
        type == CollageType.threeHorizontal ||
        type == CollageType.threeVertical) {
      return 2;
    } else if (type == CollageType.fourSquare) {
      return 4;
    } else if (type == CollageType.nineSquare) {
      return 9;
    } else if (type == CollageType.leftBig || type == CollageType.rightBig) {
      return 3;
    } else if (type == CollageType.fourLeftBig) {
      return 3;
    } else if (type == CollageType.vMiddleTwo ||
        type == CollageType.centerBig) {
      return 12;
    }
    return 0;
  }
}
