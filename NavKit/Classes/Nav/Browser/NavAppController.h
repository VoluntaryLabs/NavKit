#import <Cocoa/Cocoa.h>
#import "NavWindow.h"

@interface NavAppController : NSObject <NSApplicationDelegate>

@property (strong, nonatomic) NavNode *rootNode;
@property (strong, nonatomic) NavWindow *navWindow;
@property (strong, nonatomic) NSView *splashView;

- (void)applicationDidFinishLaunching: (NSNotification *)aNote;

- (void)setNavTitle:(NSString *)aTitle;

- (IBAction)openInfoPanel:(id)sender; // opens the root About item if present

@end
