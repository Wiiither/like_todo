part of 'tab_bar_bloc.dart';

class TabBarState extends Equatable {
  TabBarState({this.selectIndex = 0});

  final int selectIndex;

  @override
  List<Object> get props => [selectIndex];

  TabBarState copyWith({int? selectIndex}) {
    return TabBarState(
      selectIndex: selectIndex ?? this.selectIndex
    );
  }
}
