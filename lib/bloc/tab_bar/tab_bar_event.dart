part of 'tab_bar_bloc.dart';

class TabBarEvent extends Equatable {
  const TabBarEvent();
  @override
  List<Object?> get props => [];
}

class SelectTab extends TabBarEvent {
  SelectTab({required this.tabIndex});
  final int tabIndex;

  @override
  List<Object?> get props => [tabIndex];
}
