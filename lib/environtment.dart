final String ENV = 'dev'; // prod
final String API_DEV =
    "http://10.2.115.59/backend_arsip/public/api/v1/"; //10.2.115.59
// if get compiled
final String API_PROD = "https://apisudikap.gotrain.id/public/api/v1/";
String Base_Url = ENV == 'prod' ? API_PROD : API_DEV;
String App_version = "";

// print("${Base_url}");
