part of 'user_cubit.dart';


abstract class UserState {
  final User? user;
  const UserState({this.user});
}

class UserInitial extends UserState {
  const UserInitial(User user):super(user: user);
}
