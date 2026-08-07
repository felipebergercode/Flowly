part of 'description_cubit.dart';

class DescriptionState {
  final String description;
  const DescriptionState({this.description = ''});
  DescriptionState copyWith({String? description}) {
    return DescriptionState(description: description ?? this.description);
  }
}
