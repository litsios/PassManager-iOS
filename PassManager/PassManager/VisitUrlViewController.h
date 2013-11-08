#import <UIKit/UIKit.h>



@interface VisitUrlViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *visitUrl;
@property (nonatomic,copy) NSString *urlString;
@end
