@isTest
public class QuickServiceRequest_Ctrl_Test {
    public static testmethod void caseOne(){
        QuickServiceRequest_Ctrl Obj=new QuickServiceRequest_Ctrl();
        Obj.newAccount();
        Obj.cancelAccount();
        Obj.newAccount();
        Obj.account_Obj.Name='Test';
        Obj.saveAccount();
        
        Obj.editAccount();
        Obj.account_Obj.Name='Test';
        Obj.cancelAccount();
        
        Obj.newContact();
        Obj.contact_Obj.lastName='Test';
        Obj.saveContact();
        Obj.editContact();
        Obj.cancelContact();
        
        Obj.newQRSBttn();
        Obj.Property_Location();
        Obj.saveQRS();
        Obj.cancelQRS();
        
        Obj.newQRSBttn();
        Obj.newProperty();
        Obj.cancelProperty();
        Obj.newProperty();
        Obj.saveProperty();
        
        Obj.newDivision();
        Obj.Property_Location=[select id from Location__c limit 1].id;
        Obj.saveDivision();
        Obj.cancelDivision();
        
		Obj.Division_so();        
       
        Obj.newConveyor();
        Obj.cancelConveyor();
        Obj.newConveyor();
		Obj.division=[select id from Division__c limit 1].id;
        Obj.saveConveyor();
        
        Obj.newQRSContact();
        Obj.QRScontact_Obj.lastName='Test';
        Obj.cancelQRSContact();
        
        
        
        Obj.newQRSContact();
        Obj.QRScontact_Obj.lastName='Test';
        Obj.saveQRSContact();
        Obj.saveQRS();
        
        
    }
}