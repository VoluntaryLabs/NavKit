//
//  Theme.m
//  Bitmarket
//
//  Created by Steve Dekorte on 2/7/14.
//  Copyright (c) 2014 Bitmarkets.org. All rights reserved.
//

#import "NavTheme.h"
#import "NSColor+array.h"
#import <FoundationCategoriesKit/FoundationCategoriesKit.h>

@implementation NavTheme

static NavTheme *sharedNavTheme = nil;

+ (NavTheme *)sharedNavTheme
{
    if (!sharedNavTheme)
    {
        sharedNavTheme = [[[self class] alloc] init];
    }
    
    return sharedNavTheme;
}

- (id)init
{
    self = [super init];
    self.dict = [NSMutableDictionary dictionary];
    [self load];
    return self;
}

- (void)load
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"themes" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    NSError *error;
    
    id jsonObject = [NSJSONSerialization
                 JSONObjectWithData:jsonData
                 options:0
                 error:&error];
    
    self.themeDicts = jsonObject;
    
    if (error)
    {
        NSLog(@"JSON Parse Error: %@", [[error userInfo] objectForKey:@"NSDebugDescription"]);
        [NSException raise:@"JSON Parse Error" format:@""];
    }
    
    //NSLog(@"themeDicts: %@", self.themeDicts);
}

- (NSDictionary *)currentNavTheme
{
    return [self.themeDicts objectForKey:@"default"];
}

- (id)objectForKey:(NSString *)k
{
    return [self.currentNavTheme objectForKey:k];
}

- (NSColor *)colorForKey:(NSString *)k
{
    id value = [self.currentNavTheme objectForKey:k];
    return [NSColor colorWithObject:value];
}

+ (id)objectForKey:(NSString *)k
{
    return [self.sharedNavTheme objectForKey:k];
}

// --- column themes ---------------------------

- (NavThemeDictionary  *)themeForColumn:(NSInteger)columnIndex
{
    NSArray *columnThemes = [self.currentNavTheme objectForKey:@"columns"];
    NSDictionary *dict = columnThemes.lastObject;
    
    if (columnIndex < columnThemes.count)
    {
        dict = [columnThemes objectAtIndex:columnIndex];
    }
    
    return [NavThemeDictionary  withDict:dict];
}

// helpers


- (NSColor *)formBackgroundColor
{
    return [self colorForKey:@"formBackgroundColor"];
}

- (NSColor *)formText1Color
{
    return [self colorForKey:@"formText1Color"];
}

- (NSColor *)formText2Color
{
    return [self colorForKey:@"formText2Color"];
}

- (NSColor *)formText3Color
{
    return [self colorForKey:@"formText3Color"];
}

- (NSColor *)formText4Color
{
    return [self colorForKey:@"formText4Color"];
}

- (NSColor *)formTextErrorColor
{
    return [self colorForKey:@"formTextErrorColor"];
}

- (NSColor *)formTextSelectedBgColor
{
    return [self colorForKey:@"formTextSelectedBgColor"];
}

- (NSColor *)formTextCursorColor
{
    return [self colorForKey:@"formTextCursorColor"];
}

- (NSColor *)formTextLinkColor
{
    return [self colorForKey:@"formTextLinkColor"];
}

// font

- (NSString *)lightFontName
{
    return [self.currentNavTheme objectForKey:@"lightFontName"];
}

- (NSString *)mediumFontName
{
    return [self.currentNavTheme objectForKey:@"mediumFontName"];
}

// forward

/*
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
    
    if (!signature)
    {
        signature = [super methodSignatureForSelector:@selector(init)];
    }
    
    return signature;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    NSString *propertyName = NSStringFromSelector(aSelector);
    //return [self.currentNavTheme objectForKey:propertyName] != nil;
    return YES;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSString *propertyName = NSStringFromSelector([anInvocation selector]);
    id result = nil;
    
    if ([propertyName hasSuffix:@"Color"])
    {
        result = [self colorForKey:propertyName]];
    }
    else
    {
        result = [self.currentNavTheme objectForKey:propertyName];
    }
    
    if (result == nil)
    {
        NSLog(@"nil result");
    }
    
    [anInvocation setReturnValue:(void *)result];
    [anInvocation retainArguments];
}
*/

