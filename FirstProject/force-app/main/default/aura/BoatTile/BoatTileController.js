({
/*	doInit : function(component, event, helper) {
        console.log('do Init');
        var action = component.get("c.getBoatRecs");     
        console.log('State Value');
        action.setCallback(this,function(response){            
            var state = response.getState(); 
            console.log('State Value' + state);
            if(state === "SUCCESS"){
                console.log('response value' + JSON.stringify(response.getReturnValue()));
                component.set("v.boat",response.getReturnValue());
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
            }            
        });
        
        $A.enqueueAction(action);
	}
*/
})