part of 'app_appearance_cubit.dart';

class AppAppearanceState extends Equatable{
  final ThemeData themeData;
  final Locale locale;

  const AppAppearanceState(this.themeData, this.locale);

  @override
  List<Object?> get props => [themeData,locale];
}
