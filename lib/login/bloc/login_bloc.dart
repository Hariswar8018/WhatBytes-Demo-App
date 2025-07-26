

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/userbloack_event.dart' hide UserEvent;
import '../../bloc/userbloack_state.dart' hide UserState;
import '../../model/usermodel.dart';
import 'login_event.dart';
import 'login_state.dart';


class UserBloc extends Bloc<UserEvent, UserState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserBloc() : super(AuthInitial()) {
    on<LoginRequested>(_loginHandler);
    on<SignupRequested>(_signupHandler);
  }

  Future<void> _loginHandler(LoginRequested event, Emitter<UserState> emit) async {
    emit(AuthLoading());
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      final uid = cred.user!.uid;

      final userDoc = _firestore.collection("Users").doc(uid);
      final userSnap = await userDoc.get();

      if (!userSnap.exists) {
        final user = UserModel(name: "", id: uid, pic: "", task: []);
        await userDoc.set(user.toJson());
      }

      emit(Authenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _signupHandler(SignupRequested event, Emitter<UserState> emit) async {
    emit(AuthLoading());
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      final uid = cred.user!.uid;
      final user = UserModel(name: "", id: uid, pic: "", task: []);
      await _firestore.collection("Users").doc(uid).set(user.toJson());
      emit(Authenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
