import 'package:get_it/get_it.dart';
import 'package:modawan/features/auth/cubit/auth_manager_cubit.dart';

final GetIt sl = GetIt.instance;

void setupDependencyContainer() {
  // Register AuthBloc
  sl.registerSingleton<AuthManagerCubit>(AuthManagerCubit());
}
