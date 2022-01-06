abstract class AbstractProvider {
  Future tokenizacion();

  Future getCategories(
      {required String locale, required String country, required int offset});

  Future gerrecomenCate({required String market, required String ids});

  Future getrecomenPlays(
      {required String categoryID,
      required String country,
      required int offset});

  Future getallTracks({
    required String playlistID,
    required int offset,
  });

  Future getSingleTrack({required String id});

  Future getSingleArtist({required String id});

  Future getTopTracksArtist({required String id});
  
  Future getSearchTracks({required String q,
      required int offset});
}
