

#import "NavTableCell.h"
#import "NavColumn.h"
#import "NavTheme.h"
#import "NSCell+extra.h"

@implementation NavTableCell

- (id)init
{
    self = [super init];
    self.leftMarginRatio = 0.5;
    return self;
}


- (void)setupMenu
{
    /*
    BrowserNode *node = self.representedObject;
    
    if (node && node.actions.count)
    {
        NSMenu *menu = [[NSMenu alloc] initWithTitle:@"menu"];
        
        for (NSString *action in node.actions)
        {
            NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:action
                                                          action:NSSelectorFromString(action)
                                                   keyEquivalent:@""];
            
            [item setTarget:node];
            [menu addItem:item];
        }
        [self setMenu:menu];
    }
    */
}

/*
- (NSColor *)activeTitleColor
{
    if ([self.node respondsToSelector:@selector(activeTitleColor)])
    {
        NSColor *color = [(id)self.node activeTitleColor];
        if (color)
        {
            return color;
        }
    }
    
    return self.navColumn.themeDict.activeTitleColor;
}

- (NSColor *)textColor
{
    if (self.node.nodeParentInlines)
    {
        return [NSColor colorWithCalibratedWhite:.7 alpha:1.0];
    }
    
    if ([self isHighlighted])
    {
        return self.activeTitleColor;
    }
    else
    {
        if ([self.node respondsToSelector:@selector(textColor)])
        {
            NSColor *color = [(id)self.node textColor];
            if (color)
            {
                return color;
            }
        }
    }
    

	return [self isHighlighted] ?
        self.navColumn.themeDict.activeTitleColor :
        self.navColumn.themeDict.inactiveTitleColor;
}
*/

- (NSColor *)bgColorActive
{
    /*
    if ([self.node respondsToSelector:@selector(bgColorActive)])
    {
        NSColor *color = [(id)self.node bgColorActive];
        if (color)
        {
            return color;
        }
    }
    */

    return self.navColumn.themeDict.selectedBgColor;
}

- (NSColor *)bgColorInactive
{
    /*
    if ([self.node respondsToSelector:@selector(bgColorInactive)])
    {
        NSColor *color = [(id)self.node bgColorInactive];
        if (color)
        {
            return color;
        }
    }
    */
    
    return self.navColumn.themeDict.unselectedBgColor;
}

- (NSColor *)bgColor
{
    return [self isHighlighted] ? [self bgColorActive] : [self bgColorInactive];
}

- (NSRect)expansionFrameWithFrame:(NSRect)cellFrame inView:(NSView *)view
{
    return NSZeroRect; // to remove tool tip
}

/*
- (NSString *)fontName
{
    if ([self isHighlighted])
    {
        return [self.navColumn.themeDict activeFontName];
    }
    
    return [NavTheme.sharedNavTheme lightFontName];
}
*/

- (NSString *)stateName
{
    if (!self.node.isRead)
    {
        return @"unread";
    }
    
    return self.isSelected ? @"selected" : @"unselected";
}

- (NSDictionary *)titleAttributes
{
    NSString *path = [NSString stringWithFormat:@"item/%@/title", self.stateName];
    return [NavTheme.sharedNavTheme attributesDictForPath:path];
}

- (NSDictionary *)subtitleAttributes
{
    NSString *path = [NSString stringWithFormat:@"item/%@/subtitle", self.stateName];
    return [NavTheme.sharedNavTheme attributesDictForPath:path];
}

- (NSDictionary *)noteAttributes
{
    NSString *path = [NSString stringWithFormat:@"item/%@/note", self.stateName];
    return [NavTheme.sharedNavTheme attributesDictForPath:path];
}

- (NSImage *)icon
{
    NSString *stateName = @"inactive";
    
    if (self.isSelected)
    {
        stateName = @"active";
    }
    
    return [self.node nodeIconForState:stateName];
}

