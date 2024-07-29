import 'package:dartz/dartz.dart';

abstract class Songrepo {
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  //Future<Either> addOrRemoveFavoriteSongs(String songId);
  //Future<bool> isFavoriteSong(String songId);
  //Future<Either> getUserFavoriteSongs();
}
