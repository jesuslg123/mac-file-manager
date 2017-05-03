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
#define SIMULATOR_SANDBOX_PATH @"%@/data/Containers/Data/Application"
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
    NSMutableArray *simulators = [NSMutableArray new];
    
    NSString *emulatorsRootPath = [self getEmulatorsRootPathForUser:[FileManager currentHomeUserPath]];
    NSArray <File *> *emulatorsPlistFile = [FileManager recursiveFilesExtension:EMULATOR_DEVICE_PLIST_FILE_NAME atPath:emulatorsRootPath maxLevel:1];
    for (File *emulatorPlistFile  in emulatorsPlistFile) {
        NSDictionary *deviceProperties = [NSDictionary dictionaryWithContentsOfFile:emulatorPlistFile.fullPath];
        Emulator *simulator = [[Emulator alloc] initWithDevicePlist:deviceProperties file:emulatorPlistFile];
        NSArray <Application *>*simulatorApps = [self getEmulatorApps:simulator];
        [simulator setAplications:simulatorApps];
        if (simulator.aplications.count > 0) {
            [simulators addObject:simulator];
        }
    }
    
    return simulators.copy;
}

- (NSString *)getEmulatorsRootPathForUser:(NSString *)aUserPath {
    return [NSString stringWithFormat:self.emulatorsPath, aUserPath];
}

#pragma mark - Find apps emulator

- (NSArray <Application *> *)getEmulatorApps:(Emulator *)emulator {
    NSMutableArray *apps = [NSMutableArray new];
    
    NSArray <File *> *appsPlist = [FileManager recursiveFilesExtension:EMULATOR_APPLICATION_CONTAINER_PLIST_FILE_NAME atPath:emulator.path maxLevel:NSIntegerMax];
    for (File *appFile  in appsPlist) {
        NSDictionary *appContainerProperties = [NSDictionary dictionaryWithContentsOfFile:appFile.fullPath];
        if (![self isAppleApplication:appContainerProperties]) {
            Application *application = [self getApplication:appFile.path forEmulator:emulator];
            if (application != nil) {
                [apps addObject:application];
            }
        }
    }
    
    return apps.copy;
}

- (Application *)getApplication:(NSString *)aPath forEmulator:(Emulator *)aEmulator {
    Application *application;
    
    NSArray <File *> *appsPlist = [FileManager recursiveFilesName:EMULATOR_APPLICATION_PLIST_FILE_NAME atPath:aPath maxLevel:2];
    if (appsPlist.count > 0) {
        File *appPlist = [appsPlist firstObject];
        NSDictionary *appProperties = [NSDictionary dictionaryWithContentsOfFile:appPlist.fullPath];
        application = [[Application alloc] initWithApplicationPlist:appProperties file:appPlist];
        
        //Add sandbox path
        File *applicationSandboxFile = [self getApplicationSandbox:application forEmulator:aEmulator];
        if (applicationSandboxFile != nil) {
            [application setPathSandbox:applicationSandboxFile.path];
        }
    }
    
    return application;
}

- (File *)getApplicationSandbox:(Application *)aApplication forEmulator:(Emulator *)aEmulator {
    NSArray <File *> *sandoxManagerFiles = [self getApplicationsSandbox:aEmulator.path];
    return [self find:sandoxManagerFiles sandboxForApp:aApplication];
}

- (NSArray <File *>*)getApplicationsSandbox:(NSString *)aSimulatorRootPath {
    NSString *simulatorSandboxsRootPath = [NSString stringWithFormat:SIMULATOR_SANDBOX_PATH, aSimulatorRootPath];
    NSArray <File *> *mobileContainerManagerFiles = [FileManager recursiveFilesExtension:@".mobile_container_manager.metadata.plist" atPath:simulatorSandboxsRootPath maxLevel:NSIntegerMax];
    return mobileContainerManagerFiles;
}

- (BOOL)isAppleApplication:(NSDictionary*)applicationProperties {
    NSString* applicationBundleIdentifier = applicationProperties[@"MCMMetadataIdentifier"];
    return [applicationBundleIdentifier hasPrefix:@"com.apple"];
}

- (File *)find:(NSArray <File *>*)files sandboxForApp:(Application *)application {
    for (File *plistFile in files) {
        NSDictionary *sandboxProperties = [NSDictionary dictionaryWithContentsOfFile:plistFile.fullPath];
        if ([sandboxProperties[@"MCMMetadataIdentifier"] isEqualToString:application.bundleIdentifier]) {
            return plistFile;
        }
    }
    return nil;
}

@end
