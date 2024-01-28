part of 'collage_cubit_cubit.dart';

abstract class CollageCubitState extends Equatable {
  const CollageCubitState();

  @override
  List<Object?> get props => [];
}

class CollageCubitInitial extends CollageCubitState {}

class CollageLoadingState extends CollageCubitState {
  @override
  List<Object> get props => [];
}

class PermissionDeniedState extends CollageCubitState {
  @override
  List<Object> get props => [];
}

class ImageListState extends CollageCubitState {
  final List<Images> selectedImage;
  final CollageType selectedCollageType;
  final Map<String, List<Images>> allImageSave;
  final Color color;
  final double? random;

  const ImageListState({
    required this.selectedImage,
    required this.selectedCollageType,
    required this.allImageSave,
    required this.color,
    this.random,
  });

  ImageListState copyWith({
    List<Images>? selectedImage,
    Map<String, List<Images>>? allImageSave,
    CollageType? selectedCollageType,
    Color? color,
    double? random,
  }) {
    return ImageListState(
      selectedImage: selectedImage ?? this.selectedImage,
      selectedCollageType: selectedCollageType ?? this.selectedCollageType,
      allImageSave: allImageSave ?? this.allImageSave,
      color: color ?? this.color,
      random: random ?? this.random,
    );
  }

  @override
  List<Object?> get props => [
        selectedImage,
        selectedCollageType,
        allImageSave,
        color,
        random,
      ];
}
