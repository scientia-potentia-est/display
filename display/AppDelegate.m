//
//  AppDelegate.m
//  display
//
//  Created by Nikola Tesla on 11/1/14.
//  Copyright (c) 2014 Novemcinctus. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (strong) MainWindow *window;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

    [[NSApplication sharedApplication] activateIgnoringOtherApps : YES];
    
    [App disableUserInteraction];
    [App disableSleep];
    
    
    self.window = [[MainWindow alloc] init];
    [self pauseApps];
}

- (void) pauseApps {
    NSArray *apps = [[NSWorkspace sharedWorkspace] runningApplications];
    for (NSRunningApplication *app in apps) {
        if ([app processIdentifier] != getpid())
            kill([app processIdentifier], SIGSTOP);
    }
}
@end
