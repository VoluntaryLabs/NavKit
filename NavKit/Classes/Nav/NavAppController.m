
#import "NavAppController.h"
#import "NavColumn.h"
//#import "NavView.h"

@implementation NavAppController

- (void)awakeFromNib
{
}

- (void)applicationDidFinishLaunching: (NSNotification *)aNotification
{
    self.dockTile = [[NSApplication sharedApplication] dockTile];

    self.navWindow = [NavWindow newWindow];
    [_navWindow center];
    [_navWindow orderFront:nil];
    
    [self setupProgress];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ProgressPop" object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(navTitleUpdate:)
                                                 name:@"NavTitleUpdate"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(navDockTileUpdate:)
                                                 name:@"NavDocTileUpdate"
                                               object:nil];
}

- (void)navDockTileUpdate:(NSNotification *)aNote
{
    NSNumber *number = [[aNote object] objectForKey:@"number"];
    
    if (number && [number integerValue] > 0)
    {
        [self.dockTile setBadgeLabel:[NSString stringWithFormat: @"%ld",
                                      (long)[number integerValue]]];
    }
    else
    {
        [self.dockTile setBadgeLabel:nil];
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

- (void)setupProgress
{
    // move this stuff to NavWindow
    self.progressController = [[NavProgressController alloc] init];
    [self.progressController setProgress:_navWindow.progressIndicator];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ProgressPush" object:self];
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
