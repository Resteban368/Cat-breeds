part of 'breed_cubit.dart';

sealed class BreedState extends Equatable {
  const BreedState();

  @override
  List<Object> get props => [];
}

final class BreedInitial extends BreedState {}

final class BreedLoading extends BreedState {}

final class BreedLoaded extends BreedState {
  final int page;
  final List<BreedEntity> breeds;

  const BreedLoaded({required this.breeds, required this.page});

  @override
  List<Object> get props => [breeds, page];
}

final class BreedFailure extends BreedState {
  final String message;
  const BreedFailure({required this.message});

  @override
  List<Object> get props => [message];
}
