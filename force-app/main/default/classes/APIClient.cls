public with sharing class APIClient {
  public static HttpResponse apiCall(
    String method,
    String path,
    String token,
    String body
  ) {
    HttpRequest request = new HttpRequest();
    request.setHeader('Content-Type', 'application/json');
    request.setHeader('Authorization', 'Bearer ' + getAccessToken());
    request.setEndpoint('callout:' + 'Fedex_Sandbox' + path);
    request.setMethod(method);
    if (body != null) {
      request.setBody(body);
    }
    system.debug('Request ' + request.getBody());
    Http http = new Http();
    HttpResponse response;
    response = http.send(request);
    return response;
  }

  public static String getAccessToken() {
    HttpRequest request = new HttpRequest();
    String requestBody = '';

    Map<String, String> requestVals = new Map<String, String>();
    /*As for demo directly adding client_id and client secret here */
    requestVals.put('grant_type', 'client_credentials');
    requestVals.put('client_id', 'l76d77953a0f324fa2910834e632fb79ed');
    requestVals.put('client_secret', 'd20b9951a4b746febf1efdca4405876f');

    for (String thisKey : requestVals.keySet()) {
      requestBody +=
        EncodingUtil.urlEncode(thisKey, 'UTF-8') +
        '=' +
        EncodingUtil.urlEncode(requestVals.get(thisKey), 'UTF-8') +
        '&';
    }
    requestBody.removeEnd('&');
    String endpoint = 'callout:Fedex_Sandbox/oauth/token';
    request.setBody(requestBody);
    request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.setEndpoint(endpoint);
    request.setMethod('POST');
    Http http = new Http();
    HttpResponse response;
    response = http.send(request);

    TokenResponse token = (TokenResponse) JSON.deserialize(
      response.getBody(),
      TokenResponse.class
    );

    return token.access_token;
  }

  public class TokenResponse {
    public String access_token;
    public String token_type;
    public Integer expires_in;
    public String scope;
  }
}
