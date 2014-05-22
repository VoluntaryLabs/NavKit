//
//  NavColumn.h
//  Bitmarket
//
//  Created by Steve Dekorte on 2/5/14.
//  Copyright (c) 2014 Bitmarkets.org. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NavView.h"
#import "NavColoredView.h"
#import "NavSearchField.h"
#import "NavTableView.h"

@interface NavColumn : NSView <NSTableViewDataSource, NSTableViewDelegate, NavSearchFieldDelegate>

@property (assign, nonatomic) NavView *navView;
@property (strong, nonatomic) NavNode * node;
@property (strong, nonatomic) NavSearchField *searchField;

@property (strong, nonatomic) NSScrollView *scrollView;
@property (strong, nonatomic) NavTableView *tableView;
@property (strong, nonatomic) NSTableColumn *tableColumn;
@property (strong, nonatomic) NavColoredView *documentView; // view within scrollview containing headerView and tableView

@property (strong, nonatomic) NavColoredView *headerView; // top of document view

@property (strong, nonatomic) NSView *contentView; // replaces scrollview

@property (strong, nonatomic) NSView *actionStrip;
@property (assign, nonatomic) BOOL isUpdating;
@property (assign, nonatomic) CGFloat actionStripHeight;

@property (strong, nonatomic) NavNode * lastSelectedChild;

@property (assign, nonatomic) BOOL isInlined;

- (void)didAddToNavView;
- (void)prepareToDisplay;
- (NavThemeDictionary  *)themeDict;

- (NavNode *)selectedNode;
- (NSInteger)columnIndex;

- (void)selectRowIndex:(NSInteger)rowIndex;
- (void)justSelectNode:(id)aNode;

- (void)setupHeaderView:(NSView *)aView;
- (void)setContentView:(NSView *)aView;

- (BOOL)selectItemNamed:(NSString *)aName;

- (void)searchForString:(NSString *)aString;

- (void)selectFirstResponder;

@end
