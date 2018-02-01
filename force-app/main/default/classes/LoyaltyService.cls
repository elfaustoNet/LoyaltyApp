 /* Class: LoyaltyService
  * Description: This class performs the HTTP callouts to the external loyalty application/database
  */
public with sharing class LoyaltyService {
    /* Name: calloutPathPrefix
     * Description: path for named credential
     */
    public static final String calloutPathPrefix = 'callout:Loyalty_App';
    
    /* Method: getMembers
     * Desription: Makes callout to get all the members of the loyalty program
     */
    public static String getMembers() {
        HttpRequest request = new HttpRequest();
        request.setEndpoint(calloutPathPrefix + '/api/members');
        request.setMethod('GET');
        Http http = new Http();
        HttpResponse response = http.send(request);
        system.debug('getMembers response.body $$ ' + response.getbody());
        return response.getBody();
    }

    /* Method: getMember
     * Parameters: memberId - Id of member
     * Description: Makes callout to get specific member's information
     */
    public static String getMember(String memberId) {
        HttpRequest request = new HttpRequest();
        system.debug('geMember loyaltyService memberId $$' + memberId);
        request.setEndpoint(calloutPathPrefix + '/api/members/' + memberId);
        request.setMethod('GET');
        Http http = new Http();
        HttpResponse response = http.send(request);
        system.debug('getMember response.body $$ ' + response.getbody());
        return response.getBody();
    }
    
    /* Method: createMember
     * Parameters: newMember - JSON of Member
     * Description: Makes callout to create new member
     */
    public static String createMember(String newMember) {
        system.debug('newMember $$ ' + newMember);
        HttpRequest request = new HttpRequest();
        request.setEndpoint(calloutPathPrefix + '/api/members');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(newMember);
        system.debug('requestbody ' + request.getBody());
        Http http = new Http();
        HttpResponse response = http.send(request);
        system.debug('createMember response.body $$ ' + response.getBody());
        return response.getBody();
    }

    /* Method: editMember
     * Parameters: loyaltyId - id of member, editMember - JSON of member
     * Description: Makes callout to update member information
     */
    public static String editMember(String loyaltyId, String editMember) {
        system.debug('editMember $$ ' + editMember);
        HttpRequest request = new HttpRequest();
        request.setEndpoint(calloutPathPrefix + '/api/members/' + loyaltyId);
        request.setMethod('PUT');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(editMember);
        
        system.debug('requestbody ' + request.getBody());
        Http http = new Http();
        HttpResponse response = http.send(request);
        system.debug('editMember response.body $$ ' + response.getBody());
        return response.getBody();
    }
}
