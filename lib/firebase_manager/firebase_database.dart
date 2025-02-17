import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/firebase_manager/models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDatabase {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static CollectionReference<EventModel> getRef() {
    return firestore.collection("events").withConverter<EventModel>(
      fromFirestore: (snapshot, options) {
        return EventModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    );
  }

  static Future<void> addEvent(EventModel event) {
    var ref = getRef();
    var doc = ref.doc();
    event.id = doc.id;
    return doc.set(event);
  }

  static Future<void> addFav(EventModel event) {
    var ref = getRef();
    var doc = ref.doc(event.id);
    event.isFav = !event.isFav;
    return doc.set(event);
  }

  static Future<List<QueryDocumentSnapshot<EventModel>>> getEvent() async {
    var ref = getRef()
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid);
    var data = await ref.get();
    return data.docs;
  }

  static Stream<QuerySnapshot<EventModel>> getEventsStream() {
    var ref = getRef()
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid);
    return ref.snapshots();
  }

  static Stream<QuerySnapshot<EventModel>> getEventsFavStream() {
    var ref = getRef()
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("isFav", isEqualTo: true);
    return ref.snapshots();
  }

  static Future<void> deleteEvent(String id) async {
    var ref = getRef();
    await ref.doc(id).delete();
  }

  static Future<void> updateEvent(EventModel event) async {
    var ref = getRef();
    await ref.doc(event.id).update(event.toJson());
  }
}
