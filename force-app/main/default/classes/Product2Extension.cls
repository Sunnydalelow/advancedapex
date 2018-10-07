public class Product2Extension {
	Integer d = Constants.DEFAULT_ROWS;
    public List<ProductWrapper> productsToInsert {get;set;}

    public Product2Extension(ApexPages.StandardController controller){

        productsToInsert = new List<ProductWrapper>();
        addRows();
    }
    
    public void AddRows(){
        for ( Integer i=0; i<d; i++ ){
            productsToInsert.add( new ProductWrapper() );
        }
    }
    
    public List<SelectOption> getFamilyOptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption(Constants.SELECT_ONE, Constants.SELECT_ONE));
        for (Schema.PicklistEntry f : Constants.PRODUCT_FAMILY ){
            options.add(new SelectOption(f.getLabel(),f.getValue()));
        }
        
        return options;
        
    }

    public List<ChartHelper.ChartData> GetInventory(){
        return ChartHelper.GetInventory();
    }

    public PageReference Save(){
        Savepoint sp = Database.setSavepoint();
		
        try {
            List<Product2>prodRecs = new List<Product2>();
            List<PricebookEntry> pbEntries = new List<PricebookEntry>();
            
  
            for(ProductWrapper r : productsToInsert){
                if(null!=r.productRecord && null!=r.pricebookEntryRecord){
                    if(null!=r.productRecord.Name && null!=r.productRecord.Family && constants.SELECT_ONE!=r.productRecord.Family
                       && null!=r.productRecord.Initial_Inventory__c && null!=r.pricebookEntryRecord.UnitPrice){
                
                           prodRecs.add(r.productRecord);
                           PricebookEntry pbe = r.pricebookEntryRecord;
                           pbe.IsActive = true;
                           pbe.Pricebook2Id = constants.STANDARD_PRICEBOOK_ID;
                           pbEntries.add(pbe);
                           
                       }}}
            
            
            insert prodRecs;
            
            for (integer i = 0; i < pbEntries.size(); i++) {
                pbEntries[i].Product2Id = prodRecs[i].Id;
            }
            
            insert pbEntries;

            
            
            //If successful clear the list and display an informational message
            apexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,productsToInsert.size()+' Inserted'));
            productsToInsert.clear();   //Do not remove
            addRows();  //Do not remove
        } catch (Exception e){
			apexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,constants.ERROR_MESSAGE));
            Database.rollback(sp);

        }
        
        return null;
    }
	
    //wrapper class
     public class ProductWrapper{
        public Product2 productRecord {get; set;}
        public PriceBookEntry pricebookEntryRecord {get;set;}
        
         //constructor for wrapper class
         public ProductWrapper(){
             productRecord = new product2(Initial_Inventory__c =0);
             pricebookEntryRecord = new pricebookEntry(Unitprice=0.0);
        }
    }

}