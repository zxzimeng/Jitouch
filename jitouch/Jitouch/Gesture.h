//
//  Gesture.h
//  Jitouch
//
//  Copyright 2021 Supasorn Suwajanakorn and Sukolsak Sakshuwong. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Gesture : NSObject

- (id)init;

- (void)reload;

@end

void turnOffGestures(void);
