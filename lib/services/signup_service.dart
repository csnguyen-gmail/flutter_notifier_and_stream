abstract class SignUpBaseApi {
  Future<bool> checkAccountValid(String account);
}

class SignUpApi implements SignUpBaseApi{
  @override
  Future<bool> checkAccountValid(String account) async{
    await Future.delayed(Duration(milliseconds: 500));
    return account.length > 0 && account != "csnguyen";
  }
}