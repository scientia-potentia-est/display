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

}

+ (void) pauseApps {
    NSArray *toPause = @[@"loginwindow", @"Dock", @"com.apple.internetaccounts", @"ARDAgent", @"SystemUIServer", @"CoreServicesUIAgent", @"Finder", @"com.apple.dock.extra", @"AirPlayUIAgent", @"Spotlight", @"iTunes Helper", @"Notification Center", @"sharingd", @"com.apple.dock.extra", @"LaterAgent"];
    NSArray *apps = [[NSWorkspace sharedWorkspace] runningApplications];
    for (NSRunningApplication *app in apps) {
        if ([app processIdentifier] != getpid() && [toPause containsObject:[app localizedName]]){
            NSLog(@"Killing %@:\t%d", [app localizedName], kill([app processIdentifier], SIGSTOP));
//            kill([app processIdentifier], SIGSTOP);
        }
    }
}
@end
