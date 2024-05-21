import 'package:bloc/bloc.dart';

class RankSliderCubit extends Cubit<int> {
  RankSliderCubit() : super(0);

  void update(double value) => emit(value.toInt());
}
