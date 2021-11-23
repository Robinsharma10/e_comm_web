trigger coursestrigger on Courses__c (before insert,before update,after insert) {
	  if(Trigger.isBefore){
        if(Trigger.isInsert || trigger.isUpdate){
            System.debug('I m before insert');
            set<Id> id = new set<Id>();
        List<AggregateResult> aggre = new List<AggregateResult>([select Professor__c, count(name) courses from Courses__c where Professor__c!=null group by Professor__c]);
        for(AggregateResult Aresult : aggre){
            if(Aresult.get('courses') == 4){
                id.add((Id)Aresult.get('Professor__c'));
            }
        }
        for(Courses__c cou : Trigger.new){
            if(id.contains((Id) cou.get('Professor__c'))){
                cou.addError('you cannot select more than 4 courses..');
            }
        }
        }
        else if(Trigger.isUpdate){
            System.debug('I m before update');
        }
    }
   else if(Trigger.isAfter){
       if(Trigger.isInsert){
           System.debug('I m after event');
       } else if(Trigger.isUpdate){
           System.debug('I m after update');
       }
    }
    /*else if(Trigger.isAfter){
List<Professor__c> ls = [select Name,Id from Professor__c];
for(Professor__c prof: ls){
System.debug(prof);
System.debug('Hello');
}
List <Course__c> cs = [select Name,Professor__c from Course__c];
for(Course__c cou: cs){
System.debug(cou);
System.debug('Hello');
}
if(Trigger.isUpdate){
System.debug('I am after update');
}
}*/
}