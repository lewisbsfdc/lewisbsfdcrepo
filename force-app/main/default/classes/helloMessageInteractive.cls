public class helloMessageInteractive {
    @AuraEnabled
    Public Static List<CaseComment> getCaseComment(String caseId){
        system.Debug('getCaseComment: CaseId = ' + caseId );
        List<CaseComment> lstCaseComment = new List<CaseComment>();
        lstCaseComment = [Select ParentId, CreatedById, CreatedDate, CommentBody 
                         From CaseComment
                         Where ParentId = :caseId];
        //if (lstCaseComment.isEmpty()
        system.debug('lstCaseComment.size -> ' + lstCaseComment.size());
        return lstCaseComment;
    }
}