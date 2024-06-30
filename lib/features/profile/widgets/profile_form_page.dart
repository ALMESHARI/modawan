import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modawan/core/components/widgets/background.dart';
import '../../../core/components/image_helper/image_viewer.dart';
import '../../../core/components/widgets/custom_containers.dart';
import '../../../core/router/router.dart';
import '../../../core/theme/theme_constants.dart';
import '../../../dependency_container.dart';
import '../cubit/check_username/check_username_cubit.dart';
import '../cubit/profile_manager/profile_manager_cubit.dart';

// ignore: must_be_immutable
class ProfileFormBuilder extends StatelessWidget {
  ProfileFormBuilder({
    super.key,
  }) {
    checkUsernameCubit =
        CheckUsernameCubit(profileCubit.state.profile.username, sl());

    initializeFields();
  }

  final ProfileManager profileCubit = sl.get<ProfileManager>();

  final TextEditingController aboutController = TextEditingController();

  final TextEditingController appearingNameController = TextEditingController();
  // stream controller to display errors
  final ErrorNotifier errorNotifier = ErrorNotifier();
  late CheckUsernameCubit checkUsernameCubit;

  void initializeFields() {
    aboutController.text = profileCubit.state.profile.about ?? '';
    appearingNameController.text =
        profileCubit.state.profile.appreaingName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundPen(
      child: BlocListener<ProfileManager, ProfileManagerState>(
          bloc: profileCubit,
          listener: (context, state) {
            if (state is ProfileManagerLoaded && state.profile.isCompleted) {
              appRouter.go('/home');
            }
            if (state is ProfileManagerError) {
              errorNotifier.addError(ErrorType.generalError, state.message);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AvatarWidget(
                    errorNotifier: errorNotifier,
                    cubit: profileCubit,
                    context: context),
                Column(
                  children: [
                    BlocBuilder<ProfileManager, ProfileManagerState>(
                        bloc: profileCubit,
                        buildWhen: (previous, current) {
                          return current.profile.username !=
                              previous.profile.username;
                        },
                        builder: (context, state) {
                          return UsernameWidget(
                              currentUsername: state.profile.username,
                              checkUsernameCubit: checkUsernameCubit);
                        }),
                    const SizedBox(height: 15),
                    FullNameWidget(
                        errorNotifier: errorNotifier,
                        appearingNameController: appearingNameController),
                    // about field
                    const SizedBox(height: 15),
                    AboutWidget(
                      aboutController: aboutController,
                    ),
                    const SizedBox(height: 15),
      
                    ErrorWidget(errorNotifier: errorNotifier),
                  ],
                ),
                // button to go to route /image
                SubmitButton(
                  profileCubit: profileCubit,
                  errorNotifier: errorNotifier,
                  appearingNameController: appearingNameController,
                  checkUsernameCubit: checkUsernameCubit,
                  aboutController: aboutController,
                ),
              ],
            ),
          )),
    );
  }
}

class SubmitButton extends StatefulWidget {
  const SubmitButton({
    super.key,
    required this.profileCubit,
    required this.errorNotifier,
    required this.aboutController,
    required this.appearingNameController,
    required this.checkUsernameCubit,
  });
  final ProfileManager profileCubit;
  final ErrorNotifier errorNotifier;
  final TextEditingController aboutController;

  final TextEditingController appearingNameController;
  // stream controller to display errors
  final CheckUsernameCubit checkUsernameCubit;

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  // setState based on change in errorNotifier
  @override
  void initState() {
    super.initState();
    widget.errorNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  bool isValid() {
    // only check for fullNameError
    if (widget.errorNotifier.errors.containsKey(ErrorType.fullNameError)) {
      return false;
    }
    String? username;
    if (widget.checkUsernameCubit.state is CheckUsernameLoaded) {
      username =
          (widget.checkUsernameCubit.state as CheckUsernameLoaded).username;
    } else if (widget.checkUsernameCubit.state is CheckUsernameInitial) {
      username =
          (widget.checkUsernameCubit.state as CheckUsernameInitial).username;
    }
    if (widget.profileCubit.state is! ProfileManagerLoading &&
        username != null &&
        widget.appearingNameController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckUsernameCubit, CheckUsernameState>(
      bloc: widget.checkUsernameCubit,
      builder: (context, state) {
        String? username;
        if (widget.checkUsernameCubit.state is CheckUsernameLoaded) {
          username =
              (widget.checkUsernameCubit.state as CheckUsernameLoaded).username;
        } else if (widget.checkUsernameCubit.state is CheckUsernameInitial) {
          username = (widget.checkUsernameCubit.state as CheckUsernameInitial)
              .username;
        }
        return BlocBuilder<ProfileManager, ProfileManagerState>(
          bloc: widget.profileCubit,
          builder: (context, state) {
            Function()? func;
            if (isValid()) {
              func = () async {
                await widget.profileCubit.updateProfile(state.profile.copyWith(
                    about: widget.aboutController.text,
                    appreaingName: widget.appearingNameController.text,
                    username: username));
              };
            }

            return ElevatedButton(
                onPressed: func,
                child: state is ProfileManagerLoading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppColors.darkblue
                                    : AppColors.whiteblue))
                    : const Text('SAVE'));
          },
        );
      },
    );
  }
}

