trigger OpportunityForecastTrigger on Opportunity (after insert, after update) {
    set < id > oppIds = new set < id > (); // Opportunity Record Ids
    set < id > oppOwnerIds = new set < id > ();// Opportunity Owner Ids
    List<Applied_to_Forecast__c> insertAF = new List<Applied_to_Forecast__c>();
    Map<id,Map<String,id>> RepForecastMap = new Map<id,Map<String,id>>();//Key->UserId, Value(Key->Month/Year, value RepForecast-Record-Id)
    Map<id,Applied_to_Forecast__c> oppId_afId_Map = new Map < id , Applied_to_Forecast__c>();// Key->opportunity Id, value->Applied to Forecast 
    
    set<string> openStages_Set = new set<string>();// Open-Stages
    set<string> winStages_Set = new set<string>();// Win/closed-Stages
    for(OpportunityStage Obj:[SELECT Id, ApiName FROM OpportunityStage WHERE IsWon != true AND IsClosed != true])    
        openStages_Set.add(Obj.ApiName);
    for(OpportunityStage Obj:[SELECT Id, ApiName FROM OpportunityStage WHERE IsWon = true AND IsClosed = true])
        winStages_Set.add(Obj.ApiName);
    
    for(Opportunity Obj:trigger.new){
        oppIds.add(Obj.id);
        oppOwnerIds.add(Obj.OwnerId);
    }
    for(Id Obj:oppOwnerIds)
    	RepForecastMap.put(Obj,new Map<String,Id>());
    for(Rep_Forecast__c Obj:[SELECT Forecast_Period_Start__c,Id,Name,OwnerId,Rep_Comments_about_Period_Forecast__c,Sales_Rep__c,Untracked_WAG__c FROM Rep_Forecast__c where Forecast_Period_Start__c!=null and Sales_Rep__c!=null and Sales_Rep__c in:oppOwnerIds ORDER BY CreatedDate DESC  NULLS FIRST])
	        RepForecastMap.get(Obj.Sales_Rep__c).put(Obj.Forecast_Period_Start__c.Month()+''+Obj.Forecast_Period_Start__c.year(),Obj.id);
    for(Applied_to_Forecast__c Obj:[SELECT CreatedDate,Id,Name,Opportunity__c,Rep_Forecast__c,Rep_Forecast__r.Sales_Rep__c,Status__c FROM Applied_to_Forecast__c where Opportunity__c in:oppIds and  Rep_Forecast__r.Sales_Rep__c!=null ORDER BY CreatedDate ASC NULLS FIRST])
    	oppId_afId_Map.put(Obj.Opportunity__c,Obj);
    
    List<Rep_Forecast__c> RF_List = new List<Rep_Forecast__c>();
    Map<id,User> userList = new Map<id,User>([select Id, Firstname,LastName from user where id in:oppOwnerIds]);
    for(Opportunity Obj:trigger.new){
        if(RepForecastMap.get(Obj.OwnerId).get(Obj.closedate.Month()+''+Obj.closedate.year())==null)
            RF_List.add(new Rep_Forecast__c(Name=userList.get(Obj.OwnerId).LastName+' - '+Obj.closedate.Month()+'/1',Sales_Rep__c=Obj.OwnerId,Forecast_Period_Start__c=Date.newInstance(Obj.closedate.year(), Obj.closedate.month(), 1)));
    }
    if(RF_List.size()>0)
        insert RF_List;
    for(Rep_Forecast__c Obj:[SELECT Forecast_Period_Start__c,Id,Name,OwnerId,Rep_Comments_about_Period_Forecast__c,Sales_Rep__c,Untracked_WAG__c FROM Rep_Forecast__c where Forecast_Period_Start__c!=null and Sales_Rep__c!=null and Sales_Rep__c in:oppOwnerIds ORDER BY CreatedDate DESC  NULLS FIRST])
	        RepForecastMap.get(Obj.Sales_Rep__c).put(Obj.Forecast_Period_Start__c.Month()+''+Obj.Forecast_Period_Start__c.year(),Obj.id);
    
    for(Opportunity Obj:Trigger.new){
        if(!openStages_Set.contains(Obj.StageName)){             
            if(!winStages_Set.contains(Obj.StageName)){
                insertAF.add(oppId_afId_Map.get(Obj.id)!=Null? new Applied_to_Forecast__c(id=oppId_afId_Map.get(Obj.id).id,Status__c='4 - Lost',Opportunity__c=Obj.id,Rep_Forecast__c=RepForecastMap.get(Obj.OwnerId).get(Obj.closedate.Month()+''+Obj.closedate.year())) :new Applied_to_Forecast__c(Status__c='4 - Lost',Opportunity__c=Obj.id,Rep_Forecast__c=RepForecastMap.get(Obj.OwnerId).get(Obj.closedate.Month()+''+Obj.closedate.year())) );      
            }else{
                insertAF.add(oppId_afId_Map.get(Obj.id)!=Null? new Applied_to_Forecast__c(id=oppId_afId_Map.get(Obj.id).id,Status__c='3 - Won',Opportunity__c=Obj.id,Rep_Forecast__c=RepForecastMap.get(Obj.OwnerId).get(Obj.closedate.Month()+''+Obj.closedate.year())) :new Applied_to_Forecast__c(Status__c='3 - Won',Opportunity__c=Obj.id,Rep_Forecast__c=RepForecastMap.get(Obj.OwnerId).get(Obj.closedate.Month()+''+Obj.closedate.year())) );       
            }
        }else{
            if(oppId_afId_Map.get(Obj.id)!=null&&(Date.newInstance(trigger.oldMap.get(Obj.id).closedate.year(),trigger.oldMap.get(Obj.id).closedate.month(),trigger.oldMap.get(Obj.id).closedate.day())<Date.newInstance(Obj.closedate.year(),Obj.closedate.month(),Obj.closedate.day()))){
                if(RepForecastMap.get(Obj.OwnerId).get(Obj.closedate.Month()+''+Obj.closedate.year())!=oppId_afId_Map.get(Obj.id).Rep_Forecast__c){
                	insertAF.add(new Applied_to_Forecast__c(id=oppId_afId_Map.get(Obj.id).id,Status__c='2 - Rolled',Opportunity__c=Obj.id));               
                    insertAF.add(new Applied_to_Forecast__c(Status__c='1 - Open',Opportunity__c=Obj.id,Rep_Forecast__c=RepForecastMap.get(Obj.OwnerId).get(Obj.closedate.Month()+''+Obj.closedate.year())));               
                }
            }else if(oppId_afId_Map.get(Obj.id)==null)
                insertAF.add(new Applied_to_Forecast__c(Status__c='1 - Open',Opportunity__c=Obj.id,Rep_Forecast__c=RepForecastMap.get(Obj.OwnerId).get(Obj.closedate.Month()+''+Obj.closedate.year())));
        }
    }
    if(insertAF.size()>0)
        upsert insertAF;
}