@isTest
public class TestSaddleandIdlerLookup_ctrl {
    public static testmethod void CaseOne(){
        List<sObject> ls = Test.loadData(Specifications_Data_Base__c.sObjectType, 'Specifications_Data_Base');
        //system.debug(ls);
        //insert ls;
        System.debug(ls.size());
        Saddle__c s = new Saddle__c();
        insert s;
        SaddleandIdlerLookup_ctrl sl= new SaddleandIdlerLookup_ctrl(new ApexPages.StandardController(s));
        PageReference pageRef = Page.SaddleandIdlerLookup;
        Test.setCurrentPage(pageRef);
        sl.unload();
        sl.saddle.Belt_Width__c=24;
        sl.initialize();
        sl.saddle.Belt_Speed__c=30;
        sl.initialize();
        sl.saddle.Tons_per_Hour__c=20;
        sl.initialize();
        sl.saddle.Material_Density__c='Copper';
        sl.unload();
        sl.saddle.MAX_Lump_Size__c=20;
        sl.unload();
        sl.saddle.Drop_Height__c=20;
        sl.unload();
        sl.saddle.Trough_Angle__c=25;
        sl.unload();
        sl.saddle.Bolt_Centers__c=20;
        sl.unload();
        sl.saddle.Center_Height__c=20;
        sl.unload();
        sl.saddle.Wing_Height__c=20;
        sl.unload();
        sl.saddle.Chord_Length__c=20;
        sl.unload();
        sl.saddle.Idler_in_Load_Zone__c='yes';
        sl.unload();
    }
}