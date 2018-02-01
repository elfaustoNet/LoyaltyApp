public  class Member {
     
    @AuraEnabled
    public List<MemberField> memberFields {get; set;}
    
    public Member() {
        memberFields = new List<MemberField>();
    }
    /* Class: MemberField
     * Description: Wrapper for displaying webservice data dynamicly
     */
    public class MemberField {
        @AuraEnabled
        public String fieldLabel {get; set;}
        @AuraEnabled
        public String fieldName {get; set;}
        @AuraEnabled
        public String fieldType {get; set;}
        @AuraEnabled
        public Integer fieldValueInt {get; set;}
        @AuraEnabled
        public String fieldValueString {get; set;}
        @AuraEnabled
        public boolean fieldValueBoolean {get; set;}
        @AuraEnabled
        public boolean fieldDisabled {get; set;}
        @AuraEnabled
        public boolean fieldDisplayed {get; set;}


        public MemberField() {

        }
    }

    public class MemberColumn {
        
        @AuraEnabled
        public string label {get; set;}
        @AuraEnabled
        public string fieldName {get; set;}
        @AuraEnabled
        public string type {get; set;}
        public MemberColumn() {

        }
    }
}
