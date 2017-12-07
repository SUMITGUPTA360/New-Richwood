public class QuickServiceRequest_Ctrl {
    
    public boolean isAccountHome {get;set;}
    public boolean isAccountEdit {get;set;}
    public boolean isAccountDisplay {get;set;}
    public account account_Obj{get;set;}
    public List<Account> accountList{get;set;}
    
    public List<contact> contact_List{get;set;}
    public List<SelectOption> contact_so{get;set;}
    
    public String selectedContact{get;set;}
    public contact contact_Obj{get;set;}
    
    public boolean isContactHome{get;set;}
    public boolean isContactDisplay{get;set;}
    public boolean isContactEdit{get;set;}

    public boolean isQrsBttn{get;set;}
    
    public Service_Request__c sr_Obj{get;set;}
    public String Property_Location {get;set;}
    public List<SelectOption> propertyLocation_so{get;set;}
    
    public boolean isQSRHome{get;set;}
    
    public string Conveyor{get;set;}
    public boolean isConveyorHome{get;set;}
    public Customer_Asset__c conveyorObj{get;set;}//CustomerAsset
    public List<SelectOption> Conveyor_so{get;set;}
    
    public boolean isQrsFinal{get;set;}
    
    public Location__c Property_Location_Obj{get;set;}
    public boolean isPropertyHome{get;set;}
    
    
    public List<SelectOption> QSRcontact_so{get;set;}
	public string QSRcontact{get;set;}
	public contact QRScontact_Obj{get;set;}    
    public boolean isQRSContact{get;set;}
    
    public String division{get;set;}
    public List<SelectOption> division_so{get;set;}
    public Division__c DivisionObj{get;set;}
    public boolean isDivisionHome{get;set;}
    
    
    public Contact_Role__c conRole{get;set;}
    
    public QuickServiceRequest_Ctrl(){
        	isDivisionHome=false;
        	QRScontact_Obj=new Contact();
            isQrsFinal=false;
            isAccountHome = true;
            isAccountEdit = false;
            isAccountDisplay = false;   
            accountList=new List<Account>();
        
            contact_List=new List<Contact>();
            contact_so=new List<SelectOption>();
            selectedContact='';
            contact_Obj=new Contact();
            isContactEdit=false;
            isContactHome=false;
            isContactDisplay=false;
        
            isQrsBttn=false;
            sr_Obj=new Service_Request__c();
            Property_Location='';
             propertyLocation_so=new List<SelectOption>();
        
            isQSRHome=false;
            isConveyorHome=false;
        	isPropertyHome=false;
        
        	QSRcontact_so=new List<SelectOption>();
			QSRcontact='';
        	isQRSContact=false;
        
        	division='';
        
        	conRole= new Contact_Role__c();
    }
    public PageReference newAccount(){
        isAccountEdit=true;
        isAccountHome=false;
        isAccountDisplay=false;
        account_Obj=new Account();
        accountList=new List<account>();
        return null;
    }
    public PageReference editAccount(){
        isAccountEdit=true;
        isAccountHome=false;
        isAccountDisplay=false;
        return null;
    }
    public PageReference saveAccount(){
        isAccountEdit=false;
        isAccountHome=false;
        isAccountDisplay=true;
        upsert account_Obj;
        sr_Obj.Account__c=account_Obj.id;
        
        if(isContactHome==false&&contact_Obj.id==null)
            isContactHome=true;
        
        return null;
    }
    public PageReference cancelAccount(){
        if(account_Obj.id==null){
            isAccountEdit=false;
            isAccountHome=true;
            isAccountDisplay=false;    
        }else{
            isAccountEdit=false;
            isAccountHome=false;
            isAccountDisplay=true;    
        }
        return null;
    }
    public PageReference accountSearch(){
        if(Apexpages.currentPage().getParameters().get('firstName').length()!=0)
            accountList = Database.query('SELECT Name,Phone FROM Account WHERE  Name LIKE \'%'+String.escapeSingleQuotes(Apexpages.currentPage().getParameters().get('firstName'))+'%\' limit 20');
        else
            accountList=new List<Account>();
        return null;
    }
    public PageReference selectingAccount(){
        try{
            account_Obj=accountList.get(Integer.valueOf(Apexpages.currentPage().getParameters().get('account_idx')));  
            isAccountEdit=false;
            isAccountHome=false;
            isAccountDisplay=true;            
            sr_Obj.Account__c=account_Obj.id;
            isContactHome=true;
            
            selectedContact='';
            contact_so =new List<SelectOption>();
            contact_so.add(new SelectOption('---',''));
            for(contact Obj:[select id,firstName,LastName,phone,email from contact where accountid=:account_Obj.id])
                contact_so.add(new SelectOption(Obj.id,Obj.FirstName+' '+Obj.LastName));    
        }catch(Exception e){
            account_Obj=new Account();
        }
        return null;
    }
    public PageReference selectingContact(){
        if(selectedContact.length()!=3){
                contact_Obj=[select id,firstName,LastName,phone,email from contact where id=:selectedContact];    
                isContactDisplay=true;
                isContactHome=false;
                isQrsBttn=true;
        }else{
                contact_Obj=new contact(accountid=account_Obj.id);
                isContactDisplay=false;
                isContactHome=true;
                isQrsBttn=false;
        }
        return null;
    }
    public PageReference newContact(){
        isContactEdit=true;
        isContactHome=false;
        contact_Obj=new contact(accountid=account_Obj.id);
        isAccountEdit=false;
        isAccountHome=false;
        isAccountDisplay=false;
        
        return null;
    }
    public PageReference saveContact(){
        upsert contact_Obj;    
        
        isAccountDisplay=true;
        isContactEdit=false;
        if(contact_Obj.id==Null){
            isContactHome=true;        
            isContactDisplay=false;
        }else{
            isContactHome=false;        
            isContactDisplay=true;
            isQrsBttn=true;
        }
        return null;
    }
    public PageReference cancelContact(){
        isAccountDisplay=true;
        isAccountEdit=false;
        isContactEdit=false;
        if(contact_Obj.id==Null){
            isContactHome=true;        
            isContactDisplay=false;
        }else{
            isContactHome=false;        
            isContactDisplay=true;
        }
        return null;
    }
    public PageReference editContact(){
        isContactDisplay=false;
        isContactEdit=true;
        return null;
    }
    public PageReference newQRSBttn(){
        isAccountDisplay=false;
        isAccountEdit=false;
        
        isContactDisplay=false;
        isContactEdit=false;
        
        isQrsBttn=false;
        isQSRHome=true;
        isQrsFinal=false;
        
        isConveyorHome=false;
        
        sr_Obj=new Service_Request__c(Account__c=account_Obj.id);
    	
        Property_Location='';    
        propertyLocation_so=new List<SelectOption>();
        propertyLocation_so.add(new SelectOption('---',''));
       
        for(Location__c Obj:[select id,Name,Account__c from Location__c where Account__c=:account_Obj.id])
        	propertyLocation_so.add(new SelectOption(Obj.id,Obj.Name));
            
            
            conveyorObj=new Customer_Asset__c();
            Conveyor_so=new List<SelectOption>();
        	Conveyor_so.add(new SelectOption('---',''));
        	Conveyor='';
        
        QSRcontact_so=new List<SelectOption>();
        QSRcontact_so.add(new SelectOption('---',''));
        QSRcontact='';
        for(contact Obj:[select id,firstName,LastName,phone,Name,email from contact where accountid=:account_Obj.id]){
            if(Obj.phone!=null)
                QSRcontact_so.add(new SelectOption(Obj.id,Obj.Name+'-'+Obj.Phone));
            else
                QSRcontact_so.add(new SelectOption(Obj.id,Obj.Name));	
        }
        QSRcontact=contact_Obj.id;//----New---
        division_so=new List<SelectOption>();
        division_so.add(new SelectOption('---',''));
        division='';
        return null;
    }
    public PageReference Property_Location(){
        Conveyor_so=new List<SelectOption>();
        Conveyor_so.add(new SelectOption('---',''));
        Conveyor='';
        
        division_so=new List<SelectOption>();
        division_so.add(new SelectOption('---',''));
        division='';
        if(Property_Location.length()!=3){
            for(Division__c Obj:[select id,Location__c,Name from Division__c where Location__c=:Property_Location])
                division_so.add(new SelectOption(Obj.id,Obj.Name));
        }
        return null;
    }
    public PageReference Division_so(){//for updating picklist values in customer assist page
        Conveyor_so=new List<SelectOption>();
        Conveyor_so.add(new SelectOption('---',''));
        Conveyor='';
        if(division.length()!=3){
            for(Customer_Asset__c Obj:[select id,Name,Division__c from Customer_Asset__c where Division__c=:division])
                Conveyor_so.add(new SelectOption(Obj.id,Obj.Name));
        }
        
        return null;
    }
    public pageReference saveQRS(){
        sr_Obj.Status__c='New';
        if(Property_Location instanceof Id)
        	sr_Obj.Location__c=Property_Location;
        if(Conveyor instanceof Id)
        	sr_Obj.Customer_Asset__c=Conveyor;    
        isQrsFinal=true;
        isQSRHome=false;
        
        try{
        	upsert sr_Obj;  
            if(QSRcontact instanceof id){
                conRole.Contact__c=QSRcontact;
            }
            if(division instanceof id){
                conRole.division__c=division;
            }   
            if(Property_Location instanceof id){
                conRole.Location__c=Property_Location;
            }
            if(QSRcontact instanceof id)
            insert conRole;
            
            /*if(conRole.id!=null&&Conveyor instanceof id){
                insert new Associated_Asset__c(Contact_Role__c=conRole.id,Customer_Asset__c=conveyor);
            }*/
			
        }catch(Exception e){
            System.debug(e.getLineNumber());
            System.debug(e.getMessage());
        }    
        return null;
    }
    public PageReference cancelQRS(){
        isAccountDisplay=true;
        isContactDisplay=true;
        isQrsBttn=true;
        isQSRHome=false;
        return null;
    }
    //Location
    public PageReference newProperty(){
        isPropertyHome=true;
        isQSRHome=false;
        Property_Location_Obj=new Location__c();
        Property_Location_Obj.Account__c=sr_Obj.account__c;
        return null;
    }
    public PageReference saveProperty(){
        upsert Property_Location_Obj; 
          
        	Property_Location=Property_Location_Obj.id;
            propertyLocation_so=new List<SelectOption>();
            propertyLocation_so.add(new SelectOption('---',''));
        
            for(Location__c Obj:[select id,Name,Account__c from Location__c where Account__c=:sr_Obj.account__c])
				propertyLocation_so.add(new SelectOption(Obj.id,Obj.Name));
        
        	Conveyor='';
        	Conveyor_so=new List<SelectOption>();
        	Conveyor_so.add(new SelectOption('---',''));
        	
        	division='';
        	division_so=new List<SelectOption>();
        	division_so.add(new SelectOption('---',''));
            
        isQSRHome=true;
        isPropertyHome=false;
        return null;
    }
    public PageReference cancelProperty(){
        isQSRHome=true;
        isPropertyHome=false;
        return null;
    }
    
    public PageReference newConveyor(){
       	conveyorObj.Division__c=division;
        isConveyorHome=true;
        isQSRHome=false;
        return null;
    }
    public PageReference saveConveyor(){
        upsert conveyorObj;
        Conveyor_so=new List<SelectOption>();
        Conveyor_so.add(new SelectOption('---',''));
        
        for(Customer_Asset__c Obj:[select id,Division__c,Name from Customer_Asset__c where Division__c=:division])
        Conveyor_so.add(new SelectOption(Obj.id,Obj.Name));
        
        Conveyor=conveyorObj.id;
        
        isConveyorHome=false;
        isQSRHome=true;
        return null;
    }
    public PageReference cancelConveyor(){
        isConveyorHome=false;
        isQSRHome=true;
        return null;
    }
    
    //Division
    public PageReference newDivision(){
        DivisionObj=new Division__c();
        DivisionObj.Location__c=Property_Location;
        isDivisionHome=true;
        isQSRHome=false;
        return null;
    }
    public PageReference saveDivision(){
        	upsert DivisionObj;
        	division_so=new List<SelectOption>();
        	division_so.add(new SelectOption('---',''));
            
            for(Division__c Obj:[select id,Location__c,Name from Division__c where Location__c=:Property_Location])
                division_so.add(new SelectOption(Obj.id,Obj.Name));
        	
            division=DivisionObj.id;
        	isDivisionHome=false;
        	isQSRHome=true;    
            
            
            Conveyor='';
        	Conveyor_so=new List<SelectOption>();
        	Conveyor_so.add(new SelectOption('---',''));
            
        return null;
    }
    public PageReference cancelDivision(){
        isDivisionHome=false;
        isQSRHome=true;
        return null;
    }
    
    // Contact on QRS form
    public PageReference newQRSContact(){
        isQRSContact=true;
        isQSRHome=false;
        QRScontact_Obj=new contact(accountid=account_Obj.id);
        return null;
    }
    public PageReference saveQRSContact(){
        upsert QRScontact_Obj;
        QSRcontact_so=new List<SelectOption>();
        QSRcontact_so.add(new SelectOption('---',''));
        
        for(contact Obj:[select id,firstName,LastName,phone,name,email from contact where accountid=:account_Obj.id]){
            if(Obj.phone!=null)
            	QSRcontact_so.add(new SelectOption(Obj.id,Obj.name+'-'+Obj.Phone));
            else
            	QSRcontact_so.add(new SelectOption(Obj.id,Obj.name));  
        }
		QSRcontact=QRScontact_Obj.id;
        
        isQRSContact=false;
        isQSRHome=true;
        return null;
    }
    public PageReference cancelQRSContact(){
        isQRSContact=false;
        isQSRHome=true;
        return null;
    }
}