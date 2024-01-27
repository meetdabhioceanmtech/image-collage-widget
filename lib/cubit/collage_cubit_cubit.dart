import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'collage_cubit_state.dart';

class CollageCubit extends Cubit<CollageCubitState> {
  CollageCubit() : super(CollageCubitInitial());
}
