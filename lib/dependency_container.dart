import 'package:get_it/get_it.dart';
import 'package:modawan/features/auth/cubit/auth_manager_cubit.dart';
import 'package:modawan/features/blogs/cubits/slider_blogs/slider_blogs_cubit.dart';
import 'package:modawan/features/blogs/data/blog_repository.dart';
import 'package:modawan/features/profile/cubit/profile_initializer/profile_initializer_cubit.dart';
import 'package:modawan/features/profile/repository/profile_repository.dart';

final GetIt sl = GetIt.instance;

// profile manager will be registered in /auth_redirect page 
Future<void> setupDependencyContainer() async {
  // Register AuthBloc
  sl.registerSingleton<AuthManagerCubit>(AuthManagerCubit());
  sl.registerLazySingleton<SliderBlogsCubit>(() => SliderBlogsCubit(sl()));
  sl.registerLazySingleton<BlogRepository>(() => BlogRepository());
  sl.registerLazySingleton<ProfileInitializerCubit>(() => ProfileInitializerCubit(sl()));
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepository());
}
