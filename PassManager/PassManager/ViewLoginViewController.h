#import <UIKit/UIKit.h>
@class VisitUrlViewController;
@interface ViewLoginViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) IBOutlet UITextView *viewItemSiteName;
@property (strong, nonatomic) IBOutlet UILabel *viewItemUsername;
@property (strong, nonatomic) IBOutlet UILabel *viewItemPassword;
@property (strong, nonatomic) IBOutlet UILabel *viewItemUrl;
@property (strong, nonatomic) IBOutlet UITextView *viewItemNotes;
@property (strong, nonatomic) VisitUrlViewController *visitUrlViewController;
@property (strong, nonatomic) IBOutlet UIButton *visitPageButton;

- (IBAction)foundSwipe:(id)sender;
- (IBAction)foundSwipeLeft:(id)sender;


@end
