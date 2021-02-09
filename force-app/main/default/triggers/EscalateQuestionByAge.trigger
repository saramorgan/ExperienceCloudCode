trigger EscalateQuestionByAge on FeedItem (after update) {
	if (trigger.isUpdate) {
        List<Case> caseList = new List<Case>();
    
        for(FeedItem f : Trigger.New) {
            // Check if the feed item is available in all Experience Cloud sites
            if(f.NetworkScope != null && !(f.NetworkScope).equals('AllNetworks')) {
                // Determine how old the post is
                Datetime createdDate = f.CreatedDate;
                DateTime currentDate = Datetime.now();
                Long createdTime = createdDate.getTime();
                Long currentTime = currentDate.getTime();
                Long ddays = (currentTime - createdTime)/(24*60*60*1000);
                
                // Create a new internal community case if a question post has no
                // comment tagged as the best and it is over 5 days old
                if(f.Type == 'QuestionPost' && f.BestCommentId == null && ddays > 5) {
                    Case c = new Case();
                    c.Subject = f.title + ' Question';
                    c.Status = 'New';
                    c.Type = 'Question';
                    c.Origin = 'Community';
                    caseList.add(c);
                }
            }
        }
        
        // Insert all the Case records in a bulkified way
        if (caseList.size() > 0) {
            Database.SaveResult[] result = Database.insert(caseList, false);
        }
    }
}