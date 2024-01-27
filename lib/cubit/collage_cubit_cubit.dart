// ignore_for_file: invalid_use_of_visible_for_testing_member, deprecated_member_use

import 'dart:io';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_collage_widget/model/college_type.dart';
import 'package:image_collage_widget/model/images.dart';
import 'package:image_collage_widget/utils/permission_type.dart';
import 'package:image_picker/image_picker.dart';

part 'collage_cubit_state.dart';

class CollageCubit extends Cubit<CollageCubitState> {
  final CollageType collageType;
  String path;

  CollageCubit({required this.collageType, required this.path}) : super(const ImageListState(images: []));

  void openPicker({required PermissionType permissionType, required int index}) async {
    PickedFile? image = await ImagePicker.platform.pickImage(
      source: permissionType == PermissionType.storage ? ImageSource.gallery : ImageSource.camera,
    );

    if (image != null) {
      var imageList = (state as ImageListState).images;
      imageList[index].imageUrl = File(image.path);
      // add(ImageListEvent(imageList));

      if (state is ImageListState) {
        var loadeState = state as ImageListState;
        emit(loadeState.copyWith(images: imageList, random: Random().nextDouble()));
      } else {
        emit(ImageListState(images: imageList, random: Random().nextDouble()));
      }
    }
  }

  void dispatchRemovePhotoEvent({required int index}) {
    var imageList = (state as ImageListState).images;
    imageList[index].imageUrl = null;
    if (state is ImageListState) {
      var loadeState = state as ImageListState;
      emit(loadeState.copyWith(images: imageList, random: Random().nextDouble()));
    } else {
      emit(ImageListState(images: imageList, random: Random().nextDouble()));
    }
  }

  ///Show blank images (Thumbnails)
  void blankList() {
    if (state is ImageListState) { 
      var loadeState = state as ImageListState;
      var tempImageList = <Images>[];
      if (loadeState.images.isEmpty || loadeState.images == []) {
        for (int i = 0; i < getImageCount(); i++) {
          var images = Images();
          images.id = i + 1;
          tempImageList.add(images);
        }
      } else {
        tempImageList.addAll(loadeState.images);
      }
      emit(loadeState.copyWith(images: tempImageList, random: Random().nextDouble()));
    } else {
      var tempImageList = <Images>[];
      for (int i = 0; i < getImageCount(); i++) {
        var images = Images();
        images.id = i + 1;
        tempImageList.add(images);
      }

      emit(ImageListState(images: tempImageList));
    }
  }

  /// The no. of image return as per collage type.
  getImageCount() {
    if (collageType == CollageType.hSplit || collageType == CollageType.vSplit) {
      return 2;
    } else if (collageType == CollageType.fourSquare || collageType == CollageType.fourLeftBig) {
      return 4;
    } else if (collageType == CollageType.nineSquare) {
      return 9;
    } else if (collageType == CollageType.threeVertical || collageType == CollageType.threeHorizontal) {
      return 3;
    } else if (collageType == CollageType.leftBig || collageType == CollageType.rightBig) {
      return 6;
    } else if (collageType == CollageType.vMiddleTwo || collageType == CollageType.centerBig) {
      return 7;
    }
  }

  // Future loadImages(String path, int maxCount) async {
  //   var path = await FilePicker.platform.getDirectoryPath();
  //   var root = Directory(path ?? '$path/DCIM/Camera');

  //   await root.exists().then((isExist) async {
  //     int maxImage = maxCount;
  //     var listImage = blankList();
  //     if (isExist) {
  //       FilePickerResult? result = await FilePicker.platform.pickFiles(
  //         type: FileType.custom,
  //         allowedExtensions: ['jpeg', 'png', 'jpg'],
  //       );

  //       List<File> files = result!.paths.map((path) => File(path ?? '')).toList();
  //       debugPrint('file length---> ${files.length}');

  //       /// [file] by default will return old images.
  //       /// for getting latest max number of photos [file.sublist(file.length - maxImage, file.length)]

  //       List<File> filesList =
  //           files.length > maxImage ? files.sublist(files.length - (maxImage + 1), files.length - 1) : files;

  //       for (int i = 0; i < filesList.length; i++) {
  //         listImage[i].imageUrl = File(filesList[i].path);
  //       }
  //     }

  //     add(ImageListEvent(listImage));
  //   });
  // }
}
