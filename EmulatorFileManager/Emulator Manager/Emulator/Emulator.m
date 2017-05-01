//
//  Emulator.m
//  EmulatorFileManager
//
//  Created by Jesus Lopez Garcia on 30/04/2017.
//  Copyright © 2017 Jesus Lopez. All rights reserved.
//

#import "Emulator.h"
#import "File.h"

@implementation Emulator

- (instancetype)initWithDevicePlist:(NSDictionary *)aDictionary file:(File *)aFile {
    if (self = [super init]) {
        [self loadFromDevicePlist:aDictionary file:aFile];
    }
    return self;
}

#pragma mark - Load data

- (void)loadFromDevicePlist:(NSDictionary *)aDictionary file:(File *)aFile {
    self.UDID = aDictionary[@"UDID"];
    self.deviceName = aDictionary[@"name"];
    self.OSType = [self osTypeFromRunTime:aDictionary[@"runtime"]]; //com.apple.CoreSimulator.SimRuntime.watchOS-3-2
    self.OSVersion = [self osVersionFromRunTime:aDictionary[@"runtime"]]; //com.apple.CoreSimulator.SimRuntime.watchOS-3-2
    
    self.path = aFile.path;
    self.modifed = aFile.modified;
}

#pragma mark - String data process

- (NSString *)osTypeFromRunTime:(NSString *)aRunTime {
    NSArray *parts = [aRunTime componentsSeparatedByString:@"."];
    NSString *typeVersionString = [parts lastObject];
    
    return [[typeVersionString componentsSeparatedByString:@"-"] firstObject];
}

- (NSString *)osVersionFromRunTime:(NSString *)aRunTime {
    NSArray *runTimeParts = [aRunTime componentsSeparatedByString:@"."];
    NSString *typeVersionString = [runTimeParts lastObject];
    
    NSMutableArray *typeVersionParts = [NSMutableArray arrayWithArray:[typeVersionString componentsSeparatedByString:@"-"]];
    [typeVersionParts removeObjectAtIndex:0];
    
    NSString *version = [typeVersionParts componentsJoinedByString:@"."];
    
    return version;
}

#pragma mark - Applications

@end
