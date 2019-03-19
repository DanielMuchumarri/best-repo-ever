({
	saveAccount : function(component, event, helper) {
        //alert("1");
        component.find("recordEditor").saveRecord(function(saveResult){            
            if(saveResult.state === "SUCCESS" || saveResult.state === "DRAFT"){                
                var resultsToast = $A.get("e.force:showToast");
                resultsToast.setParams({
                    "title":"Saved",
                    "message":"The record was save."
                });
                resultsToast.fire();
            }else if(saveResult.state === "ERROR"){                
                var errMsg="";
                /*
                for(var i=0;saveResult.error.length;i++){
                    alert(JSON.stringify(saveResult.error[i]));
                    errMsg += saveResult.error[i] + "\n";                    
                }
                */
                errMsg = saveResult.error[0];
                component.set("v.recordSaveError",errMsg.message);
            }
        });
	}
})