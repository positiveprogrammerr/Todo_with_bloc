import 'package:bloc/bloc.dart';

import '../../../data/models/user.dart';



part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial(User(id: '1', name: 'Mehmet')));

  User get currentUser{
    return state.user!;
  }
}
