({
	onFormSubmit : function(component, event, helper) {
        var eventParam = event.getParam("formData");
        var boatTypeId = eventParam.boatTypeId;
        alert('Hello1');
        var childCmp = component.find("BoatSearchResults");
            childCmp.search(boatTypeId);
        alert('Hello2');
        //alert('boatTypeId' + boatTypeId);
	}
})