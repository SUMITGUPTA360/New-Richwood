public class SF1_Opportunity_ctrl{
    public String account_name{get;set;}
    public String product_name{get;set;}
    public id opp_LineItem_id{get;set;}
    
    public list<Account> account_List{get;set;}
    public list<contact> contact_List{get;set;}
    public list<opportunity> Opportunity_List{get;set;}
    public list<OpportunityLineItem> OpportunityLineItem_list{get;set;}
    public list<Product2> Product2_list{get;set;}
    public Map<string,decimal> priceOfProducts{get;set;}
    public Map<string,id> pricebookId_Of_Products{get;set;}
    
    public account account_Obj{get;set;}
    public contact contact_Obj{get;set;}
    public opportunity opportunity_Obj{get;set;}
    public product2 product2_Obj{get;set;}
    
    public OpportunityLineItem OpportunityLineItem_Obj{get;set;}
    
    public boolean isAccountSelected{get;set;}
    public boolean isAccountCreated{get;set;}
    
    public boolean isContactSelected{get;set;}
    public boolean isContactCreated{get;set;}
    
    
    public boolean isOpportunitySelected{get;set;}
    public boolean isOppCreated{get;set;}
    
    public boolean isProduct_btn_Selected{get;set;}
    public boolean isProduct_Selected{get;set;}
    public boolean isHomePage_Redirect{get;set;}
    
    
    public boolean isAccountDisplayMode{get;set;}
    public boolean isContactDisplayMode{get;set;}
    public boolean isOpportunityDisplayMode{get;set;}
    
    public Map<id,boolean> opp_pro_lineItemID_Mode_Map{get;set;}
    
    public string opp_closeDate{get;set;}
    
    public SF1_Opportunity_ctrl(){
        
        
        account_List=new List<Account>();
        contact_List=new List<contact>();
        Opportunity_List=new List<opportunity>();
        OpportunityLineItem_list=new list<OpportunityLineItem>();
        Product2_list=new List<Product2>();
        OpportunityLineItem_Obj =new OpportunityLineItem();
        
        account_Obj=new Account();
        contact_Obj=new Contact();
        
        
        opp_closeDate=null;
        opportunity_Obj=new Opportunity(stagename='Qualification');
        product2_Obj=null;
        
        isAccountSelected=false;
        isAccountCreated=false;
        
        isContactSelected=false;
        isContactCreated=false;
            
        isOpportunitySelected=false;
        isOppCreated=false;
        
        isProduct_btn_Selected=false;
        isProduct_Selected=false;
        isHomePage_Redirect=true;
        
        
      isAccountDisplayMode=true;
        isContactDisplayMode=true;
        isOpportunityDisplayMode=true;
        
        opp_LineItem_id=null;
        
        priceOfProducts=new Map<string,Decimal>();
    /*    for(Pricebookentry  pbe:[SELECT Id,Name,Product2.Id,Product2.Name,UnitPrice,ProductCode FROM Pricebookentry WHERE PriceBook2.IsStandard=true])
        priceOfProducts.put(pbe.ProductCode ,pbe.UnitPrice); 
     */
        
        pricebookId_Of_Products=new Map<string,id>();
    /*    for(Pricebookentry  pbe:[SELECT Id,Name,Product2.Id,Product2.Name,UnitPrice,ProductCode FROM Pricebookentry WHERE PriceBook2.IsStandard=true])
        pricebookId_Of_Products.put(pbe.ProductCode ,pbe.id); 
      */  
        string source=ApexPages.currentPage().getParameters().get('source');
        opp_pro_lineItemID_Mode_Map=new Map<id,boolean>();
        if(source!=null){
            if(source=='con'){
                
                account_Obj=[select id, name,Phone  from account where id=:ApexPages.currentPage().getParameters().get('accid')];
                isAccountSelected=true;
                 contact_Obj=[select id,firstName,LastName,phone,email from contact where id=:ApexPages.currentPage().getParameters().get('conid')];
                 Opportunity_List=[select id,Name,StageName,closedate,description  from opportunity where accountid=:account_Obj.id];
                
                isContactSelected=true;
            }else if(source=='acc'){
                account_Obj=[select id, name,Phone  from account where id=:ApexPages.currentPage().getParameters().get('accid')];
                isAccountSelected=true;
                 contact_List=[select id,firstName,LastName,phone,email from contact where accountid=:account_Obj.id];
                 Opportunity_List=[select id,Name,StageName,closedate,description from opportunity where accountid=:account_Obj.id];
            }else 
            //New
            
            if(source=='product'){
    			account_Obj=[select id, name,Phone  from account where id=:ApexPages.currentPage().getParameters().get('accid')];
                isAccountSelected=true;
    			contact_Obj=[select id,firstName,LastName,phone,email from contact where id=:ApexPages.currentPage().getParameters().get('conid')];
    			isContactSelected=true;
    			opportunity_Obj=[select id,Name,StageName,closedate,description from opportunity where id=:ApexPages.currentPage().getParameters().get('opp_idx')];
    			Opportunity_List=[select id,Name,StageName,closedate,description  from opportunity where accountid=:account_Obj.id];
    			isOpportunitySelected=true;
        		try{
            		opp_closeDate=stringDateFormat(opportunity_Obj.closeDate);
            		OpportunityLineItem_list=[SELECT Product2.Name,ServiceDate,
                                              Description,Id,IsDeleted,ListPrice,OpportunityId,ProductCode,Quantity 
                                              FROM OpportunityLineItem 
                                              WHERE OpportunityId =:ApexPages.currentPage().getParameters().get('opp_idx') 
                                              and IsDeleted=false order by createddate limit 999];
                    System.debug(OpportunityLineItem_list.size());
                    opp_pro_lineItemID_Mode_Map=new Map<id,boolean>();
            		for(OpportunityLineItem Obj:OpportunityLineItem_list)
            		opp_pro_lineItemID_Mode_Map.put(Obj.id,true);
                    System.debug(opp_pro_lineItemID_Mode_Map.get('00km0000005OR7BAAW'));
        		}catch(Exception e){
            		opportunity_Obj=null;
                    System.debug(e.getMessage());
                    System.debug(e.getStackTraceString());
        		}
    //end of temp Code            
                
}//End of new
            System.debug(source=='product');
        }else{
            
            System.debug(source);
        }
        
        
    }
    //New 
    
    
    
    public string stringDateFormat(date temp){
        String month=''+temp.month();
        if(temp.month()<=9){
            month='0'+temp.month();
        }
        String day=''+temp.day();
        if(temp.day()<=9){
            day='0'+temp.day();
        }
        return temp.year()+'-'+month+'-'+day;
    }
    public date dateformat_String(string tempDate){
        string tempYear=tempDate.substring(0,4);
        string tempMonth=tempDate.substring(5,7);
        string tempDay=tempDate.substring(8,10);
        return Date.parse(tempMonth+'/'+tempDay+'/'+tempYear);        
    }
    //End of new
    
    
   
    public PageReference  forAccountSearch(){
        account_name = Apexpages.currentPage().getParameters().get('account_name');
        String temp='SELECT Name,Phone FROM Account WHERE  Name LIKE \'%'+String.escapeSingleQuotes(account_name)+'%\' limit 999';
        if(account_name.length()!=0){
            account_List = Database.query(temp);
        }
        else{
            account_List=new List<Account>();
        }   
        return null;
    }
    public PageReference accountCreate(){
        isAccountSelected=true;
        isAccountCreated=true;
        account_List=new List<Account>();
        return null;
    }
    public PageReference saveAccount(){
        isAccountSelected=true;
        isAccountCreated=false;
        isAccountDisplayMode=true;
        upsert account_Obj;
        return null;
    }
    public pagereference cancelAccount_Mode(){
        isAccountDisplayMode=true;
        return null;
    }
        
    public pagereference EditAccount(){
        isAccountDisplayMode=false;
        return null;
    }
    public PageReference cancelAccount(){
        
        isAccountSelected=false;
        isAccountCreated=false;
        return null;
    }
    public PageReference contactCreate(){
        isContactSelected=true;
        isContactCreated=true;
        return null;
    }
    
    public PageReference saveContact(){
        contact_Obj.AccountId=account_Obj.id;
        upsert contact_Obj;
        isContactDisplayMode=true;
        isContactSelected=true;
        isContactCreated=false;
        return null;
    }
    public pagereference EditContact(){
        isContactDisplayMode=false;
        return null;
    }
    public PageReference  cancelContact_Mode(){
        isContactDisplayMode=true;
        return null;
    }
    public PageReference cancelContact(){
        isContactSelected=false;
        isContactCreated=false;
        return null;
    }
    public pagereference EditOpp(){
        isOpportunityDisplayMode=false;
        return null;
    }
    public PageReference  cancelOPP_Mode(){
        isOpportunityDisplayMode=true;
        return null;
    }
    
    public PageReference oppCreate(){
        isOppCreated=true;
        isOpportunitySelected=true;
        
        return null;
    }
    public PageReference saveopp(){
        
        opportunity_Obj.accountid=account_Obj.id;
        if(isOpportunityDisplayMode==false){
            System.debug('hai');
            try{
                System.debug(ApexPages.currentPage().getParameters().get('oppCloseDateOne'));
              opportunity_Obj.CloseDate=dateformat_String(ApexPages.currentPage().getParameters().get('oppCloseDateOne'));       
            }catch(Exception e){
                System.debug(e.getCause());
                System.debug(e.getLineNumber());
                System.debug(e.getMessage());
                System.debug(e.getStackTraceString());
                System.debug(e.getTypeName());
            }
            
        }
        if(isOppCreated==true&& isOpportunitySelected==true){
            try{
                opportunity_Obj.CloseDate=dateformat_String(ApexPages.currentPage().getParameters().get('oppCloseDateOne'));
            }catch(Exception e){
                System.debug('---');
            }
            
        }
        
        try{
            opp_closeDate=stringDateFormat(opportunity_Obj.CloseDate);
        }catch(Exception e){
            System.debug('----');
        }
        
        
        isOpportunityDisplayMode=true;
        isOppCreated=false;
        isOpportunitySelected=true;
        
        upsert opportunity_Obj;
        //New
        
            List<OpportunityContactRole> ocr_list=[SELECT ContactId,Id,IsPrimary,OpportunityId,Role FROM OpportunityContactRole where OpportunityId=:opportunity_Obj.id];
            if(ocr_list.size()==0){
             insert new OpportunityContactRole(ContactId=contact_Obj.id,IsPrimary=true,OpportunityId=opportunity_Obj.id,Role='Business User');   
            }else{
                set<id> contactIds_set= new set<id>();
                Map<id,OpportunityContactRole> contactId_ocr_map=new Map<id,OpportunityContactRole>();
                for(OpportunityContactRole Obj:ocr_list){
                    contactIds_set.add(Obj.contactid);
                    contactId_ocr_map.put(Obj.contactid,obj);
                } 
                if(contactIds_set.contains(contact_Obj.id)){
                    if(contactId_ocr_map.get(contact_Obj.id).Role!=null)
                    update new OpportunityContactRole(id=contactId_ocr_map.get(contact_Obj.id).id,ContactId=contact_Obj.id,IsPrimary=true,OpportunityId=opportunity_Obj.id);          
                }else{
                    insert new OpportunityContactRole(ContactId=contact_Obj.id,IsPrimary=true,OpportunityId=opportunity_Obj.id,Role='Business User');           
                }
                
            }
        //End
        
        
        
        
        return null;
    }
    public PageReference cancelopp(){
        isOppCreated=false;
        isOpportunitySelected=false;
        return null;
    }
    
    public PageReference forAccountDetail(){
        integer temp=Integer.valueOf(Apexpages.currentPage().getParameters().get('account_idx'));
        System.debug(temp);
        try{
            account_Obj=account_List.get(temp);  
            isAccountSelected=true;
            
            contact_List=[select id,firstName,LastName,phone,email from contact where accountid=:account_Obj.id];
            Opportunity_List=[select id,Name,StageName,closedate,description from opportunity where accountid=:account_Obj.id];
        }catch(Exception e){
            account_Obj=null;
        }
        return null;
    }
    public pagereference forContactDetail(){
        Id tempId=String.valueOf(Apexpages.currentPage().getParameters().get('contact_idx'));
        
        try{
            
            contact_Obj=[select id,firstname,phone,email,lastname from contact where id=:tempId];
            isContactSelected=true;
        }catch(Exception e){
            contact_Obj=null;
        }
        
        return null;
    }
    public pagereference forOpportuntiyDetail(){
        Id tempId=String.valueOf(Apexpages.currentPage().getParameters().get('opp_idx'));
        try{
            opportunity_Obj=[select id,Name,StageName,closedate,description from opportunity where id=:tempId];
            
            opp_closeDate=stringDateFormat(opportunity_Obj.closeDate);
            isOpportunitySelected=true;
            OpportunityLineItem_list=[SELECT Product2.Name,ServiceDate,Description,Id,IsDeleted,ListPrice,OpportunityId,ProductCode,Quantity FROM OpportunityLineItem WHERE OpportunityId =:tempId and IsDeleted=false order by createddate limit 999];
            for(OpportunityLineItem Obj:OpportunityLineItem_list)
            opp_pro_lineItemID_Mode_Map.put(Obj.id,true);
            //new 
            List<OpportunityContactRole> ocr_list=[SELECT ContactId,Id,IsPrimary,OpportunityId,Role FROM OpportunityContactRole where OpportunityId=:opportunity_Obj.id limit 999];
            if(ocr_list.size()==0){
             insert new OpportunityContactRole(ContactId=contact_Obj.id,IsPrimary=true,OpportunityId=opportunity_Obj.id,Role='Business User');   
            }else{
                set<id> contactIds_set= new set<id>();
                Map<id,OpportunityContactRole> contactId_ocr_map=new Map<id,OpportunityContactRole>();
                for(OpportunityContactRole Obj:ocr_list){
                    contactIds_set.add(Obj.contactid);
                    contactId_ocr_map.put(Obj.contactid,obj);
                } 
                if(contactIds_set.contains(contact_Obj.id)){
                    if(contactId_ocr_map.get(contact_Obj.id).Role!=null)
                    update new OpportunityContactRole(id=contactId_ocr_map.get(contact_Obj.id).id,ContactId=contact_Obj.id,IsPrimary=true,OpportunityId=opportunity_Obj.id);          
                }else{
                    insert new OpportunityContactRole(ContactId=contact_Obj.id,IsPrimary=true,OpportunityId=opportunity_Obj.id,Role='Business User');           
                }
                
            }
            //End
        }catch(Exception e){
            opportunity_Obj=null;
        }
        return null;
    }
    public pagereference EditOppLineItem(){
        
            opp_pro_lineItemID_Mode_Map.put(opp_LineItem_id,false);
        return null;
    }
    public pagereference DelOppLineItem(){
        for(integer i=0;i<OpportunityLineItem_list.size();i++){
            if(opp_LineItem_id==OpportunityLineItem_list.get(i).id){
                OpportunityLineItem temp=OpportunityLineItem_list.get(i);
                OpportunityLineItem_list.remove(i);
                delete temp;
                break;
            }
        }
        return null;
    }
    public pagereference saveOppLineItem(){
        opp_pro_lineItemID_Mode_Map.put(opp_LineItem_id,true);
        for(OpportunityLineItem Obj:OpportunityLineItem_list){
            if(Obj.id==opp_LineItem_id)
                upsert Obj;
        }
        return null;
    }
    public pagereference cancelOppLineItem(){
        opp_pro_lineItemID_Mode_Map.put(opp_LineItem_id,true);
        return null;
    }
    
    public pagereference forProductSearch(){
        
            string proName=Apexpages.currentPage().getParameters().get('pro_idx');
            System.debug(proName.length());
        //Like name, code, and the description--,,
        String temp='SELECT CreatedById,CreatedDate,Description,Family,Id,IsActive,IsDeleted,LastModifiedById,LastModifiedDate,LastReferencedDate,LastViewedDate,Name,ProductCode,SystemModstamp FROM Product2 WHERE IsActive = true  And (Name LIKE \'%'+String.escapeSingleQuotes(proName)+'%\'Or ProductCode LIKE \'%'+String.escapeSingleQuotes(proName)+'%\'Or Description LIKE \'%'+String.escapeSingleQuotes(proName)+'%\') limit 999';
        if(proName.length()==0){
            temp='SELECT CreatedById,CreatedDate,Description,Family,Id,IsActive,IsDeleted,LastModifiedById,LastModifiedDate,LastReferencedDate,LastViewedDate,Name,ProductCode,SystemModstamp FROM Product2 WHERE IsActive = true  And id=null';
        }
            Product2_list=database.query(temp);    
        System.debug(Product2_list.size());
        // New
                    set<id> productIds=new set<id>();
                    priceOfProducts=new Map<string,Decimal>();
                     pricebookId_Of_Products=new Map<string,id>();

            
            for(product2 obj:product2_list){
                productIds.add(obj.id);   
            }
            for(Pricebookentry  pbe:[SELECT Id,Name,Product2.Id,Product2.Name,Product2Id,UnitPrice,ProductCode FROM Pricebookentry WHERE    isactive=true and Product2Id in: productIds  ORDER BY LastModifiedDate]){
                priceOfProducts.put(pbe.Product2Id ,pbe.UnitPrice); 
                pricebookId_Of_Products.put(pbe.Product2Id,pbe.id); 
            }
         // End of New    
        return null;        
    }
    
    public PageReference forProduct2Detail(){
        integer temp=Integer.valueOf(Apexpages.currentPage().getParameters().get('product2_idx'));
        try{
            product2_Obj=Product2_list.get(temp);
            isProduct_Selected=true;
            OpportunityLineItem_Obj.OpportunityId=opportunity_Obj.id;
            OpportunityLineItem_Obj.PricebookEntryId=pricebookId_Of_Products.get(product2_Obj.id);
            OpportunityLineItem_Obj.UnitPrice=priceOfProducts.get(product2_Obj.id);
            
        }catch(Exception e){
            product2_Obj=null;
        }
        //New
  		PageReference editList;
        if(ApexPages.currentPage().getParameters().get('orgin')=='desktop')
    		editList = Page.productEditPage;
        else if(ApexPages.currentPage().getParameters().get('orgin')=='mobile')
            editList = Page.ProductEditPage_mobile;
    		editList.getParameters().put('product_name', ''+product2_Obj.Name+'');
    		editList.getParameters().put('UnitPrice', ''+priceOfProducts.get(product2_Obj.id)+'');
    		editList.getParameters().put('OpportunityId', ''+opportunity_Obj.id+'');
    		editList.getParameters().put('PricebookEntryId', ''+pricebookId_Of_Products.get(product2_Obj.id)+'');
    		editList.getParameters().put('orgin', Apexpages.currentPage().getParameters().get('orgin')); 
        
            editList.getParameters().put('accid',''+account_Obj.id+''); 
        	editList.getParameters().put('conid',''+contact_Obj.id+''); 
        	editList.getParameters().put('opp_idx',''+opportunity_Obj.id+''); 
    		editList.setRedirect(true);
    		return editList;
        //End of New
    }
    public pagereference saveOpportunityLineItem(){
        try{
            insert OpportunityLineItem_Obj;
            isProduct_btn_Selected=false;
            isProduct_Selected=false;
            OpportunityLineItem_list=[SELECT Product2.Name,ServiceDate,Description,Id,IsDeleted,ListPrice,OpportunityId,ProductCode,Quantity FROM OpportunityLineItem WHERE OpportunityId =:opportunity_Obj.id and IsDeleted=false order by createddate limit 999];
            opp_pro_lineItemID_Mode_Map=new Map<id,boolean>();
            for(OpportunityLineItem Obj:OpportunityLineItem_list){
            
                opp_pro_lineItemID_Mode_Map.put(Obj.id,true);
            }
            string temp='SELECT CreatedById,CreatedDate,Description,Family,Id,IsActive,IsDeleted,LastModifiedById,LastModifiedDate,LastReferencedDate,LastViewedDate,Name,ProductCode,SystemModstamp FROM Product2 WHERE IsActive = true  And id=null';
            Product2_list=database.query(temp); 
        }catch(Exception e){    
        }
        return null;
    }
    public pagereference cancelOpportunityLineItem(){
        isProduct_btn_Selected=false;
        isProduct_Selected=false;
       string temp='SELECT CreatedById,CreatedDate,Description,Family,Id,IsActive,IsDeleted,LastModifiedById,LastModifiedDate,LastReferencedDate,LastViewedDate,Name,ProductCode,SystemModstamp FROM Product2 WHERE IsActive = true  And id=null';
            Product2_list=database.query(temp);    
        return null;
    }
    public pagereference showProductDetails(){
        isProduct_btn_Selected=true;
        return null;
    }
}