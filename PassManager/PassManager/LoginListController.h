#import <UIKit/UIKit.h>
#import "PassManagerService.h"

@class ViewLoginViewController;

@interface LoginListController : UITableViewController<UITextFieldDelegate>{
}

@property (weak, nonatomic) IBOutlet UITextField *itemText;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) PassManagerService *passManagerService;
@property (strong, nonatomic) ViewLoginViewController *viewLoginViewController;

@end
