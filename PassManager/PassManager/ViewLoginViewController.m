#import "ViewLoginViewController.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "LoginListController.h"
#import "PassManagerService.h"
#import "VisitUrlViewController.h"

@interface ViewLoginViewController ()
- (void)configureView;
@end

@implementation ViewLoginViewController
//detailItem gets the login details from the previous tableview
@synthesize detailItem = _detailItem;
@synthesize viewItemSiteName = _detailDescriptionLabel;
@synthesize viewItemUsername;
@synthesize viewItemPassword;
@synthesize viewItemNotes;
@synthesize viewItemUrl;

@synthesize visitUrlViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}
- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.navigationItem.title = [self.detailItem objectForKey:@"text"];
        NSURL *detailURL;
        detailURL=[[NSURL alloc] initWithString:[self.detailItem objectForKey:@"url"]];
        self.viewItemSiteName.text = [self.detailItem objectForKey:@"text"];
        self.viewItemUsername.text = [self.detailItem objectForKey:@"username"];
        self.viewItemUrl.text=[self.detailItem objectForKey:@"url"];
        self.viewItemNotes.text=[self.detailItem objectForKey:@"notes"];
    }

}
- (void)viewDidLoad

{
    //UI configuration
    UIImage *normalImage = [[UIImage imageNamed:@"greyButton.png"]
                             resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
	UIImage *pressedImage = [[UIImage imageNamed:@"greyButton.png"]
                             resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18,18)];
    [self.visitPageButton setBackgroundImage:normalImage
                                 forState:UIControlStateNormal];
	[self.visitPageButton setBackgroundImage:pressedImage
                                 forState:UIControlStateHighlighted];

    [super viewDidLoad];
    [self configureView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    //Actions to do when leaving the interface and go back to logins list
    [self setViewItemSiteName:nil];
    [self setViewItemSiteName:nil];
    [self setViewItemSiteName:nil];
    [self setViewItemUsername:nil];
    [self setViewItemPassword:nil];
    [self setViewItemNotes:nil];
    [self setViewItemUrl:nil];
    [self setViewItemUrl:nil];
    [self setVisitPageButton:nil];
    [super viewDidUnload];
}
//Visit Url
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showUrl"]) {
        
        //Hiding the password field and leaving for destViewController and visit the webpage
        self.viewItemPassword.text = @"Swipe to show";
        VisitUrlViewController *destViewController = segue.destinationViewController;
        destViewController.urlString = self.viewItemUrl.text;
    }
}

# pragma gestures

//Display the password
- (IBAction)foundSwipe:(id)sender {
    self.viewItemPassword.text = [self.detailItem objectForKey:@"password"];
    
}
//Hides the password
- (IBAction)foundSwipeLeft:(id)sender {
    self.viewItemPassword.text = @"Swipe to show";
}
@end
