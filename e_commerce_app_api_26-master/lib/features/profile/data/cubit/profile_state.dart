import 'package:ecommerce_app_api_26/features/profile/data/models/profile_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final ProfileModel profileModel;
  final String? imageUrl;
  ProfileSuccess({required this.profileModel, this.imageUrl});
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}
