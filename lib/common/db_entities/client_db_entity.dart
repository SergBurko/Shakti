import 'package:shakti/common/db_entities/org_db_entity.dart';
import 'package:shakti/common/db_entities/role_db_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientDBEntity {
  String id = "";
  String email = "";
  String name = "";
  String surname = "";
  String photoLink = "";
  String password = "";

  RoleDBEntity role = RoleDBEntity();
  OrgDBEntity org = OrgDBEntity();

  fillDataByClientDbEntity(ClientDBEntity clientDBEntity) {
    id = clientDBEntity.id;
    name = clientDBEntity.name;
    surname = clientDBEntity.surname;
    email = clientDBEntity.email;
    photoLink = clientDBEntity.photoLink;
    // password = clientDBEntity.password;
  }

  addOrUpdateThisInDB() {
    final firestoreInstance = FirebaseFirestore.instance;
    try {
      firestoreInstance.collection('client').doc(id).set({
        'email': email,
        'name': name,
        'surname': surname,
        'photoLink': photoLink, 
        // 'password': password
      });
    } catch (e) {
      print(e);
    }
  }

  Future<ClientDBEntity> getClientByFirebaseUserId(String userId) async {
    final firestoreInstance = FirebaseFirestore.instance;
    try {
      var value =
          await firestoreInstance.collection("client").doc(userId).get();

      id = value.id;
      name = value["name"];
      surname = value["surname"];
      email = value["email"];
      photoLink = value["photoLink"];
      // password = value["password"];

    } catch (e) {
      print(e);
      fillDataByClientDbEntity(ClientDBEntity());
    }
    return this;
  }

   Future<bool> isThereClientByEmail(
      String email) async {
    bool result = false;
    final firestoreInstance = FirebaseFirestore.instance;
    try {
      var value = await firestoreInstance
          .collection("client")
          .where("email", isEqualTo: email)
          .limit(1).get();
      if (value.docs.isNotEmpty) {
        result = true;
      }
    } catch (e) {
      print(e);
      fillDataByClientDbEntity(ClientDBEntity());
    }

    return result;
  }

  // getParticipantByUserIdAndGroupID(String userId, String groupId) async {
  //   final firestoreInstance = FirebaseFirestore.instance;
  //   try {
  //     // Если нет документов, создайте новый
  //     var value = await firestoreInstance
  //         .collection('participant')
  //         .orderBy('datetime', descending: true)
  //         .where("groupId", isEqualTo: groupId)
  //         .where("userId", isEqualTo: userId)
  //         .get();

  //     participantId = value.docs[0].id;
  //     groupId = value.docs[0]["groupId"];
  //     userId = value.docs[0]["userId"];
  //     name = value.docs[0]["name"];

  //     var firestoreTimestamp = value.docs[0]["datetime"];
  //     dateTime = DateTime.parse(firestoreTimestamp.toDate().toString());
  //   }
  //   // print('OnQuiz успешно записан.');
  //   catch (e) {
  //     print(e);
  //   }
  //   return this;
  // }

  // Future<List<Participant>> getAllParticipantsByGroupId(String groupId) async {
  //   final firestoreInstance = FirebaseFirestore.instance;
  //   List<Participant> participants = [];
  //   try {
  //     var value = await firestoreInstance
  //         .collection('participant')
  //         .orderBy('datetime', descending: true)
  //         .where("groupId", isEqualTo: groupId)
  //         .get();

  //     if (value.docs.isNotEmpty) {
  //       for (var doc in value.docs) {
  //         var firestoreTimestamp = doc["datetime"];

  //         participants.add(Participant.fill(
  //             doc.id,
  //             groupId,
  //             doc["userId"],
  //             doc["name"],
  //             DateTime.parse(firestoreTimestamp.toDate().toString())));
  //       }
  //     }
  //   } catch (e) {
  //     print(e);
  //   } finally {
  //     // ignore: control_flow_in_finally
  //     return participants;
  //   }
  // }

  // getAllParticipantsByAnswers(List<OnQuizUserAnswer> answers) async {
  //   final firestoreInstance = FirebaseFirestore.instance;
  //   List<String> participantIds = [];
  //   List<Participant> participants = [];

  //   try {
  //     if (answers.isNotEmpty) {
  //       for (var answer in answers) {
  //         participantIds.add(answer.participantId);
  //       }
  //       if (participantIds.isNotEmpty) {
  //         var value = await firestoreInstance
  //             .collection('participant')
  //             .where(FieldPath.documentId, whereIn: participantIds)
  //             .get();

  //         if (value.docs.isNotEmpty) {
  //           for (var doc in value.docs) {
  //             var firestoreTimestamp = doc["datetime"];

  //             participants.add(Participant.fill(
  //                 doc.id,
  //                 groupId,
  //                 doc["userId"],
  //                 doc["name"],
  //                 DateTime.parse(firestoreTimestamp.toDate().toString())));
  //           }
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     print(e);
  //   } finally {
  //     // ignore: control_flow_in_finally
  //     return participants;
  //   }
  // }
}
