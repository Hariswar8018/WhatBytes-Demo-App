import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_app/bloc/userbloack_event.dart';
import 'package:task_app/bloc/userbloack_state.dart';
import '../model/usermodel.dart' show UserModel;


class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoadUser>(_onLoadUser);
  }

  Future<void> _onLoadUser(LoadUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(event.uid)
          .get();
      if (!snapshot.exists) {
        emit(UserError("User not found"));
        return;
      }
      final user = UserModel.fromJson(snapshot.data()!);
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
