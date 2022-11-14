@isTest
public class FedexCalloutMock implements HttpCalloutMock {
  List<HttpResponse> httpResponses = new List<HttpResponse>();
  Integer responseIndex = 0;

  public void addResponse(String response, Integer statusCode) {
    HttpResponse httpResponse = new HttpResponse();
    httpResponse.setBody(response);
    httpResponse.setStatusCode(statusCode);
    httpResponses.add(httpResponse);
  }
  public HttpResponse respond(HttpRequest request) {
    return httpResponses[responseIndex++];
  }
}
