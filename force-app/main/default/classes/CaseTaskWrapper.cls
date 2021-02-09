public with sharing class CaseTaskWrapper {
    @AuraEnabled
    public String Type { get; set; }
    @AuraEnabled
    public String Status { get; set; }
    @AuraEnabled
    public String Subject { get; set; }
    @AuraEnabled
    public String ExtraCaseField { get; set; }
}