public class BootSearchFormController {
    @AuraEnabled
    public static Map<String,String> getBoatNames(){
        Map<String,String> boatNames = new Map<String,String>();
        if(boatNames.size() == 0){
                boatNames.put('All Types','NULL');
        }
        for(BoatType__c b:[select Id,name from BoatType__c])       
        { 		System.debug('Boat Types : ' + b);
				boatNames.put(b.name,String.valueOf(b.Id));                
        }
        System.debug(boatNames);
        return boatNames;
    }

    
}