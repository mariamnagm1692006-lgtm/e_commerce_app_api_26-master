import 'package:ecommerce_app_api_26/features/profile/data/cubit/profile_state.dart';
import 'package:ecommerce_app_api_26/features/profile/data/models/profile_model.dart';
import 'package:ecommerce_app_api_26/features/profile/data/models/upload_model.dart';
import 'package:ecommerce_app_api_26/features/profile/data/profile_api/profile_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../profile_api/upload_api.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  final ProfileApi profileApi = ProfileApi();
  final UploadApi uploadApi = UploadApi();

  final ImagePicker picker = ImagePicker();

  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      ProfileModel profile = await profileApi.getProfile();
      emit(ProfileSuccess(profileModel: profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> uploadImage() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    try {
      UploadModel upload = await uploadApi.uploadImage(image.path);
      if (state is ProfileSuccess) {
        final current = state as ProfileSuccess;
        emit(
          ProfileSuccess(
            profileModel: current.profileModel,
            imageUrl: upload.location,
          ),
        );
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
