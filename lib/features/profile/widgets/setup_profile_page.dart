import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:modawan/core/components/image_helper/image_viewer.dart';
import 'package:modawan/core/router/router.dart';
import 'package:modawan/features/profile/cubit/cubit/check_username_cubit.dart';
import 'package:modawan/features/profile/cubit/profile_cubit.dart';
import 'package:modawan/features/profile/repository/profile_repository.dart';
import 'package:modawan/main.dart';

import '../../../core/components/widgets/custom_containers.dart';
import '../../../core/theme/theme_constants.dart';

class SetupProfilePage extends StatelessWidget {
  SetupProfilePage({super.key});
  final cubit = GetIt.I.get<ProfileCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup Profile Page'),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
          bloc: cubit,
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileError) {
              return Center(child: Text(state.message));
            } else if (state is ProfileLoaded) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      avatarWidget(state, context),
                      Column(
                        children: [
                          userNameWidget(state),
                        ],
                      ),
                      // button to go to route /image
                      ElevatedButton(
                        onPressed: () async {
                          await appRouter.push('/image');
                        },
                        child: const Text('Go to Image Upload Page'),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          }),
    );
  }

  Widget userNameWidget(ProfileLoaded profileState) {
    TextEditingController controller = TextEditingController();
    controller.text = profileState.profile.username ?? '';
    CheckUsernameCubit checkUsernameCubit = CheckUsernameCubit(
        profileState.profile.username, GetIt.I.get<ProfileRepository>());
    return BlocBuilder<CheckUsernameCubit, CheckUsernameState>(
      bloc: checkUsernameCubit,
      builder: (context, state) {
        // put default icon and text to be hint

        late Widget statusIcon = const SizedBox(
          height: 40,
          width: 40,
          child: Icon(
            Icons.info_outline,
            color: Color.fromARGB(255, 99, 149, 249),
          ),
        );
        ;
        late Widget statusText = Text(
            'Username is unique string help you to be found easily!',
            style: AppTextStyles.buttontextstyle.copyWith(
                height: 1.2, color: const Color.fromARGB(255, 99, 149, 249)));

        if (state is CheckUsernameLoading) {
          statusIcon = const SizedBox(
            height: 40,
            width: 40,
            // child: CupertinoActivityIndicator(
            //     radius: 10, color: AppColors.inputplaceholdertext),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: CircularProgressIndicator(
                strokeWidth: 2,
                semanticsLabel: 'Checking username',
                valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.inputplaceholdertext),
              ),
            ),
          );
          statusText = Text('Checking username @${state.valueToCheck}...',
              style: AppTextStyles.buttontextstyle.copyWith(
                  height: 1.2, color: AppColors.inputplaceholdertext));
        }

        if (state is CheckUsernameError) {
          statusIcon = const SizedBox(
            height: 40,
            width: 40,
            child: Icon(
              Icons.error,
              color: Colors.red,
            ),
          );
          statusText = Text(
            state.message,
            style: const TextStyle(color: Colors.redAccent),
          );
        }
        if (state is CheckUsernameLoaded) {
          statusText = Text('Username @${state.username} is available',
              style: AppTextStyles.buttontextstyle
                  .copyWith(height: 1.2, color: AppColors.highlighttextcolor));
          statusIcon = const SizedBox(
            height: 40,
            width: 40,
            child: Icon(
              Icons.verified,
              color: AppColors.highlighttextcolor,
            ),
          );
        }

        return Column(
          children: [
            GlassContainer(
              child: TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
                controller: controller,
                onChanged: (value) {
                  checkUsernameCubit.uploadWithNewName(
                      profileState.profile.copyWith(username: value.trim()),
                      controller);
                },
                // disable when loading
                // enabled: state
                //     is! CheckUsernameLoading, // put value to be the same email when otp is sent
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.alternate_email_rounded),
                  hintText: state is CheckUsernameInitial
                      ? 'Enter your username'
                      : controller.text.trim().isEmpty
                          ? checkUsernameCubit.username
                          : controller.text.trim(),
                ),
              ),
            ),
            GlassContainer(
              child: Row(
                children: [
                  statusIcon,
                  Flexible(
                    child: statusText,
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Container avatarWidget(ProfileLoaded state, BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      // put white border
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        // border: Border.all(color: Colors.white, width: 1),
      ),
      width: 150,
      height: 150,
      child: ImageViewer(
          heroAnimationKey: 'profile-image-setup-page',
          title: state.profile.appreaingName,
          imageUrl: state.profile.avatarURL,
          updateInformation: UpdateInforamtion(
            distPathGenerator: () =>
                '${supabase.auth.currentUser!.id}/profile${DateTime.now().millisecondsSinceEpoch}.png',
            bucketName: 'avatars',
            onUpdated: (newUrl) async {
              await cubit.updateCachedProfile(
                  state.profile.copyWith(avatarURL: newUrl));
            },
            onFailed: (error) async {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(error)));
              });
            },
          )),
    );
  }
}
