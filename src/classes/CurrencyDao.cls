public class CurrencyDao {

    public static String get(){
        String body =
                '<?xml version="1.0" encoding="utf-8"?>' +
                '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                '<soap:Body>' +
                '<ExRatesDaily xmlns="http://www.nbrb.by/">' +
                '<onDate>2018-06-20</onDate>' +
                '</ExRatesDaily>' +
                '</soap:Body>' +
                '</soap:Envelope>';

        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://www.nbrb.by/Services/ExRates.asmx');
        request.setMethod('POST');
        request.setHeader('Host', 'www.nbrb.by');
        request.setHeader('Content-Type','text/xml; charset=utf-8');
        request.setHeader('Content-Length','length');
        request.setHeader('SOAPAction','"http://www.nbrb.by/ExRatesDaily"');
        request.setTimeout(120000);
        request.setBody(body);

        Http http = new Http();
        HttpResponse httpResponse = http.send(request);
        
//        Dom.Document document = httpResponse.getBodyDocument();

        return httpResponse.getBody();
    }
}