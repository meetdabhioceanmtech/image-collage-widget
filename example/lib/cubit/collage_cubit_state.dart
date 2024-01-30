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
  final int selectedCollageId;
  final Color color;
  final double? random;

  const ImageListState({
    required this.selectedCollageId,
    required this.color,
    this.random,
  });

  ImageListState copyWith({
    int? selectedCollageId,
    Color? color,
    double? random,
  }) {
    return ImageListState(
      selectedCollageId: selectedCollageId ?? this.selectedCollageId,
      color: color ?? this.color,
      random: random ?? this.random,
    );
  }

  @override
  List<Object?> get props => [selectedCollageId, color, random];
}
