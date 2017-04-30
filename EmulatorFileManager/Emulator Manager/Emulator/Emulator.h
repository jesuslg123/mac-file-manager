//
//  Emulator.h
//  EmulatorFileManager
//
//  Created by Jesus Lopez Garcia on 30/04/2017.
//  Copyright © 2017 Jesus Lopez. All rights reserved.
//

#import <Foundation/Foundation.h>

@class App;

@interface Emulator : NSObject

@property (strong, nonatomic, nonnull) NSString *OSType;
@property (strong, nonatomic, nonnull) NSString *OSVersion;
@property (strong, nonatomic, nonnull) NSString *deviceName;
@property (strong, nonatomic, nonnull) NSDate *modifed;
@property (strong, nonatomic, nonnull) NSString *path;
@property (strong, nonatomic, nonnull) NSArray <App *> *aplications;

@end
