global class MoveAttachments implements Database.Batchable<SObject>,Schedulable
{
 global void execute(SchedulableContext context)
    {
     Database.executeBatch(new MoveAttachments(),1);
    }
   global Database.QueryLocator start(Database.BatchableContext BC)
    {
     DateTime obj = System.now().addMinutes(-15);
     String query = 'select id,name,body,parentId from Attachment where createdDate >: obj';
        return Database.getQueryLocator(query);
    }
   global void execute(Database.BatchableContext BC, List<Attachment> scope)
    {
    Map<Id,ContentVersion> attmap= new Map<Id,ContentVersion>();
    Map<Id,ContentVersion> contMap;
    List<ContentVersion> contlist= new List<ContentVersion>();
    List<ContentDocumentLink> cdllist = new List<ContentDocumentLink>();
    List<Id> delatt = new List<Id> ();
    List<Attachment> attlist;
    String str = 'a1G';
    String str4 = 'a1K';
    for(Attachment att : scope)
    {
       String str1 = (String)att.ParentId;
       String str2 = str1.substring(0,3);
       System.debug(str1);
       System.debug(str2);
       if(str2==str || str2 == str4)
        {
          delatt.add(att.id);
          ContentVersion cont = new ContentVersion();
          cont.Title = att.Name;
          cont.PathOnClient = att.Name;
          cont.VersionData = att.Body;
          cont.Origin = 'H';
          contlist.add(cont);
          attmap.put(att.id,cont);
        }
     }
        insert contlist;
        contMap = new Map<Id,ContentVersion>([select contentDocumentId from ContentVersion where id in: contlist]);
    for(Attachment att :scope)
    {
        //system.debug('cont='+cont);
         String str1 = (String)att.ParentId;
         String str3 = str1.substring(0,3);
         System.debug(str3);
        if(str3 == str || str3 == str4)
        {
            
           ContentVersion cont=attmap.get(att.id);
           ContentDocumentLink cdl = new ContentDocumentLink();
           cdl.ContentDocumentId = contMap.get(cont.id).contentDocumentId;
           cdl.LinkedEntityId = att.ParentId;
           cdl.ShareType = 'I';
           cdllist.add(cdl);
        }
    }
        insert cdllist;
        attlist = [select id,Name,Body from Attachment where id in:delatt];
        delete attlist;
    }
   global void finish(Database.BatchableContext BC)
    {
     
    }
}