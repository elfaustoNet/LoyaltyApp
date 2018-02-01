({
    populateMember : function(component, event, helper) {
        console.log('in populateMember');
        /* Event parameters were sent as "arugments" array */
        var params = event.getParam('arguments');
        /* pull the parameter needed */
        var loyaltyId = params.loyaltySelected;
        /* Set the loyaltyId */
        component.set("v.loyaltyId", loyaltyId);
        /* If loyalty Id is populated then get member information */
        if (loyaltyId != null)
        {
           helper.getMember(component, helper);
        }        
    }, 

    setEditable: function(component, event, helper) {
        /* Set component to editable and show/hide correct fields/btns */
        component.set("v.editable", true);
        helper.toggleDisplay(component, "saveBtn", "SHOW");
        helper.toggleDisplay(component, "cancelBtn", "SHOW");
        helper.toggleDisplay(component, "editMemberBtn", "HIDE");
        helper.toggleDisplay(component, "addPointsBtn", "HIDE");
        
    }, 

    cancelEdit : function(component, event, helper) {
        /* Cancel edit/create and perform  reset */
        component.set("v.editable", false);
        helper.toggleDisplay(component, "createMemberBtn", "HIDE");
        helper.toggleDisplay(component, "saveBtn", "HIDE");
        helper.toggleDisplay(component, "cancelBtn", "HIDE");
        helper.toggleDisplay(component, "editMemberBtn", "SHOW");
        helper.toggleDisplay(component, "addPointsBtn", "SHOW");
        var createMember = component.get("v.createMember");
        if (createMember)
        {
            helper.toggleDisplay(component, "memberDetailsCard", "HIDE");
            component.set("v.createMember", false);
        }
        else {
            //refresh the member if cancel
            helper.getMember(component, helper);
        }
        
    },

    onMemberInfoClick: function(component, event, helper) {
        var loyaltyId = event.currentTarget.getAttribute("data-userid");
        console.log('loyaltyId ' + loyaltyId);
        component.set("v.loyaltyId", loyaltyId);
        helper.getMember(component, helper);
        helper.toggleDisplay(component, "createMemberBtn", "HIDE");
        helper.toggleDisplay(component, "editMemberBtn", "SHOW");
        helper.toggleDisplay(component, "addPointsBtn", "SHOW");
        helper.toggleDisplay(component, "memberDetailsCard", "SHOW")
        helper.toggleDisplay(component, "saveBtn", "HIDE");;
        helper.toggleDisplay(component, "cancelBtn", "HIDE");

    }, 
    initializeMemberCreation: function(component, event, helper) {
        helper.intializeMember(component, helper);
        helper.toggleDisplay(component, "createMemberBtn", "SHOW");
        helper.toggleDisplay(component, "editMemberBtn", "HIDE");
        helper.toggleDisplay(component, "addPointsBtn", "HIDE");
        helper.toggleDisplay(component, "memberDetailsCard", "SHOW");
        helper.toggleDisplay(component, "cancelBtn", "SHOW");
    }, 

    createMember : function(component, event, helper) {
        helper.createMember(component, helper);
    }, 

    editMember : function(component, event, helper) {
        helper.editMember(component, helper);
    }
})
