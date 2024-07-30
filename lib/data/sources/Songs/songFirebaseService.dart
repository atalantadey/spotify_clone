import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/song/songModel.dart';
import 'package:spotify/domain/entities/song/song.dart';

abstract class Songfirebaseservice {
  Future<Either> getNewSongs();
  Future<Either> getPlayList();
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
          .limit(10)
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
}
