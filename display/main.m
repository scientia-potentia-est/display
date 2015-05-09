//
//  main.m
//  display
//
//  Created by Nikola Tesla on 11/1/14.
//  Copyright (c) 2014 Novemcinctus. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"



int main(int argc, const char * argv[]) {
    AppDelegate *delegate = [[AppDelegate alloc] init];
    [[NSApplication sharedApplication] setDelegate:delegate];
    
    [NSApp run];
    
}
