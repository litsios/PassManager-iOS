#import "GenViewController.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "PassManagerService.h"

@interface GenViewController ()

@end

@implementation GenViewController

@synthesize passManagerService;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    //Create the passManagerService that will be used to the app
    [super viewDidLoad];
    self.passManagerService = [[PassManagerService alloc]init];
    [self performSelector:@selector(login) withObject:self afterDelay:0.1];
}
- (void) login
{
    UINavigationController *controller =
    
    [self.passManagerService.client
     loginViewControllerWithProvider:@"facebook"
     completion:^(MSUser *user, NSError *error) {
         
         
         if (error) {
             NSLog(@"Authentication Error: %@", error);
         } else {
             [self.passManagerService refreshDataOnSuccess:^{
                 
             }];
         }
         [self dismissViewControllerAnimated:YES completion:nil];
     }];
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
