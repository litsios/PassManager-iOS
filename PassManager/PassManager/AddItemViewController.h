#import <UIKit/UIKit.h>

@interface AddItemViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *itemSiteName;
@property (strong, nonatomic) IBOutlet UITextField *itemUsername;
@property (strong, nonatomic) IBOutlet UITextField *itemPassword;
@property (strong, nonatomic) IBOutlet UITextField *itemUrl;
@property (strong, nonatomic) IBOutlet UITextField *itemNotes;
@property (strong, nonatomic) IBOutlet UITextField *hideKeyboard;
@property (strong, nonatomic) IBOutlet UIButton *insertButton;

- (IBAction)onAdd:(id)sender;
- (IBAction)doAlert:(id)sender;


@end
