part of 'auth_router_cubit.dart';

@immutable
sealed class AuthRouterState {}

final class Authenticated extends AuthRouterState {}

final class Unauthenticated extends AuthRouterState {}

final class InitialRouteState extends AuthRouterState{}