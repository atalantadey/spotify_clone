import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/data/models/song/songModel.dart';
import 'package:spotify/domain/entities/song/song.dart';

abstract class Songfirebaseservice {
  Future<Either> getNewSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavouriteSong(String songId);
  Future<bool> isFavouriteSong(String songId);
}

class SongfirebaseserviceImpl extends Songfirebaseservice {
  @override
  Future<Either> getNewSongs() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .limit(4)
          .get();

      for (var element in data.docs) {
        var songModel = Songmodel.fromJson(element.data());
        songs.add(songModel.toEntity());
      }

      return Right(songs);
    } catch (e) {
      print('Error for New Songs : $e');
      return const Left('An Unfortunate Error Occurred, Please Try Again!');
    }
  }

  @override
  Future<Either> getPlayList() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: false)
          .limit(15)
          .get();

      for (var element in data.docs) {
        var songModel = Songmodel.fromJson(element.data());
        songs.add(songModel.toEntity());
      }

      return Right(songs);
    } catch (e) {
      print('Error for Playlist Songs : $e');
      return const Left('An Unfortunate Error Occurred, Please Try Again!');
    }
  }

  @override
  Future<Either> addOrRemoveFavouriteSong(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      late bool isFavourite;
      var user = await firebaseAuth.currentUser;
      String Uid = user!.uid;
      QuerySnapshot favouriteSongs = await firebaseFirestore
          .collection('Users')
          .doc(Uid)
          .collection('Favourites')
          .where('songId', isEqualTo: songId)
          .get();

      if (favouriteSongs.docs.isNotEmpty) {
        await favouriteSongs.docs.first.reference.delete();
        isFavourite = false;
      } else {
        firebaseFirestore
            .collection('Users')
            .doc(Uid)
            .collection('Favourites')
            .add({
          'songId': songId,
          'addedDate': Timestamp.now(),
        });
        isFavourite = true;
      }
      return Right(isFavourite);
    } catch (e) {
      return const Left('An Error has occured , Please Try Again!');
    }
  }

  @override
  Future<bool> isFavouriteSong(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = firebaseAuth.currentUser;
      String Uid = user!.uid;
      QuerySnapshot favouriteSongs = await firebaseFirestore
          .collection('Users')
          .doc(Uid)
          .collection('Favourites')
          .where('songId', isEqualTo: songId)
          .get();

      if (favouriteSongs.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
