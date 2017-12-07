public  without sharing class AccountForecastbyCustomerController{
    public Integer year {get;set;}
    public Date stDate{get;set;}
    public Date endDate{get;set;}
    public Id   currentAccountId{get;set;}
    
    public Account_Yearly_Forecast__c ayf_Obj {get;set;}
    public AccountYearlyForecast ayf_wrapper_Obj{get;set;}
    
    public Map<String, List<ProductCategoryWrapper> > ProductType_ProductCategoryList_Map{get;set;}
    public List<String> productType_List{get;set;}
  public Map<String,String> productType_Map {get;set;}
    
    public Map<String,Decimal> ProductType_TotalUnits{get;set;}
    public Map<String,Decimal> ProductType_TotalAmount{get;set;}
    
    public Map<String,Decimal> ProductType_budget_TotalUnits{get;set;}
  public Map<String,Decimal> ProductType_budget_TotalSales{get;set;}

    public Decimal totalUnits{get;set;}
  public Decimal totalAmount{get;set;}
  public Decimal budget_TotalUnits{get;set;}
  public Decimal budget_TotalSales{get;set;}

    
    public List<CapitalProjectWrapper> capitalProject_List{get;set;}
    
    public List<Account> account_list {get;set;}
    public Integer AccountLocationNumber {get;set;}
    public boolean isPrevious{get;set;}
    public boolean isNext{get;set;}
    
    
    public integer projectIdx{get;set;}
    public String projectType{get;set;}
    
    public integer capitalprojectidx{get;set;}
    
    public integer capitalprojectForidx{get;set;}
    
    public boolean isFieldsDisable{get;set;}
    
    public AccountForecastbyCustomerController(){
        Year= Integer.valueOf(apexpages.currentpage().getparameters().get('year'));
        stDate = Date.newInstance(year,1,1);
        endDate = Date.newInstance(year + 1,1,1);
        productType_List = new List<String>();
        productType_Map = new Map<String,String>();

        //managerName='';
        projectIdx=0;
        projectType='';
        isFieldsDisable=true;
        
        
        for (Schema.PicklistEntry Obj:Product_Category__c.Type__c.getDescribe().getPicklistValues()){
            productType_List.add(obj.getValue());
            if(obj.getValue().containsIgnoreCase('-')){
              productType_Map.put(obj.getValue(),obj.getValue().substring(obj.getValue().indexOf('-')+1));
             }else{
                  productType_Map.put(obj.getValue(),obj.getValue());
             }
        }
        productType_List.sort();
        productType_List.add('None');
        productType_Map.put('None','None');
        
        account_list = new List<Account>();
        Id tempOwnerId =[select Id,OwnerId from Account where id=:apexpages.currentpage().getparameters().get('Id') limit 1].ownerid;
        account_list = [Select Id,name,OwnerId,owner.name from account Where ownerId =:tempOwnerId and Include_in_Forecast__c = true];
        AccountLocationNumber = 0;
        for(account obj: account_list){
               if(obj.id==apexpages.currentpage().getparameters().get('Id'))
                break;
            AccountLocationNumber++;
        }
        isNext=((account_list.size()-1)==AccountLocationNumber)?false:true;
        isPrevious=(AccountLocationNumber==0)?false:true;
        
        Map < id, User> UserId_User_Map = new Map<id, User>();
        for (user u: [select id, name, Manager.name from user where isactive = true  order by Manager.name]) {
            UserId_User_Map.put(u.id,u);
        }  
        currentAccountId=apexpages.currentpage().getparameters().get('Id');
    }
    public void InitializingData(){//this method for avoid view state issues
        // Binding Product Categorys with Product Type                     
        ProductType_ProductCategoryList_Map = new Map < String, List < ProductCategoryWrapper > > ();
    
        ProductType_TotalUnits = new Map<String,Decimal>();
        ProductType_TotalAmount = new Map<String,Decimal>();
      
        ProductType_budget_TotalUnits = new Map<String,Decimal>();
    ProductType_budget_TotalSales = new Map<String,Decimal>();

        
        
        ProductType_TotalUnits.put(null,0);
        ProductType_TotalAmount.put(null,0);    
      
      ProductType_budget_TotalUnits.put(null,0);
    ProductType_budget_TotalSales.put(null,0);

        
        for (String Obj:productType_List){
            ProductType_ProductCategoryList_Map.put(Obj,new List<ProductCategoryWrapper>());
            ProductType_TotalUnits.put(Obj,0);
            ProductType_TotalAmount.put(Obj,0);
            ProductType_budget_TotalUnits.put(Obj,0);
      ProductType_budget_TotalSales.put(Obj,0);
        }
        //Map For sum Of Opportunity(Amount) for Account where Stage is Close/Won
        Map<Id,Decimal> oppAmountCloseWonMap = new Map<Id,Decimal>();
         for(AggregateResult ar : [SELECT product2.Product_Category__c pId,SUM(TotalPrice) sum from opportunityLineItem where Opportunity.IsClosed = true and Opportunity.IsWon = True and Opportunity.CloseDate >=: stDate and Opportunity.CloseDate<:endDate GROUP BY product2.Product_Category__c]){
                        oppAmountCloseWonMap.put((Id) ar.get('pId'),(Decimal) ar.get('sum')); 
        }
        
        //Map For sum Of Opportunity(Amount) for Account where Stage is Open
        Map<Id,Decimal> oppAmountOpenMap = new Map<Id,Decimal>();
         for(AggregateResult ar : [SELECT product2.Product_Category__c pId,SUM(TotalPrice) sum from opportunityLineItem where Opportunity.IsClosed = false and Opportunity.CloseDate >=: stDate and Opportunity.CloseDate <:endDate GROUP BY product2.Product_Category__c]){
            oppAmountOpenMap.put((Id) ar.get('pId'),(Decimal) ar.get('sum')); 
        }
        
        //ORDER BY CreatedDate DESC NULLS FIRST->to assign/use recent one
        Account acc=[select id,Name,
                               (select id,
                                       Name,
                                       Account__c,
                                       Forecast_Period_Start__c,Forecast_Status__c  
                                 from Account_Yearly_Forecasts__r
                                 where Forecast_Period_Start__c!=null and Forecast_Period_Start__c >=: stDate 
                                       and Forecast_Period_Start__c <: endDate 
                                       ORDER BY CreatedDate DESC NULLS FIRST
                                 ) from Account where id=:currentaccountId limit 1];
        
        // Initialising Account_Yearly_Forecasts__c Object
        if(acc.Account_Yearly_Forecasts__r.size()==0){
            insert new Account_Yearly_Forecast__c(Name=acc.Name+' - '+year, Forecast_Status__c='Preparation',Account__c=acc.id,Forecast_Period_Start__c=Date.newInstance(year,1,1 ));    //System.today().month(), System.today().day()
            acc=[select id,Name,
                               (select id,
                                       Name,
                                       Account__c,
                                       Forecast_Period_Start__c,Forecast_Status__c  
                                 from Account_Yearly_Forecasts__r
                                 where Forecast_Period_Start__c!=null and Forecast_Period_Start__c >=: stDate 
                                       and Forecast_Period_Start__c <: endDate 
                                       ORDER BY CreatedDate DESC NULLS FIRST
                                 ) from Account where id=:currentaccountId limit 1];
        }
        
        
        ProductCategoryWrapper temp_pcw_Obj;
        if(acc.Account_Yearly_Forecasts__r.size()>0){
            ayf_Obj= acc.Account_Yearly_Forecasts__r[0];
            Map<Id,Forecast_Product_Category__c> ProductCategoryId_fpc_Obj_Map = new Map<Id,Forecast_Product_Category__c>();
            //ORDER BY CreatedDate ASC NULLS FIRST
            
            // calculating Units and amount by product type
            for(Forecast_Product_Category__c fpc :[select id, Name,Product_Category__c,Projected_Amount__c,Units__c,Product_Category__r.Type__c,Budgeted_Sales__c, Budgeted_Units__c 
                                                          from Forecast_Product_Category__c 
                                                   where Account_Yearly_Forecast__c=:ayf_Obj.id
                                                   ORDER BY CreatedDate ASC NULLS FIRST
                                                   ]){
            try{                                                       
                ProductCategoryId_fpc_Obj_Map.put(fpc.Product_Category__c,fpc);
                if(fpc.Units__c!=null){
                    System.debug(ProductType_TotalUnits.get(fpc.Product_Category__r.Type__c));//
                    System.debug(fpc.Units__c);//
                    System.debug(productType_List);//
                    if(fpc.Product_Category__r.Type__c==null){
                        Decimal temp = ProductType_TotalUnits.get('None')+fpc.Units__c;
                        ProductType_TotalUnits.put('None',temp);
                    }else{
                        Decimal temp = ProductType_TotalUnits.get(fpc.Product_Category__r.Type__c)+fpc.Units__c;
                        ProductType_TotalUnits.put(fpc.Product_Category__r.Type__c,temp);    
                    }
                    System.debug(ProductType_TotalUnits.get(fpc.Product_Category__r.Type__c));//
                    System.debug(fpc.Units__c);//
                }
                if(fpc.Projected_Amount__c!=null){
                    if(fpc.Product_Category__r.Type__c==null){
                       Decimal temp = ProductType_TotalAmount.get('None')+fpc.Projected_Amount__c;
                       ProductType_TotalAmount.put('None',temp); 
                    }else{
                       Decimal temp = ProductType_TotalAmount.get(fpc.Product_Category__r.Type__c)+fpc.Projected_Amount__c;
                       ProductType_TotalAmount.put(fpc.Product_Category__r.Type__c,temp);   
                    }
                }
                if(fpc.Budgeted_Units__c!=null){
                    if(fpc.Product_Category__r.Type__c==null){
                        Decimal temp = ProductType_budget_TotalUnits.get('None')+fpc.Budgeted_Units__c;
                        ProductType_budget_TotalUnits.put('None',temp);
                    }else{
                        Decimal temp = ProductType_budget_TotalUnits.get(fpc.Product_Category__r.Type__c)+fpc.Budgeted_Units__c;
                        ProductType_budget_TotalUnits.put(fpc.Product_Category__r.Type__c,temp);    
                    }
                }
                if(fpc.Budgeted_Sales__c!=null){
                    if(fpc.Product_Category__r.Type__c==null){
                        Decimal temp = ProductType_budget_TotalSales.get('None')+fpc.Budgeted_Sales__c;
                        ProductType_budget_TotalSales.put('None',temp);
                    }else{
                        Decimal temp = ProductType_budget_TotalSales.get(fpc.Product_Category__r.Type__c)+fpc.Budgeted_Sales__c;
                        ProductType_budget_TotalSales.put(fpc.Product_Category__r.Type__c,temp);    
                    }
                }
            }catch(Exception e){
                System.debug(e.getLineNumber());
                System.debug(e.getCause());
                System.debug(e.getMessage());
                System.debug(e.getStackTraceString());
                System.debug(e.getTypeName());
            }                         
            }
            //--calculating Units and amount by product type
            
            List<Forecast_Product_Category__c> insertFPC_List = new List<Forecast_Product_Category__c>();
    
            for(Product_Category__c Obj:[select id,Name,Type__c,Description__c from Product_Category__c ORDER BY Sort__c ASC NULLS LAST]){
                temp_pcw_Obj= new ProductCategoryWrapper();
                if(ProductCategoryId_fpc_Obj_Map.get(Obj.id)!=null){
                    temp_pcw_Obj.fpc_Obj = ProductCategoryId_fpc_Obj_Map.get(Obj.id);
                    //temp_pcw_Obj.pc_Obj = Obj;  
                    
                    temp_pcw_Obj.fpc_wrapper_Obj.projectedAmount=ProductCategoryId_fpc_Obj_Map.get(Obj.id).Projected_Amount__c!=null?ProductCategoryId_fpc_Obj_Map.get(Obj.id).Projected_Amount__c+'':'';
                    temp_pcw_Obj.fpc_wrapper_Obj.Units=ProductCategoryId_fpc_Obj_Map.get(Obj.id).Units__c!=null?ProductCategoryId_fpc_Obj_Map.get(Obj.id).Units__c+'':'';
                    temp_pcw_Obj.ProductCategoryName=Obj.name;
                 
                    
                    temp_pcw_Obj.fpc_wrapper_Obj.budget_Units = ProductCategoryId_fpc_Obj_Map.get(Obj.id).Budgeted_Units__c!=null?ProductCategoryId_fpc_Obj_Map.get(Obj.id).Budgeted_Units__c+'':'';
                    temp_pcw_Obj.fpc_wrapper_Obj.budget_sales = ProductCategoryId_fpc_Obj_Map.get(Obj.id).Budgeted_Sales__c!=null?ProductCategoryId_fpc_Obj_Map.get(Obj.id).Budgeted_Sales__c+'':'';
                    
                    if(oppAmountCloseWonMap.ContainsKey(obj.id)){
                        temp_pcw_Obj.cwSum = oppAmountCloseWonMap.get(Obj.id);
                    }
                    if(oppAmountOpenMap.ContainsKey(Obj.id)){
                        temp_pcw_Obj.OpenSum  = oppAmountOpenMap.get(Obj.id);
                    }
                    if(Obj.Type__c==null){
                        ProductType_ProductCategoryList_Map.get('None').add(temp_pcw_Obj);  
                    }else{
                        ProductType_ProductCategoryList_Map.get(Obj.Type__c).add(temp_pcw_Obj);    
                    }
                }else{
                    insertFPC_List.add(new Forecast_Product_Category__c(Account_Yearly_Forecast__c=ayf_Obj.id,Product_Category__c=Obj.id));
                }
            }
    
            if(insertFPC_List.size()>0){
                insert insertFPC_List;
                ProductCategoryId_fpc_Obj_Map = new Map<Id,Forecast_Product_Category__c>();
                    for(Forecast_Product_Category__c fpc :[select id, Name,Product_Category__c,Projected_Amount__c,Units__c 
                                                              from Forecast_Product_Category__c 
                                                       where Account_Yearly_Forecast__c=:ayf_Obj.id
                                                       ORDER BY CreatedDate ASC NULLS FIRST
                                                       ]){
                    ProductCategoryId_fpc_Obj_Map.put(fpc.Product_Category__c,fpc);
                }
    
                ProductType_ProductCategoryList_Map = new Map < String, List < ProductCategoryWrapper > > ();
                for (String Obj:productType_List){
                    ProductType_ProductCategoryList_Map.put(Obj,new List<ProductCategoryWrapper>());
                }
    
                for(Product_Category__c Obj:[select id,Name,Type__c,Description__c from Product_Category__c ORDER BY Sort__c ASC NULLS LAST]){
                    temp_pcw_Obj= new ProductCategoryWrapper();
                    temp_pcw_Obj.fpc_Obj = ProductCategoryId_fpc_Obj_Map.get(Obj.id);
                    //temp_pcw_Obj.pc_Obj = Obj;  
                    
                    temp_pcw_Obj.fpc_wrapper_Obj.Units=ProductCategoryId_fpc_Obj_Map.get(Obj.id).Units__c!=null?ProductCategoryId_fpc_Obj_Map.get(Obj.id).Units__c+'':'';
                    temp_pcw_Obj.fpc_wrapper_Obj.projectedAmount=ProductCategoryId_fpc_Obj_Map.get(Obj.id).Projected_Amount__c!=null?ProductCategoryId_fpc_Obj_Map.get(Obj.id).Projected_Amount__c+'':'';
                    
                    temp_pcw_Obj.ProductCategoryName=Obj.name;
                    
                    
                    if(oppAmountCloseWonMap.ContainsKey(obj.id)){
                        temp_pcw_Obj.cwSum = oppAmountCloseWonMap.get(Obj.id);
                    }
                    if(oppAmountOpenMap.ContainsKey(Obj.id)){
                        temp_pcw_Obj.OpenSum  = oppAmountOpenMap.get(Obj.id);
                    }
                    if(Obj.Type__c==null){
                        ProductType_ProductCategoryList_Map.get('None').add(temp_pcw_Obj);  
                    }else{
                        ProductType_ProductCategoryList_Map.get(Obj.Type__c).add(temp_pcw_Obj);    
                    }
                }
            }
        }
        //------------Grand Totals Calculations-----------------//
        totalUnits=0.0;
        totalAmount=0.0;
        budget_TotalUnits=0.0;
        budget_TotalSales=0.0;
        
        for(String st:productType_List){
      totalUnits+=ProductType_TotalUnits.get(st);
      totalAmount+=ProductType_TotalAmount.get(st);
      budget_TotalUnits+=ProductType_budget_TotalUnits.get(st);
      budget_TotalSales+=ProductType_budget_TotalSales.get(st);
    }

        
        //---Edit or read mode----//
        if((ayf_Obj.Forecast_Status__c== 'Preparation')||(ayf_Obj.Forecast_Status__c== 'Adjustment Requested')){
         isFieldsDisable=true;
        }else if(((ayf_Obj.Forecast_Status__c!= 'Preparation')||(ayf_Obj.Forecast_Status__c!= 'Adjustment Requested'))){
             if(account_list[AccountLocationNumber].OwnerId!=userinfo.getuserid() || ([Select Id,Name from Profile where Id=:userinfo.getProfileId()].Name=='System Administrator'))         
                isFieldsDisable=true;//!=
             else
                isFieldsDisable=false;
        }
        // Project Object List Initialisation
        capitalProject_List = new List<CapitalProjectWrapper>();
        for(Capital_Project__c cp:[select id,Account__c,Account__r.id,Project_Description__c,Name,Status__c,
                                                  (select id,Account_Yearly_Forecast__c,Description__c,Amount_this_year__c  
                                                           from Capital_Project_Forecasts__r 
                                                   where Account_Yearly_Forecast__c=:ayf_Obj.id) 
                                       from Capital_Project__c where Account__c =:acc.id and Status__c!='Complete']){
                CapitalProjectWrapper temp_cp_Obj= new CapitalProjectWrapper();
                temp_cp_Obj.cptlProForecast =cp.Capital_Project_Forecasts__r.size()>0?cp.Capital_Project_Forecasts__r[0]:(new Capital_Project_Forecast__c());     
                if(temp_cp_Obj.cptlProForecast.id!=null){
                    temp_cp_Obj.cpf_wrapper_Obj.cpf_Id = temp_cp_Obj.cptlProForecast.id;             
                  temp_cp_Obj.cpf_wrapper_Obj.amountThisYear = temp_cp_Obj.cptlProForecast.Amount_this_year__c;             
                    temp_cp_Obj.cpf_wrapper_Obj.Description = temp_cp_Obj.cptlProForecast.Description__c;
                    
                }
                
                
                temp_cp_Obj.capitalProject = cp;  temp_cp_Obj.cp_wrapper_Obj.cp_Id = cp.id; temp_cp_Obj.cp_wrapper_Obj.Name = cp.Name;temp_cp_Obj.cp_wrapper_Obj.projectDescription = cp.Project_Description__c;temp_cp_Obj.cp_wrapper_Obj.Status_value = cp.Status__c;                                           
                                           
                                           
                capitalProject_List.add(temp_cp_Obj);
        }
        
        //-------------------------Making of Wrapper class Objects---------------------------------------//
        ayf_wrapper_Obj = new AccountYearlyForecast();
        ayf_wrapper_Obj.ayf_Id=ayf_Obj.id; 
        ayf_wrapper_Obj.forecastStatus_value = ayf_Obj.Forecast_Status__c;
    }
    public pagereference previous(){
        if(AccountLocationNumber!=0)
            AccountLocationNumber--;
        if(AccountLocationNumber==0)
            isPrevious=false;
        if((account_list.size()-1)!=AccountLocationNumber)
        isNext=true;    
        currentAccountId=account_list[AccountLocationNumber].id;
        InitializingData();
        return null;
    }
    public pagereference next(){
        if( (account_list.size()-1) != AccountLocationNumber )
        AccountLocationNumber++;
        if( (account_list.size()-1) == AccountLocationNumber )
        isNext=false;
        if(AccountLocationNumber!=0)
            isPrevious=true;
        currentAccountId=account_list[AccountLocationNumber].id;
        InitializingData();
        return null;
    }
    public void updateForecast(){
            try{ 
                System.debug(projectIdx);
                System.debug(projectType);
                Decimal temp1=0;
                try{temp1=Decimal.valueof( ProductType_ProductCategoryList_Map.get(projectType)[projectIdx].fpc_wrapper_Obj.Units+''!=null && ProductType_ProductCategoryList_Map.get(projectType)[projectIdx].fpc_wrapper_Obj.Units.length()!=0? ((ProductType_ProductCategoryList_Map.get(projectType)[projectIdx].fpc_wrapper_Obj.Units)+'').replace(',','').replace('$',''):'0');}catch(Exception e){temp1=0;}
                ProductType_ProductCategoryList_Map.get(projectType)[projectIdx].fpc_Obj.Units__c=temp1;


                try{temp1=Decimal.valueof( ProductType_ProductCategoryList_Map.get(projectType)[projectIdx].fpc_wrapper_Obj.projectedAmount+''!=null&& ProductType_ProductCategoryList_Map.get(projectType)[projectIdx].fpc_wrapper_Obj.projectedAmount.length()!=0? ((ProductType_ProductCategoryList_Map.get(projectType)[projectIdx].fpc_wrapper_Obj.projectedAmount)+'').replace(',','').replace('$',''):'0' );}catch(Exception e){temp1=0;}

                ProductType_ProductCategoryList_Map.get(projectType)[projectIdx].fpc_Obj.Projected_Amount__c=temp1;

                try{temp1=Decimal.valueof( ProductType_ProductCategoryList_Map.get(projectType)[projectIdx].fpc_wrapper_Obj.budget_Units+''!=null&& ProductType_ProductCategoryList_Map.get(projectType)[projectIdx].fpc_wrapper_Obj.budget_Units.length()!=0? ((ProductType_ProductCategoryList_Map.get(projectType)[projectIdx].fpc_wrapper_Obj.budget_Units)+'').replace(',','').replace('$',''):'0' );}catch(Exception e){temp1=0;}
                ProductType_ProductCategoryList_Map.get(projectType)[projectIdx].fpc_Obj.Budgeted_Units__c=temp1;

                try{temp1=Decimal.valueof( ProductType_ProductCategoryList_Map.get(projectType)[projectIdx].fpc_wrapper_Obj.budget_sales+''!=null&& ProductType_ProductCategoryList_Map.get(projectType)[projectIdx].fpc_wrapper_Obj.budget_sales.length()!=0? ((ProductType_ProductCategoryList_Map.get(projectType)[projectIdx].fpc_wrapper_Obj.budget_sales)+'').replace(',','').replace('$',''):'0') ;}catch(Exception e){temp1=0;}
                ProductType_ProductCategoryList_Map.get(projectType)[projectIdx].fpc_Obj.Budgeted_Sales__c=temp1;
        
                
                update ProductType_ProductCategoryList_Map.get(projectType)[projectIdx].fpc_Obj;
                
                //--
                  
                ProductType_TotalUnits = new Map<String,Decimal>();ProductType_TotalAmount = new Map<String,Decimal>();ProductType_budget_TotalUnits = new Map<String,Decimal>();ProductType_budget_TotalSales = new Map<String,Decimal>();

                for (String Obj:productType_List){
                        ProductType_TotalUnits.put(Obj,0);ProductType_TotalAmount.put(Obj,0);ProductType_budget_TotalUnits.put(Obj,0);ProductType_budget_TotalSales.put(Obj,0);

                }
                
        for(Forecast_Product_Category__c fpc :[select id, Name,Product_Category__c,Projected_Amount__c,Units__c,Product_Category__r.Type__c,Budgeted_Sales__c, Budgeted_Units__c from Forecast_Product_Category__c where Account_Yearly_Forecast__c=:ayf_Obj.id ORDER BY CreatedDate ASC NULLS FIRST ]){                
                
                        if(fpc.Units__c!=null){
                            if(fpc.Product_Category__r.Type__c==null){
                                Decimal temp = ProductType_TotalUnits.get('None')+fpc.Units__c;ProductType_TotalUnits.put('None',temp);
                            }else{
                                Decimal temp = ProductType_TotalUnits.get(fpc.Product_Category__r.Type__c)+fpc.Units__c;ProductType_TotalUnits.put(fpc.Product_Category__r.Type__c,temp);    
                            }
                        }
                        if(fpc.Projected_Amount__c!=null){
                            if(fpc.Product_Category__r.Type__c==null){
                               Decimal temp = ProductType_TotalAmount.get('None')+fpc.Projected_Amount__c;ProductType_TotalAmount.put('None',temp); 
                            }else{
                               Decimal temp = ProductType_TotalAmount.get(fpc.Product_Category__r.Type__c)+fpc.Projected_Amount__c;ProductType_TotalAmount.put(fpc.Product_Category__r.Type__c,temp);   
                            }
                        }
                        if(fpc.Budgeted_Units__c!=null){
                            if(fpc.Product_Category__r.Type__c==null){
                                Decimal temp = ProductType_budget_TotalUnits.get('None')+fpc.Budgeted_Units__c;ProductType_budget_TotalUnits.put('None',temp);
                            }else{
                                Decimal temp = ProductType_budget_TotalUnits.get(fpc.Product_Category__r.Type__c)+fpc.Budgeted_Units__c;ProductType_budget_TotalUnits.put(fpc.Product_Category__r.Type__c,temp);    
                            }
                        }
                        if(fpc.Budgeted_Sales__c!=null){
                            if(fpc.Product_Category__r.Type__c==null){
                                Decimal temp = ProductType_budget_TotalSales.get('None')+fpc.Budgeted_Sales__c;ProductType_budget_TotalSales.put('None',temp);
                            }else{
                                Decimal temp = ProductType_budget_TotalSales.get(fpc.Product_Category__r.Type__c)+fpc.Budgeted_Sales__c;ProductType_budget_TotalSales.put(fpc.Product_Category__r.Type__c,temp);    
                            }
                        }
                                       
                    }
                
                
                //------------Grand Totals Calculations-----------------//
                    totalUnits=0.0;totalAmount=0.0;budget_TotalUnits=0.0;budget_TotalSales=0.0;
                    
                    for(String st:productType_List){
                        totalUnits+=ProductType_TotalUnits.get(st);totalAmount+=ProductType_TotalAmount.get(st);budget_TotalUnits+=ProductType_budget_TotalUnits.get(st);budget_TotalSales+=ProductType_budget_TotalSales.get(st);
                    }
                System.debug('--');
            }catch(Exception e){
                System.debug('---'+e);
            }
    }
    public void updateCapitalProject(){
            try{
                
                capitalProject_List[capitalprojectidx].capitalProject.Name=capitalProject_List[capitalprojectidx].cp_wrapper_Obj.Name;
                capitalProject_List[capitalprojectidx].capitalProject.Project_Description__c=capitalProject_List[capitalprojectidx].cp_wrapper_Obj.projectDescription;
                capitalProject_List[capitalprojectidx].capitalProject.Status__c=capitalProject_List[capitalprojectidx].cp_wrapper_Obj.Status_value;
                upsert capitalProject_List[capitalprojectidx].capitalProject;
                capitalProject_List[capitalprojectidx].cp_wrapper_Obj.cp_Id=capitalProject_List[capitalprojectidx].capitalProject.id;
                
                if(capitalProject_List[capitalprojectidx].capitalProject.Status__c=='Complete'){
                    capitalProject_List.remove(capitalprojectidx);
                }
            }catch(Exception e){
                System.debug(e);
            }
    }
    public void SubmitForecast(){
            
        
        if(account_list[AccountLocationNumber].OwnerId!=userinfo.getuserid() || ([Select Id,Name from Profile where Id=:userinfo.getProfileId()].Name=='System Administrator')){
            ayf_Obj.Forecast_Status__c=ayf_wrapper_Obj.forecastStatus_value;
            update ayf_Obj;
        }else{
            ayf_Obj.Forecast_Status__c='Submitted';
            ayf_wrapper_Obj.forecastStatus_value='Submitted';
            update ayf_Obj;
        }
            
           if((ayf_Obj.Forecast_Status__c== 'Preparation')||(ayf_Obj.Forecast_Status__c== 'Adjustment Requested')){
             isFieldsDisable=true;
            }else if(((ayf_Obj.Forecast_Status__c!= 'Preparation')||(ayf_Obj.Forecast_Status__c!= 'Adjustment Requested'))){
                 if(account_list[AccountLocationNumber].OwnerId!=userinfo.getuserid() || ([Select Id,Name from Profile where Id=:userinfo.getProfileId()].Name=='System Administrator'))         
                    isFieldsDisable=true;
                 else
                    isFieldsDisable=false;
            }    
    }
    
    public void createNewCapitalProject(){
            CapitalProjectWrapper temp = new CapitalProjectWrapper();
            temp.capitalProject = new Capital_Project__c(Account__c=account_list[AccountLocationNumber].id);
            temp.cptlProForecast =  new Capital_Project_Forecast__c(Account_Yearly_Forecast__c=ayf_Obj.id);
            capitalProject_List.add(temp);
    }
    public void createNewCapitalForecast(){//THIS METOD FOR UPDATING AND INSERING THE PROJECT FORCAST
     System.debug(capitalprojectidx);   
         if(capitalProject_List[capitalprojectidx].capitalProject.id!=null){
             if(capitalProject_List[capitalprojectidx].cptlProForecast.id==null){
                capitalProject_List[capitalprojectidx].cptlProForecast.Account_Yearly_Forecast__c=ayf_Obj.id;
                capitalProject_List[capitalprojectidx].cptlProForecast.Capital_Project__c=capitalProject_List[capitalprojectidx].capitalProject.id;
                insert capitalProject_List[capitalprojectidx].cptlProForecast;  
                capitalProject_List[capitalprojectidx].cpf_wrapper_Obj.cpf_Id=capitalProject_List[capitalprojectidx].cptlProForecast.id; 
             }else{
                capitalProject_List[capitalprojectidx].cptlProForecast.Description__c=capitalProject_List[capitalprojectidx].cpf_wrapper_Obj.Description;
                capitalProject_List[capitalprojectidx].cptlProForecast.Amount_this_year__c=capitalProject_List[capitalprojectidx].cpf_wrapper_Obj.amountThisYear;   
                update capitalProject_List[capitalprojectidx].cptlProForecast;
             }
         }
    }
    public void save(){
            ayf_Obj.Forecast_Status__c=ayf_wrapper_Obj.forecastStatus_value;
            update ayf_Obj;
            
           if((ayf_Obj.Forecast_Status__c== 'Preparation')||(ayf_Obj.Forecast_Status__c== 'Adjustment Requested')){
             isFieldsDisable=true;
            }else if(((ayf_Obj.Forecast_Status__c!= 'Preparation')||(ayf_Obj.Forecast_Status__c!= 'Adjustment Requested'))){
                 if(account_list[AccountLocationNumber].OwnerId!=userinfo.getuserid() || ([Select Id,Name from Profile where Id=:userinfo.getProfileId()].Name=='System Administrator'))         
                    isFieldsDisable=true;
                 else
                    isFieldsDisable=false;
            }       
        
    }
    
    class ProductCategoryWrapper{
        public Forecast_Product_Category__c fpc_Obj{get;set;}
        public Decimal cwSum {get;set;}
        public Decimal openSum {get;set;}
        public ForecastProductCategory fpc_wrapper_Obj{get;set;}
        public String ProductCategoryName{get;set;}
        
        public ProductCategoryWrapper(){
            fpc_Obj = new Forecast_Product_Category__c();
            openSum = 0;
            cwSum = 0;
            
            fpc_wrapper_Obj = new ForecastProductCategory();
            ProductCategoryName='';
        }
    }
    class CapitalProjectWrapper{
        public Capital_Project_Forecast__c cptlProForecast{get;set;}
        public CapitalProjectForecast cpf_wrapper_Obj{get;set;}        
        
        public Capital_Project__c capitalProject{get;set;}   
        public CapitalProject cp_wrapper_Obj{get;set;}
        
        public CapitalProjectWrapper(){
            cptlProForecast = new Capital_Project_Forecast__c();
            cpf_wrapper_Obj = new CapitalProjectForecast();
            
            capitalProject = new Capital_Project__c();
            cp_wrapper_Obj = new CapitalProject();
        }
    }
    class CapitalProjectForecast{
        public id cpf_Id{get;set;}
        public Decimal amountThisYear{get;set;}
        public String Description {get;set;}
        
        
        public CapitalProjectForecast(){
            cpf_Id = null;
            amountThisYear=0.0;
            Description='';
        }
    }
    class CapitalProject{
        public id cp_Id{get;set;}
        public String Name{get;set;}
        public String projectDescription{get;set;}
        public List<SelectOption> Status {get;set;}
        public String Status_value {get;set;}
        public CapitalProject(){
            cp_Id= null;
            Name='';
            projectDescription='';
            Status_value= null;
            Status = new List<SelectOption>();
            Status.add(new SelectOption('','-None-') );
            Status.add(new SelectOption('Planning','Planning') );
            Status.add(new SelectOption('In Progress','In Progress') );
            Status.add(new SelectOption('Complete','Complete') );
        }
    }
    class AccountYearlyForecast{
        public id ayf_Id{get;set;}
        public  List<SelectOption> forecastStatus{get;set;}
        public  String forecastStatus_value{get;set;}
        public AccountYearlyForecast(){
            ayf_Id=null;
            forecastStatus_value = null;
            forecastStatus = new List<SelectOption>();
            forecastStatus.add(new SelectOption('','-None-') );
            forecastStatus.add(new SelectOption('Preparation','Preparation') );
            forecastStatus.add(new SelectOption('Submitted','Submitted') );
            forecastStatus.add(new SelectOption('Adjustment Requested','Adjustment Requested') );
            forecastStatus.add(new SelectOption('Approved','Approved') );
            forecastStatus.add(new SelectOption('Budgeted','Budgeted') );
        }
   }

    class ForecastProductCategory{
        public string projectedAmount{get;set;}
        public string Units{get;set;}
        
        public string budget_Units{get;set;}
        public string budget_sales{get;set;}
        public ForecastProductCategory(){
            projectedAmount='';
            Units ='';
            
            budget_Units='';
            budget_sales='';
        }
    } 
}