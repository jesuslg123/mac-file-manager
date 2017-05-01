//
//  Emulator.h
//  EmulatorFileManager
//
//  Created by Jesus Lopez Garcia on 30/04/2017.
//  Copyright © 2017 Jesus Lopez. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Application;
@class File;

@interface Emulator : NSObject

@property (strong, nonatomic, nonnull) NSString *OSType;
@property (strong, nonatomic, nonnull) NSString *OSVersion;
@property (strong, nonatomic, nonnull) NSString *deviceName;
@property (strong, nonatomic, nonnull) NSString *UDID;
@property (strong, nonatomic, nonnull) NSDate *modifed;
@property (strong, nonatomic, nonnull) NSString *path;
@property (strong, nonatomic, nonnull) NSArray <Application *> *aplications;

- (instancetype __nullable)initWithDevicePlist:(NSDictionary *__nonnull)aDictionary file:(File *__nonnull)aFile;

@end
