({
    getAllMembers : function(component, event, helper) {
        /*Calls apex to get all members in loyalty program */
        var action = component.get("c.getMembers");
        action.setCallback(this, function(response) {
            console.log('getAllMembers  callback $$');
            var state = response.getState();
            if (state === "SUCCESS")
            {
                console.log('getAllMembers success $$');
                var members = [];
                members = response.getReturnValue();
                console.log('members $$ ' + JSON.stringify(members));
                component.set("v.members", members);
            }
            else {
                console.log('getAllMembers error on response ' + state + ' ' + response.getError());
            }
        });
        $A.enqueueAction(action);
    }, 

    getColumns: function(component, event, helper) {
        /* Calls apex to get all columns to display */
        var action = component.get("c.getMemberColumns");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                console.log('successfully return columns ' + JSON.stringify(response.getReturnValue()));
                component.set("v.columns", response.getReturnValue());
            }
            else {
                console.log('error ' + state + ' ' + response.getError());
            }
        });
        $A.enqueueAction(action);
    }
})
