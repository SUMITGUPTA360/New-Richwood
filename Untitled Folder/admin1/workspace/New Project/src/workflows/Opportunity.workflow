<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_sent_to_client_when_its_closed_won</fullName>
        <description>Email sent to client when its closed won</description>
        <protected>false</protected>
        <recipients>
            <recipient>prema@360degreecloud.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SupportCaseAssignmentNotification</template>
    </alerts>
    <tasks>
        <fullName>Approval_for_Discount</fullName>
        <assignedTo>prema@360degreecloud.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>20</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Opportunity.CloseDate</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Approval for Discount</subject>
    </tasks>
    <tasks>
        <fullName>jhj</fullName>
        <assignedTo>prema@360degreecloud.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Opportunity.CloseDate</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>jhj</subject>
    </tasks>
</Workflow>
