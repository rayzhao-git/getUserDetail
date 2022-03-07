({
    doInit : function(component, event, helper) {

        component.set("v.confirmationMessage1", $A.get("$Label.c.Deactivate_Confirmation_Message"));
        component.set("v.confirmationMessage2", $A.get("$Label.c.Deactivate_Confirmation_Message2"));
        console.log('++++++++in doInit, Deactivate_Confirmation_Message = <' + $A.get("$Label.c.Deactivate_Confirmation_Message") + '>');
        console.log('++++++++in doInit, Deactivate_Confirmation_Message2 = <' + $A.get("$Label.c.Deactivate_Confirmation_Message2") + '>');
    },

    yesProceed : function(component, event, helper){

        let conId = component.get("v.recordId");
        console.log('++++++++in yesProceed, conId = <' + conId + '>');
        var action = component.get("c.deactivateMember");
        action.setParams({
            conId: conId
        });
        action.setCallback(this, function(r) {
            var info = r.getReturnValue();
            console.log('++++++++returned Server call, getState: <' + r.getState() + '>');    
            if (r.getState() === "SUCCESS") {
                console.log('++++++++returned Server call, SUCCESS!  info: <' + info[1] + '><' + JSON.stringify(info) + '>');    
                if (info[1] === 'Success'){
                    //console.log('++++++++returned Server call, in if...' + $A.get("$Label.c.Deactivate_Success_Message"));    
                    var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                        "type": 'success',
                        "message": $A.get("$Label.c.Deactivate_Success_Message")
                    });
                    resultsToast.fire();            
                }            
                else{
                    console.log('++++++++returned Server call, in else...' + $A.get("$Label.c.Deactivate_Failure_Message")+info[0]);    
                    var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                        "type": 'error',
                        "message": $A.get("$Label.c.Deactivate_Failure_Message")+info[0]
                    });
                    resultsToast.fire();            
                }
            }
            else if (r.getState() === "ERROR"){
                console.log('++++++++returned Server call, FAILURE!');
                console.log('++++++++returned Server call, Error Msg:' + JSON.stringify(r.getError()));
                var resultsToast = $A.get("e.force:showToast");
                resultsToast.setParams({
                    "type": 'error',
                    "message": $A.get("$Label.c.Deactivate_Failure_Message")  + JSON.stringify(r.getError())
                });
                resultsToast.fire();            
            }
            else{
                console.log('++++++++Possibly incomplete yet... getState(): <' + r.getState() +'>');
            }
        });
        $A.enqueueAction(action);

        var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire();        
     },

    noCancel : function(component, event, helper){

        // Close the action panel
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire();        
    },

    showResultToast : function(result, type){

        // Display the total in a "toast" status message
        console.log('++++++++in showResultToast...');
        var resultsToast = $A.get("e.force:showToast");

        resultsToast.setParams({
            "type": type,
            "title": type.toUpperCase(),
            "message": result,
            "mode": type === 'success' ? "pester" : "dismissible"
        });
        resultsToast.fire();
    }
})
