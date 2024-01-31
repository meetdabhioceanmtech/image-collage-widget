import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_package/model/image_model.dart';
part 'collage_cubit_state.dart';

enum PermissionType { camera, gallery, removeImage }

class CollageCubit extends Cubit<CollageCubitState> {
  CollageCubit() : super(CollageCubitInitial());

  void inistall({required int selectedCollageId}) {
    emit(ImageListState(selectedCollageId: selectedCollageId, color: Colors.white));
  }

  void changeColor({required ImageListState state, required Color color}) {
    emit(state.copyWith(color: color, random: Random().nextDouble()));
  }

  void openPicker({
    required PermissionType permissionType,
    required int index,
    required ImageListState state,
  }) async {
    XFile? image = await ImagePicker().pickImage(
      source: permissionType == PermissionType.gallery ? ImageSource.gallery : ImageSource.camera,
    );

    if (image != null) {
      for (var abc in dummyData) {
        if (abc.tiles.length > index) {
          abc.tiles[index].imagePath = image.path;
        }
      }
    }
    emit(state.copyWith(selectedCollageId: state.selectedCollageId, random: Random().nextDouble()));
  }

  void dispatchRemovePhotoEvent({
    required int index,
    required ImageListState state,
  }) {
    for (var abc in dummyData) {
      if (abc.tiles.length > index) {
        abc.tiles[index].imagePath = '';
      }
    }
    emit(state.copyWith(selectedCollageId: state.selectedCollageId, random: Random().nextDouble()));
  }

  ///Show blank images (Thumbnails)
  void blankList({
    required ImageListState state,
    required int selectedId,
  }) {
    emit(state.copyWith(selectedCollageId: selectedId, random: Random().nextDouble()));
  }
}
