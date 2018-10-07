public class Constants {
 public static final Integer DEFAULT_ROWS = 5;
 public static final String SELECT_ONE = System.label.Select_One;
    public static final String INVENTORY_LEVEL_LOW = System.label.Inventory_Level_Low;
    public static final Schema.DescribeFieldResult fieldResult = Product2.Family.getDescribe();
    
public static final List<Schema.PicklistEntry> PRODUCT_FAMILY = fieldResult.getPicklistValues();
public static final String DRAFT_ORDER_STATUS = 'Draft';
public static final String ACTIVATED_ORDER_STATUS = 'Activated';
public static final String INVENTORY_ANNOUNCEMENTS = 'Inventory Announcements';
public static final String ERROR_MESSAGE = 'An error has occurred, please take a screenshot with the URL and send it to IT.';
public static final Id STANDARD_PRICEBOOK_ID = '01sf2000001No1o';

    //Can I save this????
}