#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import <Foundation/Foundation.h>


#pragma mark * Block Definitions


typedef void (^CompletionBlock) ();
typedef void (^CompletionWithIndexBlock) (NSUInteger index);
typedef void (^BusyUpdateBlock) (BOOL busy);


#pragma mark * PassManagerService public interface


@interface PassManagerService : NSObject<MSFilter>
//An array for storing logins
@property (nonatomic, strong)   NSArray *items;
//The user that connects the app
@property (nonatomic, strong)   MSClient *client;
//Property for when being busy excecuting a command
@property (nonatomic, copy)     BusyUpdateBlock busyUpdate;

//Refresh the data from the Cloud
- (void) refreshDataOnSuccess:(CompletionBlock) completion;

//Add an item to the Cloud items
- (void) addItem:(NSDictionary *) item
      completion:(CompletionWithIndexBlock) completion;

//Delete the selected login
- (void) completeItem: (NSDictionary *) item
           completion:(CompletionWithIndexBlock) completion;

- (void) handleRequest:(NSURLRequest *)request
                onNext:(MSFilterNextBlock)onNext
            onResponse:(MSFilterResponseBlock)onResponse;

@end
