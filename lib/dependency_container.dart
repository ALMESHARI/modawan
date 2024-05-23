import 'package:get_it/get_it.dart';
import 'package:modawan/features/auth/cubit/auth_cubit.dart';
import 'package:modawan/features/auth/cubit/auth_loading_cubit.dart';

final GetIt sl = GetIt.instance;

void setupDependencyContainer() {
  // Register AuthBloc
  sl.registerSingleton<AuthLoadingCubit>(AuthLoadingCubit());
  sl.registerSingleton<AuthCubit>(AuthCubit(sl()));
}
