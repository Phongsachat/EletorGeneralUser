import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FireStoreUtils {

  final String _pathReference;

  FirebaseFirestore _instance = FirebaseFirestore.instance;

  FireStoreUtils(this._pathReference);

  /// Initialization of [Firebase.initializeApp] require once in [main.dart]
  static get initialize => _initialized();

  static _initialized() async {
    await Firebase.initializeApp();
  }

  CollectionReference createCollectionRef(){
   return _instance.collection(_pathReference);
  }

  DocumentReference createDocumentRef(){
   return _instance.doc(_pathReference);
  }

  Future<QuerySnapshot> orderByTimeStamp(){
   return createCollectionRef().orderBy("timeStamp").get();
  }

  Stream<QuerySnapshot> orderByTimeStampSnapShot(){
    return createCollectionRef().orderBy("timeStamp").snapshots();
  }

  Stream<QuerySnapshot> reportHistorySnapShot(accountId){
    return createCollectionRef().where("accountId" ,isEqualTo: accountId).orderBy("timeStamp",descending: true).limit(10).snapshots();
  }

  Future<QuerySnapshot> orderBy(String condition){
    return createCollectionRef().orderBy(condition).get();
  }

  Stream<QuerySnapshot> snapshots(){
   return createCollectionRef().snapshots();
  }

   Future<int> lengthDocOfCollect() async {
   return await createCollectionRef().get().then((elements) => elements.docs.length);
  }
}
