
#import "NavAppController.h"
#import "NavColumn.h"
//#import "NavView.h"

@implementation NavAppController

- (void)awakeFromNib
{
}

- (void)applicationDidFinishLaunching: (NSNotification *)aNotification
{
    self.navWindow = [NavWindow newWindow];
    [_navWindow center];
    [_navWindow orderFront:nil];
        
    [NSNotificationCenter.defaultCenter postNotificationName:@"ProgressPop" object:self];
    
    [NSNotificationCenter.defaultCenter addObserver:self
                                             selector:@selector(navTitleUpdate:)
                                                 name:@"NavTitleUpdate"
                                               object:nil];
    
    [NSNotificationCenter.defaultCenter addObserver:self
                                             selector:@selector(navDockTileUpdate:)
                                                 name:@"NavDocTileUpdate"
                                               object:nil];
}

- (void)navDockTileUpdate:(NSNotification *)aNote
{
    NSNumber *number = [[aNote userInfo] objectForKey:@"number"];

    NSDockTile *dockTile = [[NSApplication sharedApplication] dockTile];

    if (number && [number integerValue] > 0)
    {
        [dockTile setBadgeLabel:[NSString stringWithFormat: @"%ld",
                                      (long)[number integerValue]]];
    }
    else
    {
        [dockTile setBadgeLabel:nil];
    }
}

- (void)setNavTitle:(NSString *)aTitle
{
    [_navWindow setTitle:aTitle];
    [_navWindow display];
}

- (void)navTitleUpdate:(NSNotification *)aNote
{
    NSString *title = [[aNote object] objectForKey:@"title"];
    
    if (title)
    {
        [self setNavTitle:title];
    }
}

- (NavColumn *)firstNavColumn
{
    return [[_navWindow.navView navColumns] firstObject];
}

- (void)setRootNode:(NavNode *)aNode
{
    _rootNode = aNode;
    
    [_navWindow.navView setRootNode:_rootNode];
    [self.firstNavColumn selectRowIndex:0];
    [_navWindow display];
}

- (IBAction)openInfoPanel:(id)sender
{
    [self.firstNavColumn selectItemNamed:@"About"];
}

/*
- (BOOL)application:(NSApplication *)theApplication openFile:(NSString *)filename
{
    NSLog(@"open '%@'", filename);
    return YES;
}

- (void)application:(NSApplication *)sender openFiles:(NSArray *)filenames
{
    NSLog(@"open filenames");
}
*/

@end