// paths

- (id)objectForPath:(NSString *)path
{
    id value = [self.currentNavTheme objectForPath:path];
    return value;
}

- (NSColor *)colorForPath:(NSString *)path
{
    return [NSColor colorWithObject:[self objectForPath:path]];
}

- (NSDictionary *)attributesDictForPath:(NSString *)path // e,g, "item/selected"
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    NSDictionary *dict = [self objectForPath:path];

    // color
    
    id colorValue = [dict objectForKey:@"color"];
    if (colorValue)
    {
        NSColor *color = [NSColor colorWithObject:colorValue];
        [attributes setObject:color forKey:NSForegroundColorAttributeName];
    }
    
    // font
    
    NSString *fontName = [dict objectForKey:@"fontName"];
    NSNumber *fontSize = [dict objectForKey:@"fontSize"];
    if (fontName && fontSize)
    {
        NSFont *font = [NSFont fontWithName:fontName size:fontSize.floatValue];
        [attributes setObject:font forKey:NSFontAttributeName];
    }
    
    // background
    
    NSDictionary *bgDict = [dict objectForKey:@"backgroundColor"];
    if (bgDict)
    {
        NSColor *bgColor = [NSColor colorWithObject:bgDict];
        [attributes setObject:bgColor forKey:NSBackgroundColorAttributeName];
    }
    
    NSString *underline = [dict objectForKey:@"text-decoration"];
    if (underline && [underline isEqualToString:@"none"])
    {
        [attributes setObject:[NSNumber numberWithInt:NSUnderlineStyleNone]
                       forKey:NSUnderlineStyleAttributeName];
    }
    
    
    NSMutableParagraphStyle *alignStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [alignStyle setAlignment:[self alignmentForPath:path]];
    
    [attributes setObject:alignStyle
                   forKey:NSParagraphStyleAttributeName];
    
    return attributes;
}

- (BOOL)hasAlignmentForPath:(NSString *)path
{
    NSDictionary *dict = [self objectForPath:path];
    return [dict objectForKey:@"align"] != nil;
}

- (NSTextAlignment)alignmentForPath:(NSString *)path // e,g, "item/selected"
{
    NSDictionary *dict = [self objectForPath:path];
    NSString *alignment = [dict objectForKey:@"align"];
    
    if ([alignment isEqualToString:@"center"])
    {
        return NSCenterTextAlignment;
    }
    
    if ([alignment isEqualToString:@"right"])
    {
        return NSRightTextAlignment;
    }

    /*
    if ([alignment isEqualToString:@"left"])
    {
        return NSLeftTextAlignment;
    }
    */
    
    return NSLeftTextAlignment;
}

@end


@implementation NSView (theme)

- (void)setSelectedThemePath:(NSString *)aPath
{
    NSDictionary *attributes = [NavTheme.sharedNavTheme attributesDictForPath:aPath];

    if (!self.window)
    {
        NSLog(@"warning no window yet to set selection color");
        //[NSException raise:@"Error" format:@"no window set yet"];
    }
    
    NSTextView *tv = (NSTextView *)[self.window fieldEditor:YES forObject:self];

    [tv setSelectedTextAttributes:attributes];
}

- (void)setThemePath:(NSString *)aPath
{
    NSDictionary *attributes = [NavTheme.sharedNavTheme attributesDictForPath:aPath];
    
    NSFont *font = [attributes objectForKey:NSFontAttributeName];
    if (font && [self respondsToSelector:@selector(setFont:)])
    {
        [(id)self setFont:font];
    }
    
    NSColor *color = [attributes objectForKey:NSForegroundColorAttributeName];
    if (color && [self respondsToSelector:@selector(setTextColor:)])
    {
        [(id)self setTextColor:color];
    }
    if (color && [self respondsToSelector:@selector(setInsertionPointColor:)])
    {
        [(NSTextView *)self setInsertionPointColor:color];
    }
    
    NSColor *bgColor = [attributes objectForKey:NSBackgroundColorAttributeName];
    if (bgColor && [self respondsToSelector:@selector(setBackgroundColor:)])
    {
        [(id)self setBackgroundColor:bgColor];
    }
    else if ([self respondsToSelector:@selector(setDrawsBackground:)])
    {
        [(id)self setDrawsBackground:NO];
    }
    
    if ([self respondsToSelector:@selector(setFocusRingType:)])
    {
        [(id)self setFocusRingType:NSFocusRingTypeNone];
    }

    if ([self respondsToSelector:@selector(setAlignment:)])
    {
        [(id)self setAlignment:[NavTheme.sharedNavTheme alignmentForPath:aPath]];
    }
    

    
    [self setNeedsDisplay:YES];
}

