abstract class AbstractAutenticate {
  Future googleSign();

  Future singOut();

  Future facebookSign();

  Future emailAndPassSign({required String email, required String pass});

  Future emailAndPassSignUp({required String email, required String pass});

  Future getdataUser();
}
