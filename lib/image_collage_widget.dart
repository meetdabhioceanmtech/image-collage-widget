library image_collage_widget;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_collage_widget/cubit/collage_cubit_cubit.dart';
import 'package:image_collage_widget/model/college_type.dart';
import 'widgets/row_widget.dart';

class ImageCollageWidget extends StatefulWidget {
  final String? filePath;
  final CollageType collageType;
  final bool withImage;
  final bool isDisabled;
  const ImageCollageWidget({
    super.key,
    this.filePath,
    required this.collageType,
    required this.withImage,
    required this.isDisabled,
  });

  @override
  State<ImageCollageWidget> createState() => _ImageCollageWidgetState();
}

class _ImageCollageWidgetState extends State<ImageCollageWidget> with WidgetsBindingObserver {
  late final String _filePath;
  late final CollageType _collageType;

  @override
  void initState() {
    _filePath = widget.filePath ?? '';
    _collageType = widget.collageType;
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CollageCubit(collageType: _collageType, path: _filePath),
      child: ImageCollageWidgetSub(
        collageType: widget.collageType,
        isDisabled: widget.isDisabled,
        withImage: widget.withImage,
        filePath: widget.filePath,
      ),
    );
  }
}

/// A ImageCollageWidget.
class ImageCollageWidgetSub extends StatefulWidget {
  final String? filePath;
  final CollageType collageType;
  final bool withImage;
  final bool isDisabled;

  const ImageCollageWidgetSub({
    super.key,
    this.filePath,
    required this.collageType,
    required this.withImage,
    required this.isDisabled,
  });

  @override
  State<StatefulWidget> createState() => _ImageCollageWidget();
}

class _ImageCollageWidget extends State<ImageCollageWidgetSub> with WidgetsBindingObserver {
  late final CollageType _collageType;
  late CollageCubit _collageCubit;

  @override
  void initState() {
    _collageCubit = BlocProvider.of<CollageCubit>(context, listen: false);
    _collageType = widget.collageType;
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    _collageCubit.blankList();
    // _imageListBloc = CollageBloc(context: context, path: _filePath, collageType: _collageType);
    // _imageListBloc.add(ImageListEvent(_imageListBloc.blankList()));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _collageCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollageCubit, CollageCubitState>(
      bloc: _collageCubit,
      builder: (context, state) {
        if (state is PermissionDeniedState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("To show images you have to allow storage permission."),
                TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))),
                  child: const Text("Allow"),
                  onPressed: () => _handlePermission(),
                ),
              ],
            ),
          );
        }
        if (state is CollageLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ImageListState) {
          return _gridView(state: state);
        }
        return const SizedBox.shrink();
      },
    );
  }

  void _handlePermission() {
    // _imageListBloc.add(CheckPermissionEvent(true, PermissionType.storage, 0));
  }

  Widget _gridView({required ImageListState state}) {
    return AspectRatio(
      aspectRatio: 1.0 / 1.0,
      child: GridCollageWidget(
        context,
        collageType: _collageType,
        collageCubit: _collageCubit,
        isDisabled: widget.isDisabled,
      ),
    );
  }
}
