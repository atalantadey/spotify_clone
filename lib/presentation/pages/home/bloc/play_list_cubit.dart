import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/usecases/Songs/get_playList.dart';
import 'package:spotify/service_locater.dart';

import 'play_list_state.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(PlayListLoading());

  Future<void> getPlayList() async {
    var returnedSongs = await sl<GetPlaylistUseCase>().call();
    returnedSongs.fold((l) {
      emit(PlayListLoadFailure());
    }, (data) {
      emit(PlayListLoaded(songs: data));
    });
  }
}
