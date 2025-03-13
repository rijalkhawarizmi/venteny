// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  const ThemeState({this.isModeDark=false});
  final bool isModeDark; 
  
  @override
  List<Object> get props => [isModeDark];

  ThemeState copyWith({
    bool? isModeDark,
  }) {
    return ThemeState(
      isModeDark: isModeDark ?? this.isModeDark,
    );
  }
}

