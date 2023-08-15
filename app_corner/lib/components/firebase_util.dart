import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseUtil{
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> uploadImage(String email, String collection, String filename, Uint8List file) async{
    //Obtiene una referencia a la imagen que se desea subir a través de cada ruta
    Reference referenceRoot = storage.ref();
    Reference referenceDirImages = referenceRoot.child(email);
    Reference referenceCollection = referenceDirImages.child(collection);
    Reference referenceImageToUpload = referenceCollection.child(filename);
    // Sube la imagen a Firebase Storage y obtiene la URL de descarga
    UploadTask uploadTask = referenceImageToUpload.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> updateImage(Uint8List file, String url) async{
    //Obtiene una referencia a la imagen que se desea subir a través de el url
    Reference referenceImageToUpload = storage.refFromURL(url);
    //Sube la imagen a Firebase Storage y obtiene la URL de descarga
    UploadTask uploadTask = referenceImageToUpload.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> saveData(String email, String collection, String filename, Uint8List file) async{
    String response = 'Some error occurred with the picture';
    try{
      String imageUrl = await uploadImage(email, collection, filename, file);
      Map<String, String> data = {
        'name': filename,
        'imageLink': imageUrl,
      };
      await firestore.collection(email).doc(collection).collection(collection).doc(filename).set(data);
      response = 'success';
    }catch(e){
        response = e.toString();
      }
    return response;
  }

  Future<String> updateData(String email, String collection, String filename, Uint8List file) async{
    String response = 'Some error occurred with the picture';
    try{
      DocumentSnapshot snapshot = await firestore.collection(email).doc(collection).collection(collection).doc(filename).get();
      String newImageUrl = await updateImage(file, snapshot['imageLink']);
      Map<String, String> data = {
        'name': filename,
        'imageLink': newImageUrl,
      };
      await firestore.collection(email).doc(collection).collection(collection).doc(filename).update(data);
      response = 'success';
    }catch(e){
        response = e.toString();
      }
    return response;
  }

  Future<void> deleteCatPicture(String email, String collection, String filename) async{
    // Obtiene una referencia a la imagen que se desea borrar
    Reference referenceRoot = storage.ref();
    Reference referenceDirImages = referenceRoot.child(email);
    Reference referenceCollection = referenceDirImages.child(collection);
    Reference referenceImageToDelete = referenceCollection.child(filename);
    // Obtiene una referencia al documento que se desea borrar
    DocumentReference referenceDocToDelete = firestore.collection(email).doc(collection).collection(collection).doc(filename);
    // Borra la imagen y el documento
    await referenceImageToDelete.delete();
    await referenceDocToDelete.delete();
  }

  Future<String> getUrl(String email, String collection, String filename) async{
    DocumentSnapshot snapshot = await firestore.collection(email).doc(collection).collection(collection).doc(filename).get();
    return snapshot['imageLink'];
  }

  Future<String> getImageLink(String email, String collection, String filename) async{
    String imageLink = '';
    DocumentReference reference = firestore.collection(email).doc(collection).collection(collection).doc(filename);
    DocumentSnapshot snapshot = await reference.get();
    snapshot.exists ?
      imageLink = snapshot['imageLink'] :
      imageLink = 'no image';
    return imageLink;
  }
}