public class DailyLeadProcessor implements Schedulable{

    public void execute(SchedulableContext ctx) {
        List<Lead> ld = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = null LIMIT 200];
        for (Lead l : ld) {
            l.LeadSource = 'Dreamforce';
        }

        update ld;
    }
}