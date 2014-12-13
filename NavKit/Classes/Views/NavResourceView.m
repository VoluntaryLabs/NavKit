//
//  NavResourceView.m
//  Bitmarket
//
//  Created by Steve Dekorte on 2/5/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import "NavResourceView.h"
#import <BitMessageKit/BitMessageKit.h>
#import <NavKit/NavKit.h>

@implementation NavResourceView

- (id)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    [self setThemePath:@"message/body"];
    [self setAutoresizesSubviews:YES];
    [self setAutoresizingMask:NSViewHeightSizable | NSViewWidthSizable];
    [self setupBody];
    return self;
}

- (void)dealloc
{
    //NSLog(@"dealloc BMMessageView %p", (__bridge void *)self);
}

/*
- (NSString *)fontName
{
    return [NavTheme.sharedNavTheme lightFontName];
}
*/

- (NSDictionary *)bodyAttributes
{
    NSDictionary *themeDict = [NavTheme.sharedNavTheme attributesDictForPath:@"message/body"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:themeDict];
    //[dict setObject:self.dynamicBackgroundColor forKey:NSBackgroundColorAttributeName];
    return dict;
}

/*
- (NSDictionary *)linkAttributes
{
    return [NavTheme.sharedNavTheme attributesDictForPath:@"message/link"];
}

- (NSMutableAttributedString *)linkForAddress:(NSString *)address
{
    NSMutableDictionary *att = [NSMutableDictionary dictionaryWithDictionary:[self infoAttributes]];
    
    if ([address hasPrefix:@"BM-"])
    {
        att = [NSMutableDictionary dictionaryWithDictionary:[self linkAttributes]];
        [att setObject:[NSString stringWithFormat:@"BitmessageAddContact://%@", address] forKey:NSLinkAttributeName];
    }
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]
                                                initWithString:address
                                                attributes:att];

    return string;
}
*/

- (NSString *)nodeContentString
{
    if ([self.node respondsToSelector:@selector(nodeContentString)])
    {
        NSString *s = [(id)self.node nodeContentString];
        
        if (s)
        {
            return s;
        }
    }
    
    return @"";
}

- (NSAttributedString *)attributedBodyString
{
    NSMutableParagraphStyle *indented = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    
    [indented setAlignment:NSLeftTextAlignment];
    [indented setLineSpacing:1.0];
    [indented setParagraphSpacing:1.0];
    [indented setHeadIndent:0.0];
    [indented setTailIndent:0.0];
    //[indented setFirstLineHeadIndent:45.0];
    [indented setLineBreakMode:NSLineBreakByWordWrapping];
    
    NSMutableAttributedString *fullMessage = [[NSMutableAttributedString alloc] initWithString:@""];
    //NSString *rawString = [NSString stringWithFormat:@"%@\n\n", self.nodeContentString];
    NSMutableAttributedString *infoString = [[NSMutableAttributedString alloc]
                                                initWithString:self.nodeContentString
                                                attributes:self.bodyAttributes];

    [fullMessage appendAttributedString:infoString];

    return fullMessage;
}

- (void)setNode:(NavNode *)node
{
    if (_node != node)
    {
        _node = node;
        
        //[self.textView setString:message.messageString];
        //[self.textView setFont:nil];
        
        [self.textView setRichText:YES];
        [self.textView setEditable:NO];
        [self.textView setString:@""];
        [self.textView.textStorage setAttributedString:[self attributedBodyString]];
        [self.textView setWidth:self.frame.size.width];
        

        [[self.scrollView contentView] scrollToPoint:NSMakePoint (0, 0)];
        [self.scrollView reflectScrolledClipView: [self.scrollView contentView]];
    }
    
    [self configBody];
}

- (void)setNavView:(id)navView
{
    _navView = navView;
    self.backgroundColor = self.dynamicBackgroundColor;
}

- (NSColor *)dynamicBackgroundColor
{
    NavColumn *column = [self.navView columnForNode:_node];
    NavThemeDictionary  *theme = [NavTheme.sharedNavTheme themeForColumn:column.columnIndex - 1];
    return[theme selectedBgColor];
}

- (void)setupBody
{
    NSRect f = self.frame;
    
    self.scrollView = [[NavResizingScrollView alloc] initWithFrame:f];
    [self addSubview:self.scrollView];
    [self.scrollView setHasVerticalScroller:YES];
    [self.scrollView setHasHorizontalRuler:NO];
    [self.scrollView setHorizontalScrollElasticity:NSScrollElasticityNone];
    [self.scrollView setAutoresizesSubviews:YES];
    [self.scrollView setAutoresizingMask:NSViewHeightSizable | NSViewWidthSizable];
    
    self.textView = [[NavMarginTextView alloc] initWithFrame:self.scrollView.bounds];
    [self.scrollView setDocumentView:self.textView];
    [self.textView setDelegate:self];
    
    [self configBody];
}

- (void)configBody
{
    [self.textView setThemePath:@"message/background"];
    //[self.textView setLinkTextAttributes:[self linkAttributes]];
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    [self.textView.backgroundColor set];
    NSRectFill(dirtyRect);
}

- (NSString *)selectedContent
{
    return [[self.textView string]
            substringWithRange:[self.textView selectedRange]];
}

- (void)prepareToDisplay
{
    
}


@end

