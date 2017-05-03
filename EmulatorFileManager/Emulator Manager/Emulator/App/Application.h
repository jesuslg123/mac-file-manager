//
//  Application.h
//  EmulatorFileManager
//
//  Created by Jesus Lopez Garcia on 30/04/2017.
//  Copyright © 2017 Jesus Lopez. All rights reserved.
//

#import <Foundation/Foundation.h>

@class File;

@interface Application : NSObject

@property (strong, nonatomic, nonnull) NSString *UUID;
@property (strong, nonatomic, nonnull) NSString *displayName;
@property (strong, nonatomic, nonnull) NSString *bundleIdentifier;
@property (strong, nonatomic, nonnull) NSString *version;
@property (strong, nonatomic, nonnull) NSString *build;
@property (strong, nonatomic, nonnull) NSString *path;
@property (strong, nonatomic, nonnull) NSString *pathSandbox;
@property (strong, nonatomic, nonnull) NSDate *modifed;

- (instancetype __nullable)initWithApplicationPlist:(NSDictionary *__nonnull)aDictionary file:(File *__nonnull)aFile;

@end


/*
 
 {
 BuildMachineOSBuild = 16C68;
 CFBundleDevelopmentRegion = en;
 CFBundleExecutable = CustomVideo;
 CFBundleIdentifier = "tiendeo.CustomVideo";
 CFBundleInfoDictionaryVersion = "6.0";
 CFBundleName = CustomVideo;
 CFBundlePackageType = APPL;
 CFBundleShortVersionString = "1.0";
 CFBundleSignature = "????";
 CFBundleSupportedPlatforms =     (
 iPhoneSimulator
 );
 CFBundleVersion = 1;
 DTCompiler = "com.apple.compilers.llvm.clang.1_0";
 DTPlatformBuild = "";
 DTPlatformName = iphonesimulator;
 DTPlatformVersion = "10.2";
 DTSDKBuild = 14C89;
 DTSDKName = "iphonesimulator10.2";
 DTXcode = 0821;
 DTXcodeBuild = 8C1002;
 LSRequiresIPhoneOS = 1;
 MinimumOSVersion = "7.0";
 UIDeviceFamily =     (
 1,
 2
 );
 UILaunchStoryboardName = LaunchScreen;
 UIMainStoryboardFile = Main;
 UIRequiredDeviceCapabilities =     (
 armv7
 );
 UISupportedInterfaceOrientations =     (
 UIInterfaceOrientationPortrait,
 UIInterfaceOrientationLandscapeLeft,
 UIInterfaceOrientationLandscapeRight
 );
 "UISupportedInterfaceOrientations~ipad" =     (
 UIInterfaceOrientationPortrait,
 UIInterfaceOrientationPortraitUpsideDown,
 UIInterfaceOrientationLandscapeLeft,
 UIInterfaceOrientationLandscapeRight
 );
 }
 
 */
