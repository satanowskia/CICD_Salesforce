@isTest 
public class DailyLeadProcessorTest {
	@isTest  
	private static void testSchedulableClass()
    {
        List<Lead> leads = new List<Lead>();
    	for (Integer i=0;i<200;i++) {
        leads.add(new Lead(lastName='Name'+i, Company='BT'));
        }
    	insert leads;
        
        String CRON_EXP = '0 0 0 15 3 ? 2022';
        
        Test.startTest();
        DailyLeadProcessor dlp = new DailyLeadProcessor();
        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP,
            dlp);
        Test.stopTest();
        
        List<Lead> updatedLeads = [SELECT Id
            FROM Lead
            WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(200, [select count() from lead where LeadSource = 'Dreamforce']);
        
	}
}