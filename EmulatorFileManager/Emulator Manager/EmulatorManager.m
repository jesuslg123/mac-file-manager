//
//  EmulatorManager.m
//  EmulatorFileManager
//
//  Created by Jesus Lopez Garcia on 30/04/2017.
//  Copyright © 2017 Jesus Lopez. All rights reserved.
//

#import "EmulatorManager.h"
#import "Emulator.h"
#import "Application.h"
#import "FileManager.h"

#define EMULATORS_DEFAULT_PATH @"%@/Library/Developer/CoreSimulator/Devices"
#define EMULATOR_DEVICE_PLIST_FILE_NAME @"device.plist"
#define EMULATOR_APPLICATION_CONTAINER_PLIST_FILE_NAME @".com.apple.mobile_container_manager.metadata.plist"
#define EMULATOR_APPLICATION_PLIST_FILE_NAME @"Info.plist"

@interface EmulatorManager()

@property (strong, nonatomic, nonnull) NSString *emulatorsPath;

@end

@implementation EmulatorManager

- (instancetype)init {
    if (self = [super init]) {
        _emulatorsPath = EMULATORS_DEFAULT_PATH;
    }
    return self;
}

- (instancetype)initWithEmulatorsPath:(NSString *)aPath {
    if (self = [super init]) {
        _emulatorsPath = aPath;
    }
    return self;
}

- (NSArray <Emulator *> *)emulators {
    return [self generateEmulatorsList];
}

#pragma mark - Find emulators

- (NSArray <Emulator *> *)generateEmulatorsList {
    NSMutableArray *devices = [NSMutableArray new];
    
    NSString *emulatorsPath = [self getEmulatorsPathForUser:[FileManager currentHomeUserPath]];
    NSArray <File *> *appPlist = [FileManager recursiveFilesExtension:EMULATOR_DEVICE_PLIST_FILE_NAME atPath:emulatorsPath maxLevel:1];
    for (File *file  in appPlist) {
        NSDictionary *deviceProperties = [NSDictionary dictionaryWithContentsOfFile:file.fullPath];
        Emulator *emulator = [[Emulator alloc] initWithDevicePlist:deviceProperties file:file];
        [emulator setAplications:[self getEmulatorApps:emulator]];
        [devices addObject:emulator];
    }
    
    return devices.copy;
}

- (NSString *)getEmulatorsPathForUser:(NSString *)aUserPath {
    return [NSString stringWithFormat:self.emulatorsPath, aUserPath];
}

#pragma mark - Find apps emulator

- (NSArray <Application *> *)getEmulatorApps:(Emulator *)emulator {
    NSMutableArray *apps = [NSMutableArray new];
    
    NSArray <File *> *appsPlist = [FileManager recursiveFilesExtension:EMULATOR_APPLICATION_CONTAINER_PLIST_FILE_NAME atPath:emulator.path    maxLevel:NSIntegerMax];
    for (File *appFile  in appsPlist) {
        NSDictionary *appContainerProperties = [NSDictionary dictionaryWithContentsOfFile:appFile.fullPath];
        if (![self isAppleApplication:appContainerProperties]) {
            Application *application = [self getApplication:appFile.path];
            if (application != nil) {
                [apps addObject:application];
            }
        }
    }
    
    return apps.copy;
}

- (Application *)getApplication:(NSString *)aPath {
    Application *application;
    
    NSArray <File *> *appsPlist = [FileManager recursiveFilesExtension:EMULATOR_APPLICATION_PLIST_FILE_NAME atPath:aPath maxLevel:2];
    if (appsPlist.count > 0) {
        File *appPlist = [appsPlist firstObject];
        NSDictionary *appProperties = [NSDictionary dictionaryWithContentsOfFile:appPlist.fullPath];
        application = [[Application alloc] initWithApplicationPlist:appProperties file:appPlist];
    }
    
    return application;
}

- (BOOL)isAppleApplication:(NSDictionary*)applicationProperties {
    NSString* applicationBundleIdentifier = applicationProperties[@"MCMMetadataIdentifier"];
    return [applicationBundleIdentifier hasPrefix:@"com.apple"];
}

@end
