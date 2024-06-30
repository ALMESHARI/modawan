import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:modawan/core/components/splash_page.dart';
import 'package:modawan/dependency_container.dart';
import 'package:modawan/features/profile/cubit/profile_initializer/profile_initializer_cubit.dart';
import 'package:modawan/main.dart';

import '../../../core/router/router.dart';
import '../../profile/cubit/profile_manager/profile_manager_cubit.dart';

/*
this is the page that called after the authentication process is done 
here we manage the redirection of the user to the right page
based on profile completion
if the user has completed the profile we redirect him to the home page
if not we redirect him to the profile setup page
if there is no connection or any error occurs we show an error message
since profile completion is crucial for the app to work properly
we show a message to the user to try again later
*/

// route name: /auth_redirect
class AuthRedirectPage extends StatelessWidget {
  AuthRedirectPage({super.key});

  final ProfileInitializerCubit cubit = sl.get<ProfileInitializerCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileInitializerCubit, ProfileInitializerState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is ProfileInitializerLoaded) {
          // register the profile manager to be used in the app
          sl.registerSingleton<ProfileManager>(ProfileManager(state.profile,sl()));
          if (state.profile.isCompleted) {
            appRouter.go('/home');
          } else {
            appRouter.go('/setup_profile');
          }
        }
      },
      child: BlocBuilder<ProfileInitializerCubit, ProfileInitializerState>(
          bloc: cubit..getProfile(supabase.auth.currentUser!.id),
          builder: (context, state) {
            if (state is ProfileInitializerLoaded) {
              return const SplashPage();
            }
            if (state is ProfileInitializerLoading) {
              return const SplashPage();
            } else if (state is ProfileInitializerError) {
              return Center(
                  child: Column(
                children: [
                  const Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 50,
                  ),
                  const Text('Something went wrong.'),
                  ElevatedButton(
                    onPressed: () async {
                      await cubit.getProfile(supabase.auth.currentUser!.id);
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              ));
            }
            return const SizedBox();
          }),
    );
  }
}
