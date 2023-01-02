//
//  main.m
//  Jitouch
//
//  Copyright 2021 Supasorn Suwajanakorn and Sukolsak Sakshuwong. All rights reserved.
//  Modified work Copyright 2021 Aaron Kollasch. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "signal.h"
#include "JitouchAppDelegate.h"

int main(int argc, const char * argv[])
{
    // Trap SIGHUP and do reload
    // see https://stackoverflow.com/questions/50225548/trap-sigint-in-cocoa-macos-application
    // see https://www.mikeash.com/pyblog/friday-qa-2011-04-01-signal-handling.html
    // see https://fossies.org/linux/HandBrake/macosx/main.m
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_SIGNAL, SIGHUP, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_event_handler(source, ^{
        NSLog(@"Received SIGHUP.");
        dispatch_async(dispatch_get_main_queue(), ^{
            [((JitouchAppDelegate*)[NSApp delegate]) reload];
        });
    });
    dispatch_resume(source);

    // Ignore the SIGHUP signal because we handle it.
    // To debug SIGHUP in Xcode, add an "ignoreSIGHUP" breakpoint at this line, before `signal()`.
    // set the breakpoint action to `process handle SIGHUP -n true -p true -s false`
    // set the breakpoint to automatically continue after evaluating actions.
    signal(SIGHUP, SIG_IGN);

    return NSApplicationMain(argc, argv);
}