@end

@implementation NSButton (theme)

- (void)setThemePath:(NSString *)aPath
{
    NSDictionary *attributes = [NavTheme.sharedNavTheme attributesDictForPath:aPath];
    
     NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]
         initWithString:self.title
         attributes:attributes];
    
    [self setAttributedTitle:attributedString];
    //[self setAttributedAlternateTitle:attributedString];
    
    
    NSColor *bgColor = [attributes objectForKey:NSBackgroundColorAttributeName];
    if (bgColor)
    {
        [(id)self setBackgroundColor:bgColor];
    }
    else
    {
        if ([self respondsToSelector:@selector(setDrawsBackground:)])
        {
            [(id)self setDrawsBackground:NO];
        }
        [self setBordered:NO];
    }
    
    if ([self respondsToSelector:@selector(setAlignment:)])
    {
        //[(id)self setAlignment:[NavTheme.sharedNavTheme alignmentForPath:aPath]];
    }
    
    [self setNeedsDisplay:YES];
}

@end


@implementation NSCell (Theme)

- (void)setThemePath:(NSString *)aPath
{
    NSDictionary *attributes = [NavTheme.sharedNavTheme attributesDictForPath:aPath];
    
    NSFont *font = [attributes objectForKey:NSFontAttributeName];
    if (font && [self respondsToSelector:@selector(setFont:)])
    {
        [(id)self setFont:font];
    }
    
    NSColor *color = [attributes objectForKey:NSForegroundColorAttributeName];
    if (color && [self respondsToSelector:@selector(setTextColor:)])
    {
        [(id)self setTextColor:color];
    }
    if (color && [self respondsToSelector:@selector(setInsertionPointColor:)])
    {
        [(NSTextView *)self setInsertionPointColor:color];
    }
    
    NSColor *bgColor = [attributes objectForKey:NSBackgroundColorAttributeName];
    if (bgColor && [self respondsToSelector:@selector(setBackgroundColor:)])
    {
        [(id)self setBackgroundColor:bgColor];
    }
    else if ([self respondsToSelector:@selector(setDrawsBackground:)])
    {
        [(id)self setDrawsBackground:NO];
    }
    
    if ([self respondsToSelector:@selector(setFocusRingType:)])
    {
        [(id)self setFocusRingType:NSFocusRingTypeNone];
    }
    
    if ([self respondsToSelector:@selector(setAlignment:)])
    {
        if ([NavTheme.sharedNavTheme hasAlignmentForPath:aPath])
        {
            [(id)self setAlignment:[NavTheme.sharedNavTheme alignmentForPath:aPath]];
        }
    }
}


@end

/*
@implementation NSTextView (theme)

- (void)setThemePath:(NSString *)aPath
{
    NSDictionary *attributes = [NavTheme.sharedNavTheme attributesDictForPath:aPath];
    
    [self setFont:[attributes objectForKey:NSFontAttributeName]];
    [self setTextColor:[attributes objectForKey:NSForegroundColorAttributeName]];
    
    NSColor *bgColor = [attributes objectForKey:NSBackgroundColorAttributeName];
    if (bgColor)
    {
        [self setBackgroundColor:bgColor];
    }
}

@end

@implementation NSTextField (theme)

- (void)setThemePath:(NSString *)aPath
{
    NSDictionary *attributes = [NavTheme.sharedNavTheme attributesDictForPath:aPath];
    [self setFont:[attributes objectForKey:NSFontAttributeName]];
    [self setTextColor:[attributes objectForKey:NSForegroundColorAttributeName]];
    
    NSColor *bgColor = [attributes objectForKey:NSBackgroundColorAttributeName];
    if (bgColor)
    {
        [self setBackgroundColor:bgColor];
    }
}

@end
*/
