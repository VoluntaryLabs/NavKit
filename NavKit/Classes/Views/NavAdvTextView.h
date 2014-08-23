//
//  NavAdvTextView.h
//
//  Created by Steve Dekorte on 4/23/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import "NavTextView.h"
#import "NavRoundRect.h"
#import "NavTheme.h"

@interface NavAdvTextView : NavTextView

@property (strong, nonatomic) NSString *editedThemePath;
@property (strong, nonatomic) NSString *uneditedTextString;
@property (strong, nonatomic) NavTextView *suffixView;
@property (assign, nonatomic) BOOL endsOnReturn;
@property (strong, nonatomic) NSString *lastString;
@property (strong, nonatomic) NavRoundRect *roundRect;
@property (assign, nonatomic) BOOL isValid;

- (void)setSuffix:(NSString *)aString;

- (void)useUneditedTextStringIfNeeded;

- (void)textShouldBeginEditing;
- (void)textDidBeginEditing;
- (void)textDidChange;
- (void)textDidEndEditing;

- (BOOL)isReady;

- (NSString *)stringSansUneditedString;

@end
