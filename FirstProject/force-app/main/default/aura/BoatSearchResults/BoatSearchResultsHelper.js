({
	onSearch : function(component,event,helper) {
		var action = component.get("c.getBoats");     
        console.log('State Value');
        var frmId = component.get('v.boatTypeId');
        alert('Boat Type Id : ' + frmId);
        if(frmId != null){
            action.setParams({boatTypeId : frmId});            
        }else{
        	action.setParams({boatTypeId : ""});  
        }        
        action.setCallback(this,function(response){            
            var state = response.getState(); 
            console.log('State Value' + state);
            if(state === "SUCCESS"){
                console.log('response value' + JSON.stringify(response.getReturnValue()));
                component.set("v.boats",response.getReturnValue());
            }else{
                //console.log('Error Value ' + JSON.stringify(response));
                
                let errors = response.getError();
                let message = 'Unknown error'; // Default error message
                // Retrieve the error message sent by the server
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    message = errors[0].message;
                }
                // Display the message
                console.log(message);
                component.set("v.errorMsg","No boats found");
            }            
        });
        
        $A.enqueueAction(action);
	}
})