({
    onCreateMember : function(component, event, helper) {
       console.log('in LoyaltyControl onCreateMember');
       var resultComponent = component.find("loyaltyViewer");
       resultComponent.initializeNewMember();

    }, 
    onMemberSelected : function(component, event, helper) {
        console.log('onMemberSelected');
        var loyaltySelected = event.getParam("loyaltyId");
        console.log('onMemberSelected loyaltyId ' + loyaltySelected);
        var resultComponent = component.find("loyaltyViewer");
        resultComponent.populateMember(loyaltySelected);
    }, 
    onMemberUpdate : function(component, event, helper) {
        console.log('onMemberUpdate');
        var resultComponent = component.find("loyaltyMembers");
        resultComponent.refreshData();
    }
})
