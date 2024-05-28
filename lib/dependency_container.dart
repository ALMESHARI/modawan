import 'package:get_it/get_it.dart';
import 'package:modawan/features/auth/cubit/auth_manager_cubit.dart';
import 'package:modawan/features/auth/cubit/auth_router_cubit.dart';

final GetIt sl = GetIt.instance;

void setupDependencyContainer() {
  // Register AuthBloc
  sl.registerSingleton<AuthRouterCubit>(AuthRouterCubit());
  sl.registerSingleton<AuthManagerCubit>(AuthManagerCubit(sl()));
}
