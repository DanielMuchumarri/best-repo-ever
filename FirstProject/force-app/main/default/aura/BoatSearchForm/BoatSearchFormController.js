({
    doInit : function(component, event, helper) {
        console.log('isEnabledn $$$$ 1111');
        var isEnabled = $A.get("e.force:createRecord");
        console.log('isEnabledn $$$$' + isEnabled);
        if(isEnabled){
            component.set("v.isForceCreateRecordAllowed", true);
        }else{
            component.set("v.isForceCreateRecordAllowed", false);
        }        
        
        var action = component.get("c.getBoatNames");
        //action.setParams("{}");
        action.setCallback(this,function(response){
            var state = response.getState();            
            if(state === "SUCCESS"){
                //alert("From Serve : " + response.getReturnValue());
                var selectOptions=[];
                //var options={};
                var optionValuesFromServer = response.getReturnValue();
                console.log('Options List 2323' + JSON.stringify(response.getReturnValue()));
                var i=0;
                //var value;
                Object.keys(optionValuesFromServer).forEach(function(key) {
                    var options={};
                    options.label= key;
                    options.value=optionValuesFromServer[key];
                    selectOptions[i] = options;
                    i++;
                });
                component.set("v.options",selectOptions);
                console.log('Options List' + JSON.stringify(component.get("v.options")));
            }
        });
        $A.enqueueAction(action);
        
    },
    createBoatRecord : function(component,event,helper){
        var createRecordEvent = $A.get("e.force:createRecord");
        var selectedOptionValue = component.get("v.selectedValue");
        console.log('selectedOptionValue !!!!' + selectedOptionValue);
        if(selectedOptionValue == ""){            
            createRecordEvent.setParams({
                "entityApiName": "Boat__c"                
            });
        }else{
            console.log('else section !!!!' + selectedOptionValue);
            createRecordEvent.setParams({
                "entityApiName": "Boat__c",
                "defaultFieldValues": {
                    'BoatType__c' : selectedOptionValue
                }
            });
        }
        createRecordEvent.fire();
    },
    selectChange:function(component,event,helper){
        
        console.log('Selected Value is !!!!!' + component.get("v.selectedValue"));
        
    },
    onFormSubmit:function(component,event,helper){        
        var boatTypeId = component.get("v.selectedValue"); 
        var fEvent = component.getEvent("formsubmit");        
        fEvent.setParams({"formData":
                          {"boatTypeId" : boatTypeId}
                         });
        fEvent.fire();        
    }
})