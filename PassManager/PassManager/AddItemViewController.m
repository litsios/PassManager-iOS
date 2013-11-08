#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "AddItemViewController.h"
#import "PassManagerService.h"
#import "LoginListController.h"
#import "GenViewController.h"



@interface AddItemViewController ()

@end

@implementation AddItemViewController

@synthesize itemSiteName;
@synthesize itemUsername;
@synthesize itemPassword;
@synthesize itemUrl;
@synthesize itemNotes;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    //UI configuration
    UIImage *normalImage = [[UIImage imageNamed:@"greyButton.png"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
	UIImage *pressedImage = [[UIImage imageNamed:@"greyButton.png"]
                             resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18,18)];
    [self.insertButton setBackgroundImage:normalImage
                              forState:UIControlStateNormal];
	[self.insertButton setBackgroundImage:pressedImage
                              forState:UIControlStateHighlighted];

    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onAdd:(id)sender {
    //Checking if SiteName textfield is empty
    if (itemSiteName.text.length ==0 || itemUsername.text.length ==0 || itemPassword.text.length ==0 || itemUrl.text.length ==0){
        //Display a warning if SiteName textfield is empty
        UIAlertView *alertDialog;
        alertDialog = [[UIAlertView alloc]
                       initWithTitle: @"Login Insert"
                       message:@"All Fields except Notes are Required!"
                       delegate: nil
                       cancelButtonTitle: @"Ok"
                       otherButtonTitles: nil];
        [alertDialog show];
        return;}
        else{
    //Create the login item that contains the details
    NSDictionary *item=@{@"text" : itemSiteName.text, @"username" : itemUsername.text, @"password" : itemPassword.text, @"url" : itemUrl.text, @"notes" : itemNotes.text, @"deleted" : @NO};
        //Calling the addItem from GenViewController to add a new login entry
        [((GenViewController *)self.parentViewController).passManagerService  addItem:item completion:^(NSUInteger index){
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            }];
    
    //Preparing the textfields to be used again
    itemSiteName.text=@"";
    itemUsername.text=@"";
    itemPassword.text=@"";
    itemUrl.text=@"";
    itemNotes.text=@"";
    //Inform user that the login Created with success
    UIAlertView *alertDialog;
	alertDialog = [[UIAlertView alloc]
                   initWithTitle: @"Login Insert"
                   message:@"Login Added Successfully!"
                   delegate: nil
                   cancelButtonTitle: @"OK"
                   otherButtonTitles: nil];
            [alertDialog show];}
    
}
- (IBAction)hideKeyboard:(id)sender {
    [self.itemSiteName resignFirstResponder];
    [self.itemUsername resignFirstResponder];
    [self.itemPassword resignFirstResponder];
    [self.itemUrl resignFirstResponder];
    [self.itemNotes resignFirstResponder];
}
//Unloading elements when leaving the view
- (void)viewDidUnload {
    [self setInsertButton:nil];
    [self setItemNotes:nil];
    [super viewDidUnload];
}
@end