class FullNameWidget extends StatelessWidget {
  FullNameWidget({
    super.key,
    required this.appearingNameController,
    required this.errorNotifier,
  }) {
    appearingNameController.addListener(
      () {
        if (appearingNameController.text.trim().isEmpty) {
          errorNotifier.addError(
              ErrorType.fullNameError, 'Full name field is required');
        } else {
          errorNotifier.removeError(ErrorType.fullNameError);
        }
      },
    );
  }

  final TextEditingController appearingNameController;
  final ErrorNotifier errorNotifier;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: TextField(
        buildCounter: (context,
                {required currentLength,
                required isFocused,
                required maxLength}) =>
            null,
        maxLength: 50,
        controller: appearingNameController,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.person),
          hintText: 'Full name',
        ),
      ),
    );
  }
}

enum ErrorType {
  imageError,
  fullNameError,
  generalError,
}

class ErrorNotifier extends ChangeNotifier {
  final Map<ErrorType, String> _errors = {};

  Map<ErrorType, String> get errors => _errors;

  void addError(ErrorType type, String message) {
    _errors[type] = message;
    notifyListeners();
  }

  void removeError(ErrorType type) {
    _errors.remove(type);
    notifyListeners();
  }

  void clearErrors() {
    _errors.clear();
    notifyListeners();
  }
}

class ErrorWidget extends StatefulWidget {
  final ErrorNotifier errorNotifier;

  const ErrorWidget({super.key, required this.errorNotifier});

  @override
  State<ErrorWidget> createState() => _ErrorWidgetState();
}

class _ErrorWidgetState extends State<ErrorWidget> {
  @override
  void initState() {
    super.initState();
    widget.errorNotifier.addListener(_update);
  }

  @override
  void dispose() {
    widget.errorNotifier.removeListener(_update);
    super.dispose();
  }

  void _update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final error = widget.errorNotifier.errors;
    return AnimatedSize(
        duration: Duration(milliseconds: 200),
        child: SizedBox(
            width: 1000,
            height: error.isNotEmpty ? 50 : 0,
            child: error.isNotEmpty
                ? GlassContainer(
                    child: Row(
                      children: [
                        const SizedBox(
                          height: 48,
                          width: 48,
                          child: Icon(
                            Icons.error,
                            color: Colors.redAccent,
                          ),
                        ),
                        Flexible(
                            child: Text(
                          error.values.first,
                          style: const TextStyle(color: Colors.redAccent),
                        )),
                      ],
                    ),
                  )
                : SizedBox()));
  }
}

class AboutWidget extends StatefulWidget {
  const AboutWidget({
    super.key,
    required this.aboutController,
  });

  final TextEditingController aboutController;

  @override
  State<AboutWidget> createState() => _AboutWidgetState();
}

class _AboutWidgetState extends State<AboutWidget> {
  final _controller = StreamController<int>();
  Stream<int> get stream => _controller.stream;

