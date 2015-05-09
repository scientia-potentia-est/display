//
//  App.m
//  display
//
//  Created by James Pickering on 11/2/14.
//  Copyright (c) 2014 Novemcinctus. All rights reserved.
//

#import "App.h"

@implementation App

CGEventRef myCGEventCallback(CGEventTapProxy proxy, CGEventType type, CGEventRef event, void *refcon) {
    
    if (CGEventGetIntegerValueField(event, kCGKeyboardEventKeycode) == 0x0B) {
        [[NSApplication sharedApplication] terminate:nil];
    }
    
    return nil;
}

+ (void)disableUserInteraction {
    
    SetSystemUIMode(kUIModeAllHidden, kUIOptionDisableProcessSwitch | kUIOptionDisableForceQuit | kUIOptionDisableSessionTerminate | kUIOptionDisableHide);
    
    CFRunLoopSourceRef runLoopSource;
    
    CFMachPortRef eventTap = CGEventTapCreate(kCGSessionEventTap, kCGHeadInsertEventTap, kCGEventTapOptionDefault, kCGEventMaskForAllEvents, myCGEventCallback, NULL);
    
    if (!eventTap) {
        NSLog(@"Couldn't create event tap!");
        exit(1);
    }
    
    runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0);
    
    CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, kCFRunLoopCommonModes);
    
    CGEventTapEnable(eventTap, true);
}

+ (void)disableSleep {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:[App class] selector:@selector(wake) userInfo:nil repeats:YES];
    [timer fire];
}

+ (void)wake {
    UpdateSystemActivity(OverallAct);
}

@end
