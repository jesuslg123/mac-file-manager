//
//  EmulatorManager.h
//  EmulatorFileManager
//
//  Created by Jesus Lopez Garcia on 30/04/2017.
//  Copyright © 2017 Jesus Lopez. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Emulator;

@interface EmulatorManager : NSObject

- (instancetype __nullable)initWithEmulatorsPath:(NSString *__nonnull)aPath;
- (NSArray <Emulator *> *__nullable)emulators;

@end
