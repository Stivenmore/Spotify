abstract class AbstractProvider {
  Future tokenizacion();

  Future getCategories(
      {required String locale, required String country, required int offset});

  Future gerrecomenPlays({required String market, required String ids});
}
