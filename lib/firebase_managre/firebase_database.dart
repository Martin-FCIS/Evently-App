import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/firebase_managre/models/event_model.dart';

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

  static Future<void> addEvent(EventModel data) {
    var ref = getRef();
    var doc = ref.doc();
    data.id = doc.id;
    return doc.set(data);
  }

  static Future<void> addFav(EventModel data) {
    var ref = getRef();
    var doc = ref.doc(data.id);
    data.isFav = !data.isFav;
    return doc.set(data);
  }

  static Future<List<QueryDocumentSnapshot<EventModel>>> getEvent() async {
    var ref = getRef();
    var data = await ref.get();
    return data.docs;
  }

  static Stream<QuerySnapshot<EventModel>> getEventsStream() {
    var ref = getRef();
    return ref.snapshots();
  }

  static Stream<QuerySnapshot<EventModel>> getEventsFavStream() {
    var ref = getRef().where("isFav", isEqualTo: true);
    return ref.snapshots();
  }
}
