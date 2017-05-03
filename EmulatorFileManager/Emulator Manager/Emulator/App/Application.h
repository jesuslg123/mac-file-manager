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

@property (strong, nonatomic, nonnull) NSString *displayName;
@property (strong, nonatomic, nonnull) NSString *bundleIdentifier;
@property (strong, nonatomic, nonnull) NSString *version;
@property (strong, nonatomic, nonnull) NSString *build;
@property (strong, nonatomic, nonnull) NSString *path;
@property (strong, nonatomic, nonnull) NSString *pathSandbox;
@property (strong, nonatomic, nonnull) NSDate *modifed;

- (instancetype __nullable)initWithApplicationPlist:(NSDictionary *__nonnull)aDictionary file:(File *__nonnull)aFile;

@end

