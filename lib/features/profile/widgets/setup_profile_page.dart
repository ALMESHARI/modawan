import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:modawan/core/components/image_helper/image_viewer.dart';
import 'package:modawan/core/router/router.dart';
import 'package:modawan/features/profile/cubit/profile_cubit.dart';

class SetupProfilePage extends StatelessWidget {
  SetupProfilePage({super.key});
  final cubit = GetIt.I.get<ProfileCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setup Profile Page'),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
          bloc: cubit,
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileError) {
              return Center(child: Text(state.message));
            } else if (state is ProfileLoaded) {
              return Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: ImageViewer.network(
                      imageUrl: state.profile.avatar,
                      placeholder: const CircularProgressIndicator(),
                      viewMode: true,
                      dist: DistinationInformation(
                          'profile/avatar', 'modawan'),
                      onUpdated: (newUrl) {
                        cubit.updateCachedProfile(
                            state.profile.copyWith(avatar: newUrl));
                      },
                    ),
                  ),
                  // button to go to route /image
                  ElevatedButton(
                    onPressed: () async {
                      await appRouter.push('/image');
                    },
                    child: const Text('Go to Image Upload Page'),
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          }),
    );
  }
}
