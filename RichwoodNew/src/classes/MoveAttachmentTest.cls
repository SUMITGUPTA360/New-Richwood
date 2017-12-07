@isTest
public class MoveAttachmentTest
{
      public static testMethod void test()
      {
          ProntoForm_Test__c ptoform = new ProntoForm_Test__c(Name='David');
          insert ptoform;
          String myString = 'StringToBlob';
          Blob myBlob = Blob.valueof(myString);
          Attachment att = new Attachment(Name='Myatttachment',Body=myBlob,ParentId=ptoform.id);
          insert att;
          new MoveAttachments().execute(null);
        /*  ContentVersion cont = new ContentVersion();
          cont.Title = att.Name;
          cont.PathOnClient = att.Name;
          cont.VersionData = att.Body;
          cont.Origin = 'H';
          insert cont;
          ContentDocumentLink cdl = new ContentDocumentLink();
          cdl.ContentDocumentId =[select contentDocumentId from ContentVersion where id =: cont.id].contentDocumentId;
          cdl.LinkedEntityId = att.ParentId;
          cdl.ShareType = 'I';
          insert cdl;
          */
      }
}