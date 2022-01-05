abstract class AbstractProvider {
  Future tokenizacion();

  Future getCategories(
      {required String locale, required String country, required int offset});

  Future gerrecomenCate({required String market, required String ids});
  
  Future getrecomenPlays({required String categoryID, required String country, required int offset});
}