- (CGFloat)indent
{
    if (self.node.nodeShouldIndent)
    {
        return 60.0;
    }
    
    return 20; // cellFrame.size.height * self.leftMarginRatio
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
    NSRect f = cellFrame;
    f.size.width = controlView.frame.size.width;
    
    [[self bgColor] set];
    NSRectFill(f);
    
    NSString *title = [self.node nodeTitle];
    NSString *subtitle = [self.node nodeSubtitle];
    
    CGFloat leftMargin = self.indent;

    NSImage *icon = nil; //[self icon];
    
    // yeah, this is a mess
    
    if (icon)
    {
        CGPoint center = CGPointMake((f.origin.x + (f.size.width / 2)),
                                     (f.origin.y + (f.size.height / 2)));

        CGFloat w = icon.size.width;
        CGFloat h = icon.size.height;
        
        //NSRect r = NSMakeRect(center.x/2 - w/2, center.y/2 -h/2, w, h);
        NSRect r = NSMakeRect(center.x - w/2, center.y -h/2 , w, h);
        
        [icon drawInRect:r];
        return;
    }
    
    BOOL hasNote = [self.node respondsToSelector:@selector(nodeNote)] && self.node.nodeNote;
        
    
    if (!subtitle)
    {
        NSDictionary *titleAttributes = self.titleAttributes;
        CGFloat fontSize = [(NSFont *)[titleAttributes objectForKey:NSFontAttributeName] pointSize];
        
        [title drawAtPoint:NSMakePoint(cellFrame.origin.x+leftMargin,
                                      cellFrame.origin.y + cellFrame.size.height/2.0 - fontSize/2.0 - 5)
            withAttributes:titleAttributes];
    }
    else
    {
        NSDictionary *titleAttributes = self.titleAttributes;
        CGFloat fontSize = [(NSFont *)[titleAttributes objectForKey:NSFontAttributeName] pointSize];

        CGFloat maxTitleWidth = hasNote ? f.size.width*.6 : f.size.width - 20.0 - leftMargin;
        
        title = [self string:title
              clippedToWidth:maxTitleWidth
               forAttributes:titleAttributes];
        
        [title drawAtPoint:NSMakePoint(cellFrame.origin.x + leftMargin,
                                      cellFrame.origin.y + cellFrame.size.height*.2 - fontSize/2.0 /*- 5*/)
           withAttributes:titleAttributes];
        
        NSDictionary *subtitleAttributes = self.subtitleAttributes;
        CGFloat subtitleFontSize = [(NSFont *)[subtitleAttributes objectForKey:NSFontAttributeName] pointSize];
        
        CGFloat maxSubtitleWidth = hasNote ? f.size.width*.7 : f.size.width - 10.0;
        
        subtitle = [self string:subtitle
              clippedToWidth:maxSubtitleWidth
               forAttributes:titleAttributes];
        
        [subtitle drawAtPoint:NSMakePoint(cellFrame.origin.x + leftMargin,
                                       cellFrame.origin.y + cellFrame.size.height*.6 - subtitleFontSize/2.0 /*- 5*/)
            withAttributes:subtitleAttributes];
    }
    
    if ([self.node respondsToSelector:@selector(nodeNote)])
    {
        NSString *note = [self.node nodeNote];
        if (note)
        {
            CGFloat rightMargin = 20;
            NSDictionary *noteAttributes = self.noteAttributes;
            CGFloat fontSize = [(NSFont *)[noteAttributes objectForKey:NSFontAttributeName] pointSize];
            
            CGFloat width = [[[NSAttributedString alloc] initWithString:note attributes:noteAttributes] size].width;

            
            [note drawAtPoint:NSMakePoint(cellFrame.origin.x + f.size.width - width - rightMargin,
                                           cellFrame.origin.y + cellFrame.size.height*.5 - fontSize/2.0 - 4)
                withAttributes:noteAttributes];
        }
    }

    [[NSColor colorWithCalibratedWhite:.3 alpha:1.0] set];

    /*
    if (self.isSelected)
    {
        [NSGraphicsContext saveGraphicsState];
        NSBezierPath* clipPath = [NSBezierPath bezierPath];
        [clipPath appendBezierPathWithRect:cellFrame];
        [clipPath addClip];
       
        [self drawHorizontalLineAtY:0 inRect:cellFrame];
        [self drawHorizontalLineAtY:cellFrame.size.height inRect:cellFrame];

        //[self drawVerticalLineAtX:0 inRect:cellFrame];
        //[self drawVerticalLineAtX:cellFrame.size.width inRect:cellFrame];
        
        [NSGraphicsContext restoreGraphicsState];
    }
    */
    
    /*
    [self drawVerticalLineAtX:0 inRect:cellFrame];
    [self drawVerticalLineAtX:cellFrame.size.width inRect:cellFrame];
    */

}

- (NSString *)string:(NSString *)s
     clippedToWidth:(CGFloat)maxWidth
      forAttributes:(NSDictionary *)att
{
    NSUInteger fullLength = [s length];
    
    // start from the max length and shorten until it fits
    // switch to binary search and caching later
    
    if ([s hasPrefix:@"Used "])
    {
        NSLog(@"test");
    }
    
    while ([s length])
    {
        CGFloat width = [[[NSAttributedString alloc] initWithString:s attributes:att] size].width;
        int lastCharacter = [s characterAtIndex:s.length-1];
        BOOL lastCharacterIsSpace = (lastCharacter == 32);
        
        if (width < maxWidth && !lastCharacterIsSpace)
        {
            if ([s length] < fullLength)
            {
                s = [s stringByAppendingString:@"..."];
            }
            
            return s;
        }
        
        s = [s substringToIndex:[s length] -1];
    }
           
    return @"";
}

// --- mouse down ---

/*
- (BOOL)trackMouse:(NSEvent *)theEvent inRect:(NSRect)cellFrame ofView:(NSView *)controlView untilMouseUp:(BOOL)untilMouseUp
{
    NSLog(@"NSCell trackMouse"); // why isn't this working?
    return NO;
}

- (BOOL)startTrackingAt:(NSPoint)startPoint inView:(NSView *)controlView
{
    NSLog(@"NSCell startTrackingAt"); // why isn't this working?
    return NO;
}

+ (BOOL)prefersTrackingUntilMouseUp
{
    return YES; // why isn't this working?
}
 */

@end
