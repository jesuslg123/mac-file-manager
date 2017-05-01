//
//  Application.m
//  EmulatorFileManager
//
//  Created by Jesus Lopez Garcia on 30/04/2017.
//  Copyright © 2017 Jesus Lopez. All rights reserved.
//

#import "Application.h"
#import "File.h"


@implementation Application

- (instancetype)initWithApplicationPlist:(NSDictionary *)aDictionary file:(id)aFile {
    if (self =[super init]) {
        [self loadFromApplicationPlist:aDictionary file:aFile];
    }
    return self;
}

- (void)loadFromApplicationPlist:(NSDictionary *)aDictionary file:(File *)aFile {
    self.bundleIdentifier = aDictionary[@"CFBundleIdentifier"];
    self.displayName = aDictionary[@"CFBundleName"];
    self.build = aDictionary[@"CFBundleVersion"];
    self.version = aDictionary[@"CFBundleShortVersionString"];
    
    self.path = aFile.path;
    self.modifed = aFile.modified;
}

@end
