public with sharing class LoyaltyViewerController {
    
    /* Method: getMember
     * Parameters: memberId - Id of the member from external System. 
     * Description: Calls service to get member information. Builds the Member wrapper class
     */
    @AuraEnabled
    public static Member getMember(String memberId) {
        system.debug('memberID in getMember $$ ' + memberId);
        //Callout to service
        String results = LoyaltyService.getMember(memberId);
        Member memberResult = new Member();
        system.debug('results $$ ' + results);
        //deserialize results into object
        Object obj = (Object)JSON.deserializeUntyped(results); 
        List<Member__mdt> mData = LoyaltyUtility.getMemberMetadata();
        memberResult.memberFields = LoyaltyUtility.buildMemberFields(obj, mData);
        system.debug('memberResult $$ ' + memberResult);
        return memberResult;
        
    }

    /* Method: initializeMember
     * Description: Builds an empty member so that user can create new Member
     */
    @AuraEnabled
    public static Member initializeMember() {
        Member newMember = new Member();
        List<Member__mdt> mData = LoyaltyUtility.getMemberMetadata();
        newMember.memberFields = LoyaltyUtility.buildMemberFields(null, mData);
        system.debug('initializeMember $$ ' + newMember);
        return newMember;
    }

    /* Method: createNewMember 
     * Parameters: newMember - json string of member to create
     * Description: Takes the member json from Lightning component, builds request to web service. 
     * Then makes call to service
     */
    @AuraEnabled
    public static String createNewMember(String newMember) {
        system.debug('entered createNewMember $$' + newMember);
        Object obj = (Object)JSON.deserializeUntyped(newMember);
        Map<String,Object> mp_StrObj = (Map<string,Object>)obj;
        Object mfield = mp_StrObj.get('memberFields');
        system.debug(' mfield $$ ' + mField);
        Map<String,Object> todo = new Map<String,Object>();
        for(Object mf : (List<Object>)mField)
        {
            system.debug('mf $$ ' + mf);
            Map<String,Object> mp2 = (Map<string,Object>)mf;
            String fieldValue = String.valueOf(mp2.get('fieldValueString'));
            String fieldName = String.valueOf(mp2.get('fieldName'));
            if (String.isNotEmpty(fieldValue) && fieldValue != null)
            {
                system.debug('String is valid $$ ' + fieldValue + ' field name ' + fieldName);
                todo.put(fieldName, fieldValue);
               
            }
        }
       
        String jsonString = Json.serialize(todo);
        system.debug('serialized  $$ '+ jsonString);
        LoyaltyService.createMember(jsonString);
        return null;
    }

    /* Method: saveEditMember
     * Parameters: editMember - json of member, loyaltyId - id of member from external service
     * Description: Constructs json body for web serivce. Calls method that updates loyalty info.
     */
    @AuraEnabled
    public static String saveEditMember(String editMember, String loyaltyId) {
        string jsonBody = buildMemberJSON(editMember);
        LoyaltyService.editMember(loyaltyId, jsonBody);
        return null;
    }

    /* Method: buildMemberJSON 
     * Parameters: theMember - json of Member 
     * Description: Takes the json of Member from Lightning component and creates the request for the webserivce. 
        This is done because the Member wrapper has a bunch of 'how to display' type information that isn't part of loyalty data
     */
    private static String buildMemberJSON(String theMember) {
        system.debug('entered creatbuildMemberJSON theMember $$' + theMember);
        Object obj = (Object)JSON.deserializeUntyped(theMember);
        system.debug('newMember Object $$ ' + obj);
        Map<String,Object> mp_StrObj = (Map<string,Object>)obj;    
        Object mfield = mp_StrObj.get('memberFields');
        system.debug(' Object 2 $$ ' + mField);
        Map<String,Object> todo = new Map<String,Object>();
        for(Object mf : (List<Object>)mField)
        {
            
            system.debug('mf $$ ' + mf);
            Map<String,Object> mp2 = (Map<string,Object>)mf;
            String fieldValue = String.valueOf(mp2.get('fieldValueString'));
            String fieldName = String.valueOf(mp2.get('fieldName'));
            if (String.isNotEmpty(fieldValue) && fieldValue != null)
            {
                system.debug('String is valid $$ ' + fieldValue + ' field name ' + fieldName);
                todo.put(fieldName, fieldValue);
               
            }
        }
       
        String json = Json.serialize(todo);
        system.debug('serialized  $$ '+ json);
        return json;

    }
}
