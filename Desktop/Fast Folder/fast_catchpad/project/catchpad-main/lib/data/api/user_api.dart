import 'package:catchpad/models/game/game_result_model.dart';
import 'package:catchpad/prov/group_players_prov.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/auth/register_user.dart';
import '../../models/auth/user_assets.dart';
import '../../prov/leaderboard/leaderboard_result_prov.dart';
import '../../utils/utils.dart';

class UsersApi {
  UsersApi._();

  static final UsersApi _instance = UsersApi._();

  static UsersApi get instance => _instance;

  CollectionReference<Map<String, dynamic>> users() =>
      FirebaseFirestore.instance.collection(usersCollection);

  CollectionReference<Map<String, dynamic>> admins() =>
      FirebaseFirestore.instance.collection(adminsCollection);

  CollectionReference<Map<String, dynamic>> usernamepool() =>
      FirebaseFirestore.instance.collection(usernamesCollection);

  CollectionReference<Map<String, dynamic>> userAssets() =>
      FirebaseFirestore.instance.collection(userAssetsCollection);

  CollectionReference<Map<String, dynamic>> gameResults() =>
      FirebaseFirestore.instance.collection(gameResultsCollection);

  DocumentReference<Map<String, dynamic>> userDetails(String username) =>
      users().doc(username);

  Future<bool> deleteWhereIndexValueIsNull() async {
    final query =
        await gameResults().where('indexValue', isEqualTo: null).get();
    for (var doc in query.docs) {
      gameResults().doc(doc.id).delete();
    }
    return true;
  }

  Future<List<RegisterUser>?> getAllUsers() async {
    final query = await users().get();

    if (query.docs.isEmpty) {
      return null;
    }
    final docs = query.docs;

    final usrs = docs
        .where((element) => element.exists)
        .map((e) => e.data())
        .map((e) => RegisterUser.fromJson(e))
        .toList();

    return usrs;
  }

  Future<Map<String, dynamic>?> updateUserAssets(String uid) async {
    return null;
  }

  Future<UserAssets?> getUserAssets(String uid) async {
    final snapshot = await userAssets().doc(uid).get();
    if (!snapshot.exists) {
      return null;
    }
    final assetData = snapshot.data();
    if (assetData == null) {
      return null;
    }
    return UserAssets.fromJson(assetData);
  }

  Future<List<GameResultModel>> getGroupGameHistories(
      String uid, WidgetRef ref) async {
    try {
      final query = await gameResults()
          .where(
            'accountHolderId',
            isEqualTo: uid,
          )
          .get();

      if (query.docs.isEmpty) {
        return [];
      }
      final docs = query.docs;
      final results = resultsFromDocs(docs);
      ref.read(groupPlayersGameHistoryProvider.notifier).setTo(results);
      return results;
    } catch (e) {
      return [];
    }
  }

  List<GameResultModel> resultsFromDocs(List<QueryDoc> docs) {
    final res = docs.map(
      (doc) {
        final data = doc.data();
        return GameResultModel.fromJson(data);
      },
    );
    final ls = res.toList();
    return ls;
  }

  Future<List<String>> getAdminEmails() async {
    final query = await admins().get();

    if (query.docs.isEmpty) {
      return [];
    }
    final docs = query.docs;
    try {
      final emailsDoc = docs
          .where((element) => element.exists)
          .map((e) => e.data())
          .map((e) => e)
          .toList();
      final emails = emailsDoc.first;
      final usernamesPool =
          (emails['emails'] as List).map((mail) => mail as String).toList();
      return usernamesPool;
    } catch (e) {
      return [];
    }
  }

  Future<List<String>> getUserNamePool() async {
    final query = await usernamepool().get();

    if (query.docs.isEmpty) {
      return [];
    }
    final docs = query.docs;
    try {
      final usernamesDoc = docs
          .where((element) => element.exists)
          .map((e) => e.data())
          .map((e) => e)
          .toList();
      final usernames = usernamesDoc.first;
      final usernamesPool = (usernames['usernames'] as List)
          .map((mail) => mail as String)
          .toList();
      return usernamesPool;
    } catch (e) {
      return [];
    }
  }

  Future<bool> setUserNamePool(List<String> usernames) async {
    try {
      final json = {
        "usernames": List<dynamic>.from(usernames.map((x) => x)),
      };
      await UsersApi.instance.usernamepool().doc('usernames').set(json);
      return true;
    } catch (e) {
      logger.e('Unable to set usernames to pool: $e');
      return false;
    }
  }

  Future<RegisterUser?> _getUser(Query<Map<String, dynamic>> where) async {
    final query = await where.get();

    if (query.docs.isEmpty) {

      return null;
    }

    final doc = query.docs[0];
    final dt = doc.data();

    if (doc.exists) {
      final user = RegisterUser.fromJson(dt);
      return user;
    }

    return null;
  }

  Future<RegisterUser?> getUserFromUserId(String uid) async {
    final where = users().where(
      'uid',
      isEqualTo: uid,
    );

    return _getUser(where);
  }

  Future<RegisterUser?> getUserFromUserName(String userName) async {
    final where = users().where(
      'userName',
      isEqualTo: userName,
    );

    return _getUser(where);
  }

  Future<RegisterUser?> getUserFromEmailAddress(String email) async {
    final where = users().where(
      'email',
      isEqualTo: email,
    );

    return _getUser(where);
  }

  Future<RegisterUser?> getUserFromPhone(String phone) async {
    final where = users().where(
      'phoneNum',
      isEqualTo: phone,
    );

    return _getUser(where);
  }

  Future<bool> addUser(RegisterUser user, WidgetRef ref) async {
    try {
      await users().add(user.toJson());

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateUser(RegisterUser user, WidgetRef ref) async {
    try {
      await users().doc(user.userName).update(user.toJson());

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteUser(RegisterUser user, WidgetRef ref) async {
    try {
      await users().doc(user.userName).delete();

      return true;
    } catch (e) {
      return false;
    }
  }
}
