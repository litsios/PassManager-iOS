#import "VisitUrlViewController.h"
#import "ViewLoginViewController.h"
#import "VisitUrlViewController.h"
@interface VisitUrlViewController ()

@end


@implementation VisitUrlViewController
@synthesize urlString;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //Preparing to visit webpage
    NSURL *detailURL;
    NSString *myURLString = self.urlString;
    
    //Checking if user has prefixed http// before url
    if ([myURLString hasPrefix:@"http://"]) {
        detailURL = [NSURL URLWithString:myURLString];
    } else {
        detailURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",myURLString]];
    }
    [self.visitUrl loadRequest:[NSURLRequest requestWithURL:detailURL]];
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//Emptying the Url for next use
- (void)viewDidUnload {
    [self setVisitUrl:nil];
    [super viewDidUnload];
}
@end