  void updateCounter(int newCounter) {
    _controller.sink.add(newCounter);
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: Stack(
        children: [
          TextField(
            controller: widget.aboutController,
            buildCounter: (context,
                {required currentLength,
                required isFocused,
                required maxLength}) {
              updateCounter(currentLength);
              return null;
            },
            maxLength: 180,
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 3,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'\n')),
            ],
            decoration: const InputDecoration(
              prefixIcon: SizedBox(
                  height: 40,
                  width: 40,
                  child: Icon(Icons.person_pin_circle_outlined)),
              hintText: 'About your self in few words',
            ),
          ),
          Positioned(
            right: 5,
            top: 5,
            child: StreamBuilder<Object>(
                stream: stream,
                builder: (context, snapshot) {
                  return Text('${snapshot.hasData ? snapshot.data : 0}/180',
                      style: AppTextStyles.buttontextstyle.copyWith(
                          color: AppColors.inputplaceholdertext.withOpacity(0.4),
                          fontSize: 10));
                }),
          ),
        ],
      ),
    );
  }
}

class UsernameWidget extends StatelessWidget {
  const UsernameWidget({
    super.key,
    required this.currentUsername,
    required this.checkUsernameCubit,
  });
  final CheckUsernameCubit checkUsernameCubit;
  final String? currentUsername;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    controller.text = currentUsername ?? '';

    return BlocBuilder<CheckUsernameCubit, CheckUsernameState>(
      bloc: checkUsernameCubit,
      builder: (context, state) {
        // put default icon and text to be hint

        late Widget statusIcon = const SizedBox(
          height: 48,
          width: 48,
          child: Icon(
            Icons.info_outline,
            color: Color.fromARGB(255, 99, 149, 249),
          ),
        );

        late Widget statusText = Text('Username help you to be found easily!',
            style: AppTextStyles.maintextstyle.copyWith(
                height: 1.2, color: const Color.fromARGB(255, 99, 149, 249)));
        // statusText = TextField(
        //   decoration: InputDecoration(
        //       prefixIcon: const Icon(Icons.alternate_email_rounded),
        //       hintText: 'Enter your username'),
        // );

        if (state is CheckUsernameLoading) {
          statusIcon = const SizedBox(
            height: 48,
            width: 48,
            // child: CupertinoActivityIndicator(
            //     radius: 10, color: AppColors.inputplaceholdertext),
            child: Padding(
              padding: EdgeInsets.all(14.0),
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
            height: 48,
            width: 48,
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
            height: 48,
            width: 48,
            child: Icon(
              Icons.verified,
              color: AppColors.highlighttextcolor,
            ),
          );
        }

        String hint = 'Enter your username';
        if (state is CheckUsernameInitial) {
          if (currentUsername != null && currentUsername!.isNotEmpty) {
            hint = currentUsername!;
          }
        }
        return GlassContainer(
          child: Column(
            children: [
              TextField(
                buildCounter: (context,
                        {required currentLength,
                        required isFocused,
                        required maxLength}) =>
                    null,
                maxLength: 15,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                ],
                controller: controller,
                onChanged: (value) async {
                  await checkUsernameCubit.checkUsernameAvailability(
                      value.trim(), controller);
                },
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.alternate_email_rounded),
                    hintText: hint),
              ),
              Divider(
                height: 2,
                color: AppColors.mainstroke,
                thickness: 1,
              ),
              Container(
                // put only bottom border radius
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(10))),
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
          ),
        );
      },
    );
  }
}

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key,
    required this.cubit,
    required this.context,
    required this.errorNotifier,
  });

  final ProfileManager cubit;
  final BuildContext context;
  final ErrorNotifier errorNotifier;

  @override
  Widget build(BuildContext context) {
    final profile = cubit.state.profile;
    return GlassContainer(
      radius: 100,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        width: 150,
        height: 150,
        child: ImageViewer(
            viewMode: false,
            placeholder: SizedBox(
              width: 150,
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.file_upload,
                      size: 50, color: AppColors.inputplaceholdertext),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Upload profile image',
                      style: AppTextStyles.buttontextstyle.copyWith(
                          color: AppColors.inputplaceholdertext, fontSize: 12)),
                ],
              ),
            ),
            heroAnimationKey: 'profile-image-setup-page',
            title: profile.appreaingName,
            imageUrl: profile.avatarURL,
            updateInformation: UpdateInforamtion(
              distPathGenerator: () =>
                  '${profile.userID}/profile${DateTime.now().millisecondsSinceEpoch}.png',
              bucketName: 'avatars',
              onUpdated: (dist) async {
                await cubit.updateProfile(profile.copyWith(avatar: dist));
                errorNotifier.removeError(ErrorType.imageError);
              },
              onFailed: (error) async {
                errorNotifier.addError(ErrorType.imageError, error);
              },
            )),
      ),
    );
  }
}
