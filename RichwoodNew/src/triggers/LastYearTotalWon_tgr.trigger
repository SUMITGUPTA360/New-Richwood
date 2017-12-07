trigger LastYearTotalWon_tgr on Rep_Forecast__c (before insert) {
     set<id> Sales_RepIds = new set<id>();
     Map<id,Map<String,Decimal>> RepForecastMap = new Map<id,Map<String,Decimal>>();//Key->UserId, Value(Key->Month/Year, value=> Last Year (this Month) C/W)
        for(Rep_Forecast__c Obj:trigger.new){
            if(Obj.Sales_Rep__c!=null)
                Sales_RepIds.add(Obj.Sales_Rep__c);
        }
     for(Id Obj:Sales_RepIds)
        RepForecastMap.put(Obj,new Map<String,Decimal>());
     for(Rep_Forecast__c Obj:[SELECT Forecast_Period_Start__c,Id,Name,Last_Year_this_Month_C_W__c,OwnerId,Rep_Comments_about_Period_Forecast__c,Sales_Rep__c,Untracked_WAG__c FROM Rep_Forecast__c where Forecast_Period_Start__c!=null and Sales_Rep__c!=null and Sales_Rep__c in:Sales_RepIds and Last_Year_this_Month_C_W__c!=null ORDER BY CreatedDate DESC  NULLS FIRST])
          RepForecastMap.get(Obj.Sales_Rep__c).put(Obj.Forecast_Period_Start__c.Month()+''+Obj.Forecast_Period_Start__c.year(),Obj.Last_Year_this_Month_C_W__c);
     for(Rep_Forecast__c Obj:trigger.new){
        if(Obj.Sales_Rep__c!=null && Obj.Forecast_Period_Start__c!=null && RepForecastMap.get(Obj.Sales_Rep__c)!=null){
            Date d=Date.newInstance(Obj.Forecast_Period_Start__c.year(),Obj.Forecast_Period_Start__c.Month(),1).addMonths(-12);
            if(RepForecastMap.get(Obj.Sales_Rep__c).get(d.month()+''+d.year())!=null)
                Obj.Last_Year_this_Month_C_W__c=RepForecastMap.get(Obj.Sales_Rep__c).get(d.month()+''+d.year());
        }
     }    
}