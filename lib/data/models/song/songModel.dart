import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify/domain/entities/song/song.dart';

class Songmodel {
  String? title;
  String? artist;
  num? duration;
  Timestamp? releaseDate;

  Songmodel(
      {required this.artist,
      required this.duration,
      required this.title,
      required this.releaseDate});

  Songmodel.fromJson(Map<String, dynamic> data) {
    title = data['title'];
    artist = data['artist'];
    duration = data['duration'];
    releaseDate = data['releaseDate'];
  }
}

extension SongmodelX on Songmodel{
  SongEntity toEntity(){
    return SongEntity(
      artist: artist!,
       duration: duration!,
        title: title!,
         releaseDate: releaseDate!
         );
  }
}