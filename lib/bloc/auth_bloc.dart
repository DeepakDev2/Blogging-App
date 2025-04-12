// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blogging_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blogging_app/core/usercase/usecase.dart';
import 'package:blogging_app/core/entities/user.dart';
import 'package:blogging_app/features/auth/domain/usecases/current_user.dart';
import 'package:blogging_app/features/auth/domain/usecases/user_signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blogging_app/features/auth/domain/usecases/user_signup.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignup userSignup,
    required UserSignIn userSignIn,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignup = userSignup,
        _userSignIn = userSignIn,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthSignUp>(
      (event, emit) async {
        emit(AuthLoading());
        final res = await _userSignup(UserSingUpParams(
            email: event.email, password: event.password, name: event.name));
        res.fold(
          (l) {
            return emit(AuthFailure(l.message));
          },
          (user) {
            return _emitAuthSuccess(user, emit);
          },
        );
      },
    );
    on<AuthSignIn>(
      (event, emit) async {
        emit(AuthLoading());
        final res = await _userSignIn(
            UserSignInpParams(email: event.email, password: event.password));
        res.fold(
          (l) {
            return emit(AuthFailure(l.message));
          },
          (user) {
            return _emitAuthSuccess(user, emit);
          },
        );
      },
    );
    on<AuthIsUserLoggedIn>((event, emit) async {
      final res = await _currentUser.call(NoParams());
      res.fold((l) => emit(AuthFailure(l.message)),
          (user) => _emitAuthSuccess(user, emit));
    });
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    emit(AuthLoading());
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
