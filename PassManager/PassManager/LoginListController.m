#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "LoginListController.h"
#import "PassManagerService.h"
#import "ViewLoginViewController.h"
#import "GenViewController.h"


#pragma mark * Private Interface


@interface LoginListController ()

// Private properties


@end


#pragma mark * Implementation


@implementation LoginListController

@synthesize passManagerService;
@synthesize itemText;
@synthesize activityIndicator;
@synthesize viewLoginViewController = _viewLoginViewController;


#pragma mark * UIView methods


- (void)viewDidLoad
{
    [super viewDidLoad];
    //Create the Refresh Element
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refresh addTarget:self
                action:@selector(refreshView:)
      forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    // Create the passManagerService - this creates the Mobile Service client inside the wrapped service
    self.passManagerService = ((GenViewController *)self.parentViewController.parentViewController).passManagerService;
    //Creating the viewLoginViewController that will be used if user enters the details of the login
    self.viewLoginViewController = (ViewLoginViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    [self checkForLoginAndRefresh];
}
- (void)viewDidAppear:(BOOL)animated
{
    [self checkForLoginAndRefresh];
}

- (void) checkForLoginAndRefresh{
    //What to do if no user has logged in
    if (passManagerService.client.currentUser == nil)
    {
        UIActivityIndicatorView *indicator = self.activityIndicator;
        self.passManagerService.busyUpdate = ^(BOOL busy) {
            if (busy) {
                [indicator startAnimating];
            } else {
                [indicator stopAnimating];
            }
        };
        
        [self performSelector:@selector(login) withObject:self afterDelay:0.1];
        
    }
    [self.tableView reloadData];
}

- (void) login
{
    UINavigationController *controller =
    [self.passManagerService.client
     loginViewControllerWithProvider:@"facebook"
     completion:^(MSUser *user, NSError *error) {
         
         if (error) {
             NSLog(@"Authentication Error: %@", error);
             // error.code == -1503 indicates that the user cancelled the dialog
         } else {
             // no error, so load the data
             [self.passManagerService refreshDataOnSuccess:^{
                 [self.tableView reloadData];
             }];
         }
         
         [self dismissViewControllerAnimated:YES completion:nil];
     }];
    
    [self presentViewController:controller animated:YES completion:nil];
}


#pragma mark * UITableView methods

//Actions to delete an entry
- (void) tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
 forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Find item that was commited for editing (completed)
    NSDictionary *item = [self.passManagerService.items objectAtIndex:indexPath.row];
    
    // Change the appearance to look greyed out until we remove the item
    UILabel *label = (UILabel *)[[tableView cellForRowAtIndexPath:indexPath] viewWithTag:1];
    label.textColor = [UIColor grayColor];
    
    // Ask the passManagerService to set the item's delete value to YES, and remove the row if successful
    [self.passManagerService completeItem:item completion:^(NSUInteger index) {
        
        // Remove the row from the UITableView
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [self.tableView deleteRowsAtIndexPaths:@[ indexPath ]
                              withRowAnimation:UITableViewRowAnimationTop];
    }];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Find the item that is about to be deleted
    NSDictionary *item = [self.passManagerService.items objectAtIndex:indexPath.row];
    
    // If the item is complete, then this is just pending upload. Deletion is not allowed
    if ([[item objectForKey:@"deleted"] boolValue]) {
        return UITableViewCellEditingStyleNone;
    }
    // Otherwise, allow the delete button to appear
    return UITableViewCellEditingStyleDelete;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Customize the Delete button to say "delete"
    return @"delete";
}

//Setting every login entry to it's cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set the label on the cell
    UILabel *label = (UILabel *)[cell viewWithTag:1];
    label.textColor = [UIColor blackColor];
    NSDictionary *item = [self.passManagerService.items objectAtIndex:indexPath.row];
    label.text = [item objectForKey:@"text"];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Initialize the detail view controller and display it.
    self.viewLoginViewController.detailItem=[self.passManagerService.items objectAtIndex:indexPath.row];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //segue preparation
    self.viewLoginViewController=segue.destinationViewController;
}

//Action to perfom when selecting an entry
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    [self tableView:tableView didSelectRowAtIndexPath:indexPath];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Always a single section
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of items in the passManagerService items array
    return [self.passManagerService.items count];
}
-(void)refreshView:(UIRefreshControl *)refresh {
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing data..."];
    //What to do if no user has logged in
    [self checkForLoginAndRefresh];    
    [refresh endRefreshing];
}

#pragma mark * UITextFieldDelegate methods

//Resign keyboard on return 
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
