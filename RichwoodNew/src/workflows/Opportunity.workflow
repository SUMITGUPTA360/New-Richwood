<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Quote_Ready_Notification</fullName>
        <description>Quote Ready Notification</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>sstoll@richwood.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Richwood_Auto_Emails/Quote_Ready_Email</template>
    </alerts>
    <alerts>
        <fullName>Send</fullName>
        <description>Send Manager Review Email</description>
        <protected>false</protected>
        <recipients>
            <field>Oppty_Owner_s_Manager_s_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>sstoll@richwood.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Richwood_Auto_Emails/RFQ_Mgr_Review_Email_Visualforce</template>
    </alerts>
    <alerts>
        <fullName>quote_request_email_vf</fullName>
        <ccEmails>customerservice@richwood.com</ccEmails>
        <description>quote request email_VF</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Richwood_Auto_Emails/Quote_Request_Email_Visualforce</template>
    </alerts>
    <fieldUpdates>
        <fullName>Get_Oppty_Owner_s_Manager_s_Email</fullName>
        <field>Oppty_Owner_s_Manager_s_Email__c</field>
        <formula>Owner.Manager.Email</formula>
        <name>Get Oppty Owner&apos;s Manager&apos;s Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Oppty_RFQ_Date_Set</fullName>
        <field>RFQ_Submitted__c</field>
        <formula>NOW()</formula>
        <name>Oppty RFQ Date Set</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Get Owner%27s Manager%27s Email</fullName>
        <actions>
            <name>Get_Oppty_Owner_s_Manager_s_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Oppty RFQ Date</fullName>
        <actions>
            <name>Oppty_RFQ_Date_Set</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Quote Requested of Customer Service</value>
        </criteriaItems>
        <description>Save RFQ Submission Date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>send RFQ manager review email</fullName>
        <actions>
            <name>Send</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Manager Review</value>
        </criteriaItems>
        <description>`</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>send quote request to cs - britt martin</fullName>
        <actions>
            <name>quote_request_email_vf</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Quote_Request_Notifcation_Sent_to_CS</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Quote Requested of Customer Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>equals</operation>
            <value>Britt Martin</value>
        </criteriaItems>
        <description>`</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>send quote request to cs - chris cook</fullName>
        <actions>
            <name>quote_request_email_vf</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Quote_Request_Notifcation_Sent_to_CS</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Quote Requested of Customer Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>equals</operation>
            <value>Chris Cook</value>
        </criteriaItems>
        <description>`</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>send quote request to cs - corey bell</fullName>
        <actions>
            <name>quote_request_email_vf</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Quote_Request_Notifcation_Sent_to_CS</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Quote Requested of Customer Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>equals</operation>
            <value>Corey Bell</value>
        </criteriaItems>
        <description>`</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>send quote request to cs - david silbernagel</fullName>
        <actions>
            <name>quote_request_email_vf</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Quote_Request_Notifcation_Sent_to_CS</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Quote Requested of Customer Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>equals</operation>
            <value>David Silbernagel</value>
        </criteriaItems>
        <description>`</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>send quote request to cs - don stoll</fullName>
        <actions>
            <name>quote_request_email_vf</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Quote_Request_Notifcation_Sent_to_CS</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Quote Requested of Customer Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>equals</operation>
            <value>Don Stoll</value>
        </criteriaItems>
        <description>`</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>send quote request to cs - doug sayers</fullName>
        <actions>
            <name>quote_request_email_vf</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Quote_Request_Notifcation_Sent_to_CS</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Quote Requested of Customer Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>equals</operation>
            <value>Doug Sayers</value>
        </criteriaItems>
        <description>`</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>send quote request to cs - exequiel medina</fullName>
        <actions>
            <name>quote_request_email_vf</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Quote_Request_Notifcation_Sent_to_CS</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Quote Requested of Customer Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>equals</operation>
            <value>Exequiel Medina</value>
        </criteriaItems>
        <description>`</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>send quote request to cs - jeremiah</fullName>
        <actions>
            <name>quote_request_email_vf</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Quote_Request_Notifcation_Sent_to_CS</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Quote Requested of Customer Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>equals</operation>
            <value>Jeremiah Hinds</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>send quote request to cs - jim cooper</fullName>
        <actions>
            <name>quote_request_email_vf</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Quote_Request_Notifcation_Sent_to_CS</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Quote Requested of Customer Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>equals</operation>
            <value>Jim Cooper</value>
        </criteriaItems>
        <description>`</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>send quote request to cs - joe carroll</fullName>
        <actions>
            <name>quote_request_email_vf</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Quote_Request_Notifcation_Sent_to_CS</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Quote Requested of Customer Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>equals</operation>
            <value>Joe Carroll</value>
        </criteriaItems>
        <description>`</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>send quote request to cs - john anderson</fullName>
        <actions>
            <name>quote_request_email_vf</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Quote_Request_Notifcation_Sent_to_CS</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Quote Requested of Customer Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>equals</operation>
            <value>John Anderson</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>send quote request to cs - kent clouse</fullName>
        <actions>
            <name>quote_request_email_vf</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Quote_Request_Notifcation_Sent_to_CS</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Quote Requested of Customer Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>equals</operation>
            <value>Kent Clouse</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>send quote request to cs - kim conrod</fullName>
        <actions>
            <name>quote_request_email_vf</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Quote_Request_Notifcation_Sent_to_CS</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Quote Requested of Customer Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>equals</operation>
            <value>Kim Conrod</value>
        </criteriaItems>
        <description>`</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>send quote request to cs - mark forest</fullName>
        <actions>
            <name>quote_request_email_vf</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Quote_Request_Notifcation_Sent_to_CS</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Quote Requested of Customer Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>equals</operation>
            <value>Mark Forest</value>
        </criteriaItems>
        <description>`</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>send quote request to cs - mike mckettrick</fullName>
        <actions>
            <name>quote_request_email_vf</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Quote_Request_Notifcation_Sent_to_CS</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Quote Requested of Customer Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>equals</operation>
            <value>Mike McKettrick</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>send quote request to cs - roger maynard</fullName>
        <actions>
            <name>quote_request_email_vf</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Quote_Request_Notifcation_Sent_to_CS</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Quote Requested of Customer Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>equals</operation>
            <value>Roger Maynard</value>
        </criteriaItems>
        <description>`</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>send quote request to cs - scott baisden</fullName>
        <actions>
            <name>quote_request_email_vf</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Quote_Request_Notifcation_Sent_to_CS</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Quote Requested of Customer Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>equals</operation>
            <value>Scott Baisden</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>send quote request to cs - scott patten</fullName>
        <actions>
            <name>quote_request_email_vf</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Quote_Request_Notifcation_Sent_to_CS</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Quote Requested of Customer Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>equals</operation>
            <value>Scott Patten</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>send quote request to cs - sean maloy</fullName>
        <actions>
            <name>quote_request_email_vf</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Quote_Request_Notifcation_Sent_to_CS</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Quote Requested of Customer Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>equals</operation>
            <value>Sean Maloy</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>send quote request to cs - shane greenough</fullName>
        <actions>
            <name>quote_request_email_vf</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Quote_Request_Notifcation_Sent_to_CS</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Quote Requested of Customer Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>equals</operation>
            <value>Shane Greenough</value>
        </criteriaItems>
        <description>`</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>send quote request to cs - shaun gwaltney</fullName>
        <actions>
            <name>quote_request_email_vf</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Quote_Request_Notifcation_Sent_to_CS</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Quote Requested of Customer Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>equals</operation>
            <value>Shaun Gwaltney</value>
        </criteriaItems>
        <description>`</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>send quote request to cs - shon heaps</fullName>
        <actions>
            <name>quote_request_email_vf</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Quote_Request_Notifcation_Sent_to_CS</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Quote Requested of Customer Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>equals</operation>
            <value>Shon Heaps</value>
        </criteriaItems>
        <description>`</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>send quote request to cs - tim deal</fullName>
        <actions>
            <name>quote_request_email_vf</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Quote_Request_Notifcation_Sent_to_CS</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Quote Requested of Customer Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>equals</operation>
            <value>Tim Deal</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>send quote request to cs - trent indermuhle</fullName>
        <actions>
            <name>quote_request_email_vf</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Quote_Request_Notifcation_Sent_to_CS</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Quote Requested of Customer Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>equals</operation>
            <value>Trent Indermuhle</value>
        </criteriaItems>
        <description>`</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>send quote request to cs - vitor almeida</fullName>
        <actions>
            <name>quote_request_email_vf</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Quote_Request_Notifcation_Sent_to_CS</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Quote Requested of Customer Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>equals</operation>
            <value>Vitor Almeida</value>
        </criteriaItems>
        <description>`</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>send quote request to cs - zack elam</fullName>
        <actions>
            <name>quote_request_email_vf</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Quote_Request_Notifcation_Sent_to_CS</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Quote Requested of Customer Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>equals</operation>
            <value>Zack Elam</value>
        </criteriaItems>
        <description>`</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <tasks>
        <fullName>Quote_Ready_Notification_Sent</fullName>
        <assignedToType>owner</assignedToType>
        <description>(Automated) Quote Ready Alert sent via email</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>(Auto) Quote Ready Notification Sent</subject>
    </tasks>
    <tasks>
        <fullName>Quote_Request_Notifcation_Sent_to_CS</fullName>
        <assignedToType>owner</assignedToType>
        <description>(Automated) Quote Request email has been sent to Customer Service</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>(Auto) Quote Request Notification Sent to CS</subject>
    </tasks>
</Workflow>
