({
    doInit : function(component, event, helper) {
        /* Does initial Load of the member list */
        console.log('in doinit');
        helper.getColumns(component,event, helper);
        helper.getAllMembers(component,event,helper);
    },
    createNewMember : function(component, event, helper) {
        /* Fires createMember event when button clicked */
        console.log('in createNewMember');
        var createMemberEvent = component.getEvent("createLoyaltyMember");
        createMemberEvent.fire();
    }, 
    loyaltyMemberSelected : function(component, event, helper) {
        /* gets loyalty id from the link "data-fieldValue" attribute of the event and fires the component event */
        console.log('in LoyaltyMemberSelected');
        var loyaltyId = event.currentTarget.getAttribute("data-fieldValue");
        console.log('loyaltyMemberSelected loyaltyId ' + loyaltyId);
        var memberSelectedEvent = component.getEvent("loyaltyMemberSelected");
        memberSelectedEvent.setParams({"loyaltyId" : loyaltyId});
        memberSelectedEvent.fire();
    }
})
