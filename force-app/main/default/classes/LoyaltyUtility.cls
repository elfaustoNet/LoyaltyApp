public with sharing class LoyaltyUtility {
    
    /* Method: getMemberMetadata
     * Description: Method to retrieve the Loyalty Member display configurations
     */
    public static List<Member__mdt> getMemberMetadata() {
        List<Member__mdt> memberMetadataList = new List<Member__mdt>();
        memberMetadataList = [Select Field_Label__c, Field_Name__c, Field_Type__c, Field_Displayed__c, 
            Field_Editable__c, Sort_Order__c from Member__mdt order by Sort_Order__c asc];
        return memberMetadataList;
    }

     /* Method: buildMemberFields
     * Parameters: Obj - object of json response, mData - Custom metadata that controls display and editability of loyalty data
     * Description: Takes the response and builds Member accessibility data so that the Lightning component can display everything properly
     */
    public static List<Member.MemberField> buildMemberFields(Object obj, List<Member__mdt> mData) {
        List<Member.MemberField> memberFieldList = new List<Member.MemberField>();

        Map<String,Object> mp_StrObj;
        if (obj != null) 
            mp_StrObj = (Map<string,Object>)obj;
        
        for (Member__mdt mdt : mData) {
            Member.MemberField m = new Member.MemberField();
            m.fieldLabel = mdt.Field_Label__c;
            m.fieldType = mdt.Field_Type__c;
            m.fieldName = mdt.Field_Name__c;
            if (mp_StrObj != null)
                m.fieldValueString = (String)mp_StrObj.get(mdt.Field_Name__c);
            else 
                m.fieldValueString = '';
            m.fieldDisplayed = mdt.Field_Displayed__c;
            if (mdt.Field_Editable__c)
            {
                m.fieldDisabled = false;
            }
            else {
                m.fieldDisabled = true;
            } 
               
            memberFieldList.add(m);   
           
        }
         system.debug('memFieldList $$ ' + memberFieldList);
         return memberFieldList;
    }

    /* Method: buildMemberList
     * Parameter: jsonString - results from webservice
     * Description: Receives a jsonString of Members and builds the list to display on screen
     */
    public static List<Member> buildMemberList(String jsonString) {
        List<Member> memberList = new List<Member>();
        List<Object> objList = (List<Object>)JSON.deserializeUntyped(jsonString);
        List<Member__mdt> mData = getMemberMetadata();
        for(Object obj : objList)
        {
            Member m = new Member();
            m.MemberFields = buildMemberFields(obj, mData);
            memberList.add(m);
        }
        return memberList;
    }
    
}
