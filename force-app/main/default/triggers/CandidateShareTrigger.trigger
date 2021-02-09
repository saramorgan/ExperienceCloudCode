trigger CandidateShareTrigger on Job_Application__c (after insert) {
    if (trigger.isInsert) {
        List<Candidate__Share> candShareList = new List<Candidate__Share>();
        
        for (Job_Application__c rec : trigger.new) {
            // Ensure that an interviewer and candidate have been selected
            if (rec.Candidate__c != null && rec.Interviewer__c != null) {
                Candidate__Share candShare = new Candidate__Share();
                candShare.ParentId = rec.Candidate__c;
                candShare.UserOrGroupId = rec.Interviewer__c;
                candShare.AccessLevel = 'Read';
                candShare.RowCause = Schema.Candidate__Share.RowCause.CandidateToInterviewer__c;
                candShareList.add(candShare);
            }   
        }
        
        // Insert all the Candidate share records in a bulkified way
        if (candShareList.size() > 0) {
            Database.SaveResult[] result = Database.insert(candShareList, false);
        }
    }

}