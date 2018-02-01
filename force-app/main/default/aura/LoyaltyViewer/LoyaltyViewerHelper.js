({
    getMember: function(component, helper) {
        console.log('in member');
        var memberId = component.get("v.loyaltyId");
        console.log('in getMember ' + memberId);
        var action = component.get("c.getMember");
        action.setParams({"memberId" : memberId});
        action.setCallback(this, function(response) { 
            var state = response.getState();
            if(state === "SUCCESS") {
                console.log('successfully return record');
                component.set("v.member", response.getReturnValue());
                helper.toggleDisplay(component, "editMemberBtn", "SHOW");
                helper.toggleDisplay(component, "memberDetailsCard", "SHOW");
            }
            else {
                console.log('error ' + state + ' ' + response.getError());
            }
            component.set("v.editable", false);
        });
        $A.enqueueAction(action);
    }, 

    intializeMember: function(component, helper) {
        console.log('in initializeMember');
        var action = component.get("c.initializeMember");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                console.log('initializeMember successfully return record');
                component.set("v.member", response.getReturnValue());
                // Set the visibility settings of editable to true
                component.set("v.editable", true);
                component.set("v.createMember", true);
               // default loyaltyId attribute to null in case there was one previouslly populated
                component.set("v.loyaltyId", null);
            }
            else {
                console.log('initializeMember - error ' + state + ' ' + response.getError());
            }
        });
        $A.enqueueAction(action);
    }, 
    createMember: function(component, helper) {
        // Component to create the member server
        console.log('createMember helper');
        var member = component.get("v.member");
        member = JSON.stringify(member);
        console.log('member $$ ' + member);
        var action = component.get("c.createNewMember");
        action.setParams({"newMember" : member});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                console.log('initializeMember successfully return record');
                component.set("v.member", response.getReturnValue());
                // edit complete set editable to false
                component.set("v.editable", false);
                var isCreate = component.get("v.createMember");
                if(isCreate) {
                    component.set("v.createMember", false);
                }
                //hide memberdetails
                helper.toggleDisplay(component, "memberDetailsCard", "HIDE");
                helper.toggleDisplay(component, "cancelBtn", "HIDE");
                helper.toggleDisplay(component, "createMemberBtn", "HIDE");
                component.set("v.loyaltyId", null);
                helper.sendToast("Created", "Member has been created." );
                helper.sendUpdateEvent(component, helper);
            }
            else {
                console.log('initializeMember - error ' + state + ' ' + response.getError());
            }
        });
        $A.enqueueAction(action);
    }, 
    toggleDisplay : function(component, cmpname, type)
    {
        /* component to do show / hide on markup */
        var cmp = component.find(cmpname);
        if (type === 'SHOW')
        {
            $A.util.removeClass(cmp, "slds-hide");
        }
        else {
            $A.util.addClass(cmp, "slds-hide");
        }
    }, 

    editMember: function(component, helper) {
        console.log('editMember helper');
        var member = component.get("v.member");
        member = JSON.stringify(member);
        console.log('editMember member $$ ' + member);

        var action = component.get("c.saveEditMember");
        action.setParams({"editMember" : member, 
                        "loyaltyId" : component.get("v.loyaltyId")
                    });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                console.log('initializeMember successfully return record');
                component.set("v.editable", false);
                helper.toggleDisplay(component, "editMemberBtn", "SHOW");
                helper.toggleDisplay(component, "addPointsBtn", "SHOW");
                helper.toggleDisplay(component, "saveBtn", "HIDE");;
                helper.toggleDisplay(component, "cancelBtn", "HIDE");
                helper.sendToast("Saved", "Member has been updated." ); 
                helper.sendUpdateEvent(component, helper);
                helper.getMember(component,helper);
            }
            else {
                console.log('initializeMember - error ' + state + ' ' + response.getError());
            }
        });
        $A.enqueueAction(action);
    },
     

    sendToast : function(title, message) {
        var toastEvent = $A.get("e.force:showToast");
        if (toastEvent){
            toastEvent.setParams({
                "title": title, 
                "message" : message
            });
            toastEvent.fire();
        }
        else {
            alert(message);
        }
    },

    sendUpdateEvent : function(component, helper) {
        console.log('fire sendUpdateEvent');
        var memberUpdateEvent = component.getEvent("memberUpdated");
        memberUpdateEvent.fire();

    }
})
