import 'package:cloud_firestore/cloud_firestore.dart';

class SongEntity {
  final String title;
  final String artist;
  final num duration;
  final Timestamp releaseDate;
  final bool isFavourite;
  final String songId;

  SongEntity(
      {required this.artist,
      required this.duration,
      required this.title,
      required this.releaseDate,
      required this.isFavourite,
      required this.songId});
}
