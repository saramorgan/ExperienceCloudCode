public with sharing class CaseController {
    @AuraEnabled
    public static void createCaseAndTask(CaseTaskWrapper wrapper) {
        // NOTE: In a real-world application, you would want to perform
        // additional CRUD permission testing to ensure component security
        String caseId = '';
        String taskSubject = 'Call';
        Date taskActivityDate = System.today().addDays(1);
        String description = 'Follow-up with the contact to make sure the issue has been resolved';

        Case newCase = new Case(
            Type = wrapper.Type,
            Status = wrapper.Status,
            Subject = wrapper.Subject
            //ExtraCaseField__c = wrapper.ExtraCaseField
        );
        insert newCase;

        Task newTask = new Task( 
            Subject = taskSubject,
            ActivityDate = taskActivityDate,
            Description = description,
            WhatId = newCase.Id,
            WhoId = UserInfo.getUserId()  //For simplicity, just assigning the task to the user that is accessing the component
        );
        insert newtask;
    }
}