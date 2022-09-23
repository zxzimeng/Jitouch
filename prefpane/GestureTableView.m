//
//  GestureTableView.m
//  Jitouch
//
//  Copyright 2021 Supasorn Suwajanakorn and Sukolsak Sakshuwong. All rights reserved.
//

#import "GestureTableView.h"
#import "GesturePreviewView.h"
#import "MAAttachedWindow.h"

@implementation GestureTableView

@synthesize gestures, device, size;

- (void)hidePreview {
    if (attachedWindow) {
        [gesturePreviewView stopTimer];
        gesturePreviewView = nil;
        [attachedWindow orderOut:self];
        [[self window] removeChildWindow:attachedWindow];
        attachedWindow = nil;
    }
    saveRowIndex = -1;
}

- (void)showPreview:(BOOL)scroll {
    NSInteger rowIndex;

    NSPoint point = [self convertPoint:[[self window] mouseLocationOutsideOfEventStream] fromView:[[self window] contentView]];

    rowIndex = [self rowAtPoint:point];
    if (rowIndex == -1) {
        [self hidePreview];
        return;
    }
    if ([[gestures objectAtIndex:rowIndex] isEqualToString:@"All Unassigned Gestures"]) {
        [self hidePreview];
        return;
    }


    NSRect frame = [self frameOfCellAtColumn:0 row:rowIndex];

    if (saveRowIndex != rowIndex) {
        saveRowIndex = rowIndex;

        [gesturePreviewView stopTimer];
        gesturePreviewView = [[GesturePreviewView alloc] initWithDevice:device];
        [gesturePreviewView startTimer];
        [gesturePreviewView create:[gestures objectAtIndex:rowIndex] forDevice:device];


        NSPoint attachedPoint = [[[self window] contentView] convertPoint:frame.origin fromView:self];
        attachedPoint.y -= frame.size.height / 2;
        MAAttachedWindow *newAttachedWindow = [[MAAttachedWindow alloc] initWithView:gesturePreviewView
                                                                     attachedToPoint:attachedPoint
                                                                            inWindow:[self window]
                                                                              onSide:0
                                                                          atDistance:2.0];
        [newAttachedWindow setDevice:device];
        //[attachedWindow setBorderColor:[borderColorWell color]];
        //[textField setTextColor:[borderColorWell color]];
        //NSColor *color = [NSColor colorWithDeviceRed:0 green:0 blue:0 alpha:0.6];
        [newAttachedWindow setBackgroundColor:[NSColor colorWithDeviceRed:1 green:1 blue:1 alpha:0.8]];
        //[attachedWindow setViewMargin:[viewMarginSlider floatValue]];
        [newAttachedWindow setBorderWidth:0];
        //[attachedWindow setCornerRadius:[cornerRadiusSlider floatValue]];
        //[attachedWindow setHasArrow:([hasArrowCheckbox state] == NSOnState)];
        //[attachedWindow setDrawsRoundCornerBesideArrow:([drawRoundCornerBesideArrowCheckbox state] == NSOnState)];
        [newAttachedWindow setArrowBaseWidth:3 * 5];
        [newAttachedWindow setArrowHeight:2 * 5];


        [[self window] addChildWindow:newAttachedWindow ordered:NSWindowAbove];


        if (attachedWindow) {
            [[self window] removeChildWindow:attachedWindow];
            [attachedWindow orderOut:self];
            [attachedWindow release];
            //attachedWindow = nil;
        }

        attachedWindow = newAttachedWindow;

        [gesturePreviewView release];

    } else if (scroll) {
        if (attachedWindow) {
            NSPoint attachedPoint = [[[self window] contentView] convertPoint:frame.origin fromView:self];
            attachedPoint.y -= frame.size.height / 2;
            [attachedWindow setPoint:attachedPoint side:0];
        }
    }
}

- (void)mouseEntered:(NSEvent *)theEvent {
    [self showPreview:NO];
}

- (void)mouseExited:(NSEvent *)theEvent {
    [self hidePreview];
}

- (void)mouseMoved:(NSEvent *)theEvent {
    [self showPreview:NO];
}

- (void)outlineViewScrolled:(NSNotification*)notification {
    [self showPreview:YES];
}

- (void)awakeFromNib {
    [self setDataSource:self];

    size = NSMakeSize(4 * 50, 3 * 50);

    saveRowIndex = -1;
    realView = [self enclosingScrollView];

    NSRect rect = [realView frame];
    rect.origin.x = 0;
    rect.origin.y = 0;
    NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect: rect
                                                                options: (NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveAlways )
                                                                  owner:self userInfo:nil];
    [realView addTrackingArea:trackingArea];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector: @selector(outlineViewScrolled:)
                                                 name: NSViewBoundsDidChangeNotification
                                               object: [[self enclosingScrollView] contentView]];
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
    return [gestures count];
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
    return [gestures objectAtIndex:rowIndex];
}

- (NSString*)titleOfSelectedItem {
    if ([self selectedRow] == -1)
        return nil;
    return [gestures objectAtIndex:[self selectedRow]];
}

- (void)selectItemWithObjectValue:(NSString*)value {
    NSUInteger index = [gestures indexOfObject:value];
    if (index != NSNotFound)
        [self selectRowIndexes:[NSIndexSet indexSetWithIndex:index] byExtendingSelection:NO];
}

- (void)willUnselect {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSViewBoundsDidChangeNotification object:nil];
    [self hidePreview];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSViewBoundsDidChangeNotification object:nil];
    [attachedWindow release];
    [gestures release];
    [super dealloc];
}

@end
