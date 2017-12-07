@isTest 
public class SF1_Opportunity_Test {
    public static testMethod void SF1_TestMethod_One(){
    SF1_Opportunity_ctrl sfc = new SF1_Opportunity_ctrl();
    PageReference pageRef = Page.SF1_Opportunity_Editor;
    Test.setCurrentPage(pageRef);
    sfc.accountCreate();
    sfc.cancelAccount_Mode();
    sfc.accountCreate();
    sfc.account_Obj.name='test';
    sfc.saveAccount();
    sfc.EditAccount();
    sfc.cancelAccount();
    
    sfc.contactCreate();
    sfc.cancelContact();
    sfc.contactCreate();
    sfc.contact_Obj.lastName='test';
    sfc.saveContact();
    sfc.EditContact();
    sfc.cancelContact_Mode();
    
        sfc.oppCreate();
        sfc.cancelopp();
        sfc.oppCreate();
         sfc.opportunity_Obj.name='test';
           sfc.opportunity_Obj.stagename='Qualification';
           sfc.opportunity_Obj.closedate=system.today()+3;
           ApexPages.currentPage().getParameters().put('oppCloseDateOne','2016-01-02');
       
        sfc.saveopp();
                sfc.EditOpp();
        sfc.cancelOPP_Mode(); 
        
        //
        Product2 pro = new Product2(Name='BXCD',isActive=true);
          insert pro;
        Pricebook2 pb2 = new Pricebook2(Name='DIE');
         insert pb2;
        //
        
        sfc.showProductDetails();           
        ApexPages.currentPage().getParameters().put('pro_idx','BXCD');
        sfc.forProductSearch();
        
        ApexPages.currentPage().getParameters().put('product2_idx','0');
        ApexPages.currentPage().getParameters().put('orgin','desktop');        
        
        sfc.forProduct2Detail();
        sfc.OpportunityLineItem_Obj.Quantity=1;
        sfc.saveOpportunityLineItem();
                
        //New
        PageReference pagePro = Page.productEditPage_mobile;
        Test.setCurrentPage(pagePro);
        ApexPages.currentPage().getParameters().put('orgin','desktop');
        //End of NEw
        
         ApexPages.currentPage().getParameters().put('product_name', ''+sfc.product2_Obj.Name+'');
        ApexPages.currentPage().getParameters().put('UnitPrice', ''+sfc.priceOfProducts.get(sfc.product2_Obj.id)+'');
        ApexPages.currentPage().getParameters().put('OpportunityId', ''+sfc.opportunity_Obj.id+'');
        ApexPages.currentPage().getParameters().put('PricebookEntryId', ''+sfc.pricebookId_Of_Products.get(sfc.product2_Obj.id)+'');

        
            ApexPages.currentPage().getParameters().put('accid',''+sfc.account_Obj.id+''); 
          ApexPages.currentPage().getParameters().put('conid',''+sfc.contact_Obj.id+''); 
          ApexPages.currentPage().getParameters().put('opp_idx',''+sfc.opportunity_Obj.id+''); 
                proudctEditPage_ctrl sfc_pro = new proudctEditPage_ctrl();
                sfc_pro.saveOpportunityLineItem();
                sfc_pro.cancelOpportunityLineItem();
    }
    public static testMethod void SF1_TestMethod(){
    SF1_Opportunity_ctrl sfc = new SF1_Opportunity_ctrl();
    PageReference pageRef = Page.SF1_Opportunity_Editor ;
        Test.setCurrentPage(pageRef);
    sfc.accountCreate();
    sfc.cancelAccount_Mode();
    sfc.accountCreate();
    sfc.account_Obj.name='test';
    sfc.saveAccount();
    sfc.EditAccount();
    sfc.cancelAccount();
    
    sfc.contactCreate();
    sfc.cancelContact();
    sfc.contactCreate();
    sfc.contact_Obj.lastName='test';
    sfc.saveContact();
    sfc.EditContact();
    sfc.cancelContact_Mode();
    
        sfc.oppCreate();
        sfc.cancelopp();
        sfc.oppCreate();
         sfc.opportunity_Obj.name='test';
           sfc.opportunity_Obj.stagename='Qualification';
           sfc.opportunity_Obj.closedate=system.today()+3;
           ApexPages.currentPage().getParameters().put('oppCloseDateOne','2016-01-02');
       
        sfc.saveopp();
                sfc.EditOpp();
        sfc.cancelOPP_Mode(); 
        
        //
        Product2 pro = new Product2(Name='BXCD',isActive=true);
          insert pro;
        Pricebook2 pb2 = new Pricebook2(Name='DIE');
         insert pb2;
        //
        
        sfc.showProductDetails();           
        ApexPages.currentPage().getParameters().put('pro_idx','BXCD');
        sfc.forProductSearch();
        
        ApexPages.currentPage().getParameters().put('product2_idx','0');
        ApexPages.currentPage().getParameters().put('orgin','desktop');        
        sfc.forProduct2Detail();
        
        sfc.OpportunityLineItem_Obj.Quantity=1;
        sfc.cancelOpportunityLineItem();
        
        
        ApexPages.currentPage().getParameters().put('account_name','');
        sfc.forAccountSearch();
        
     
        ApexPages.currentPage().getParameters().put('account_name','test');
        sfc.forAccountSearch();
        
        
        ApexPages.currentPage().getParameters().put('account_idx','0');
        sfc.forAccountDetail();
   
               
   sfc.contact_List=[select id,firstName,lastname,phone,email from contact];
//   System.currentPageReference().getParameters().put('contact_idx',''sfc.contact_List[0].id'');
   ApexPages.currentPage().getParameters().put('contact_idx',sfc.contact_Obj.lastName=sfc.account_Obj.id);
   sfc.forContactDetail();
        
       sfc.Opportunity_List= [select id,Name,StageName,closedate,description from opportunity];
       Apexpages.currentPage().getParameters().put('opp_idx',sfc.opportunity_Obj.name=sfc.account_Obj.id);
        sfc.forOpportuntiyDetail();
        
        
    }
     public static testMethod void SF1_TestMethod_two(){
    SF1_Opportunity_ctrl sfc = new SF1_Opportunity_ctrl();
    PageReference pageRef = Page.SF1_Opportunity_Editor;
        Test.setCurrentPage(pageRef);
            Account acc=new Account();
        acc.Name='test1';
        acc.Phone='1234567890';
        upsert acc;
        
        ApexPages.currentPage().getParameters().put('source','acc');
        ApexPages.currentPage().getParameters().put('accid',acc.id);
        
    }
    public static testMethod void stfdd(){
    SF1_Opportunity_ctrl sfc = new SF1_Opportunity_ctrl();
    PageReference pageRef = Page.SF1_Opportunity_Editor;
        Test.setCurrentPage(pageRef);
         sfc.accountCreate();
 sfc.account_Obj.name='test';
 sfc.saveAccount();
 sfc.contactCreate();
 sfc.contact_Obj.lastName='test';
 sfc.saveContact();
  sfc.oppCreate();
         sfc.opportunity_Obj.name='test';
           sfc.opportunity_Obj.stagename='Qualification';
           sfc.opportunity_Obj.closedate=system.today()+3;
           ApexPages.currentPage().getParameters().put('oppCloseDateOne','2016-01-02');
       
        sfc.saveopp();
         Product2 pro = new Product2(Name='BXCD',isActive=true);
          insert pro;
        Pricebook2 pb2 = new Pricebook2(Name='DIE');
         insert pb2;
          sfc.showProductDetails();           
        ApexPages.currentPage().getParameters().put('pro_idx','BXCD');
        sfc.forProductSearch();
        
        ApexPages.currentPage().getParameters().put('product2_idx','0');
        ApexPages.currentPage().getParameters().put('orgin','desktop');        
        sfc.forProduct2Detail();
        
        sfc.OpportunityLineItem_Obj.Quantity=1;
        sfc.saveOpportunityLineItem();
        sfc.EditOppLineItem();
        sfc.cancelOppLineItem();
        sfc.EditOppLineItem();
        sfc.saveOppLineItem();
        sfc.DelOppLineItem();
    }
   public static testmethod void testfive(){
       Account a=new Account(name='test');
        insert a;
        Contact c=new contact(lastname='lastname',accountid=a.id);
        insert c;
        opportunity o=new opportunity(name='test',accountid=a.id,closedate=system.today()+1,stagename='Qualification');
        insert o;
        

            PageReference pageRef = Page.SF1_Opportunity_Editor;
            Test.setCurrentPage(pageRef);
        
        
        
            pageRef.getParameters().put('source', 'product');
            pageRef.getParameters().put('accid', a.id);
            pageRef.getParameters().put('conid', c.id);
            pageRef.getParameters().put('opp_idx', o.id);    
                    SF1_Opportunity_ctrl sfc = new SF1_Opportunity_ctrl();
   }
}