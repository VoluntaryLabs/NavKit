#import <Cocoa/Cocoa.h>
#import "NavWindow.h"
#import "NavProgressController.h"

@interface NavAppController : NSObject <NSApplicationDelegate>

@property (strong, nonatomic) id <NavNode> rootNode;
@property (strong, nonatomic) NavWindow *navWindow;
@property (strong, nonatomic) NavProgressController *progressController;
@property (strong, nonatomic) NSDockTile *dockTile;

- (void)applicationDidFinishLaunching: (NSNotification *)aNote;

- (void)setNavTitle:(NSString *)aTitle;

- (IBAction)openInfoPanel:(id)sender; // opens the root About item if present

@end
