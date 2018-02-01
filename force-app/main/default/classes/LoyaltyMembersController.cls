public with sharing class LoyaltyMembersController {
    
    /* Method: getMembers
     * Description: Calls service to get all Members in loyalty program. 
     * Then builds the member wrapper class to display
     */
    @AuraEnabled
    public static List<Member> getMembers() {
        String results = LoyaltyService.getMembers();
        List<Member> memberList = new List<Member>();
        system.debug('results $$ ' + results);
        memberList = LoyaltyUtility.buildMemberList(results);
        system.debug('memberlist $$ ' + memberList);
        return memberList;
        
    }

    @AuraEnabled
    public static List<Member.MemberColumn> getMemberColumns() {
        List<Member__mdt> mdtList = LoyaltyUtility.getMemberMetadata();
        List<Member.MemberColumn> memberColumns = new List<Member.MemberColumn>();
        for (Member__mdt mdt : mdtList) 
        {
            if (mdt.Field_Displayed__c)
            {
                Member.MemberColumn mc = new Member.MemberColumn();
                mc.label = mdt.Field_Label__c;
                mc.type = mdt.Field_Type__c;
                mc.fieldName = mdt.Field_Name__c;
                memberColumns.add(mc);
            }
        }
        system.debug('memberColumns $$ ' + memberColumns);
        return memberColumns;
    }

    

}
