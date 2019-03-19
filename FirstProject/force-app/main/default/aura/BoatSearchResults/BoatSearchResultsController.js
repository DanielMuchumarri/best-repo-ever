({
    doInit : function(component, event, helper) {
        console.log('do Init');
        helper.onSearch(component,event,helper);
    },
    doSearch : function(component,event,helper){
        alert('Hello');
        var params = event.getParam('arguments');
        if(params){
            component.set('v.boatTypeId',params.boatTypeId);
            alert('component.get boatTypeId'+component.get('v.boatTypeId'));
            helper.onSearch(component,event,helper);
        }
        
    }
})