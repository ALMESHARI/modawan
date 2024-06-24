import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:modawan/core/components/splash_page.dart';
import 'package:modawan/main.dart';

import '../../../core/router/router.dart';
import '../../profile/cubit/profile_cubit.dart';

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

  final ProfileCubit cubit = GetIt.I.get<ProfileCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
        bloc: cubit..isFinishSetup(supabase.auth.currentUser!.id),
        builder: (context, state) {
          print(state.runtimeType);
          if (state is ProfileLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (state.profile.isCompleted) {
                appRouter.go('/home');
              } else {
                appRouter.go('/setup_profile');
              }
            });
          }

          if (state is ProfileLoading) {
            return const SplashPage();
          } else if (state is ProfileError) {
            return Center(
                child: Column(
              children: [
                const Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 50,
                ),
                Text(state.message),
                ElevatedButton(
                  onPressed: () async {
                    await cubit.retrieveProfile(supabase.auth.currentUser!.id);
                  },
                  child: const Text('Try Again'),
                ),
              ],
            ));
          }
          return const SizedBox();
        });
  }
}
