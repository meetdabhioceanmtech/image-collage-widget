import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:test_package/cubit/collage_cubit_cubit.dart';
import 'package:test_package/model/image_model.dart';

class CollageWidget {
  Widget commonCollageShow({
    required BuildContext context,
    bool isDisabled = false,
    required bool isColorShow,
    required CollageCubit collageCubit,
    required Collage collageData,
  }) {
    return BlocBuilder<CollageCubit, CollageCubitState>(
      bloc: collageCubit,
      builder: (context, state) {
        if (state is ImageListState) {
          return AspectRatio(
            aspectRatio: 1.0 / 1.0,
            child: StaggeredGrid.count(
              // key: UniqueKey(),
              crossAxisCount: collageData.maincrossAxisCellCount,
              axisDirection: AxisDirection.down,
              children: List.generate(
                collageData.tiles.length,
                (index) {
                  CollageTileData tiles = collageData.tiles[index];
                  return StaggeredGridTile.count(
                    crossAxisCellCount: tiles.crossAxisCellCount,
                    mainAxisCellCount: tiles.mainAxisCellCount,
                    child: buildRow(
                      state: state,
                      index: index,
                      isDisabled: isDisabled,
                      context: context,
                      tiles: tiles,
                      isColorShow: isColorShow,
                      collageCubit: collageCubit,
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  ///Build UI either image is selected or not
  buildRow({
    required int index,
    required bool isDisabled,
    required BuildContext context,
    required ImageListState state,
    required bool isColorShow,
    required CollageCubit collageCubit,
    required CollageTileData tiles,
  }) {
    return Container(
      color: isColorShow ? state.color : Colors.transparent,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.all(3),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(isDisabled ? 3 : 5)),
              child: tiles.imagePath != '' && !isDisabled
                  ? Image.file(
                      File(tiles.imagePath),
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: const Color(0xFFD3D3D3),
                      child: isDisabled ? null : const Icon(Icons.add),
                    ),
            ),
          ),
          if (!isDisabled)
            Positioned.fill(
              child: Material(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color: Colors.transparent,
                child: InkWell(
                  highlightColor: Colors.transparent,
                  onTap: () => showImagePickerDialog(
                    index: index,
                    context: context,
                    tiles: tiles,
                    state: state,
                    collageCubit: collageCubit,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  showImagePickerDialog({
    required int index,
    required BuildContext context,
    // required List<Images> imageList,
    required ImageListState state,
    required CollageCubit collageCubit,
    required CollageTileData tiles,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          contentPadding: const EdgeInsets.all(5),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildDialogOption(
                  index: index,
                  isForStorage: false,
                  context: context,
                  state: state,
                  collageCubit: collageCubit,
                  permissionType: PermissionType.camera,
                ),
                buildDialogOption(
                  index: index,
                  isForStorage: true,
                  context: context,
                  state: state,
                  collageCubit: collageCubit,
                  permissionType: PermissionType.gallery,
                ),
                tiles.imagePath != ''
                    ? buildDialogOption(
                        context: context,
                        index: index,
                        state: state,
                        permissionType: PermissionType.removeImage,
                        collageCubit: collageCubit,
                      )
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }

  ///Show dialog
  buildDialogOption({
    required int index,
    bool isForStorage = true,
    required BuildContext context,
    required ImageListState state,
    required PermissionType permissionType,
    required CollageCubit collageCubit,
  }) {
    return TextButton(
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop(true);
        permissionType == PermissionType.removeImage
            ? collageCubit.dispatchRemovePhotoEvent(
                state: state,
                index: index,
              )
            : collageCubit.openPicker(
                state: state,
                permissionType: permissionType,
                index: index,
              );
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(
                permissionType == PermissionType.removeImage
                    ? Icons.clear
                    : isForStorage
                        ? Icons.photo_album
                        : Icons.add_a_photo,
                color: permissionType == PermissionType.removeImage
                    ? Colors.red
                    : isForStorage
                        ? Colors.amber
                        : Colors.blue,
              ),
            ),
            Text(
              permissionType == PermissionType.removeImage
                  ? "Remove"
                  : isForStorage
                      ? "Gallery"
                      : "Camera",
            )
          ],
        ),
      ),
    );
  }
}
