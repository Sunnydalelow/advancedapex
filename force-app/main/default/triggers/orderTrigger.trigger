/**
 * @name orderTrigger
 * @description
**/
trigger orderTrigger on Order (after update)
{
    
    if ( Trigger.New != null ){
        OrderHelper.AfterUpdate(Trigger.New,Trigger.Old);
            }
}