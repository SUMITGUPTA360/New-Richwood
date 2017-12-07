public class proudctEditPage_ctrl {
    public OpportunityLineItem OpportunityLineItem_Obj{get;set;}
    public boolean isDesktop{get;set;}
    public boolean isMobile{get;set;}
    public id accid{get;set;}
    public id conid{get;set;}
    public id opp_idx{get;set;}
        
    public proudctEditPage_ctrl(){
        isDesktop=false;
        isMobile=false;
        try{
                if(ApexPages.currentPage().getParameters().get('orgin')=='desktop')
                    isDesktop=true;
            	if(ApexPages.currentPage().getParameters().get('orgin')=='mobile')
                    isMobile=true;
        OpportunityLineItem_Obj=new OpportunityLineItem();
        OpportunityLineItem_Obj.OpportunityId=ApexPages.currentPage().getParameters().get('OpportunityId');
        OpportunityLineItem_Obj.PricebookEntryId=ApexPages.currentPage().getParameters().get('PricebookEntryId');
        OpportunityLineItem_Obj.UnitPrice=Decimal.valueOf( ApexPages.currentPage().getParameters().get('UnitPrice'));
            accid=ApexPages.currentPage().getParameters().get('accid');
                conid=ApexPages.currentPage().getParameters().get('conid');
                opp_idx=ApexPages.currentPage().getParameters().get('opp_idx');
        }catch(exception e){
            
        }
    }
    public pagereference saveOpportunityLineItem(){
        try{
    		insert OpportunityLineItem_Obj;        
        }catch(Exception e){
            System.debug(e.getStackTraceString());
        }
    	PageReference editList;
        if(isDesktop)
    		editList = Page.SF1_Opportunity_Editor;
        else if(isMobile)
            editList = Page.SF1_Opportunity_Editor_Mobile;
    editList.getParameters().put('source', 'product');
    editList.getParameters().put('accid', accid);
    editList.getParameters().put('conid', conid);
    editList.getParameters().put('opp_idx',opp_idx);    
    editList.setRedirect(true);
    return editList;
    }
    public pagereference cancelOpportunityLineItem(){
        PageReference editList;
    	if(isDesktop)
    		editList = Page.SF1_Opportunity_Editor;
        else if(isMobile)
            editList = Page.SF1_Opportunity_Editor_Mobile;
        editList.getParameters().put('source', 'product');
        editList.getParameters().put('accid',accid);
        editList.getParameters().put('conid',conid);
        editList.getParameters().put('opp_idx',opp_idx);    
        editList.setRedirect(true);
        return editList;    
    }
}