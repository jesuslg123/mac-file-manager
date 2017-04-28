//
//  FileManager.h
//  EmulatorFileManager
//
//  Created by Jesus Lopez on 27/04/2017.
//  Copyright © 2017 Jesus Lopez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "File.h"

@interface FileManager : NSObject

+ (BOOL)pathExist:(NSString *__nonnull)aPath;

+ (NSArray<NSDictionary *> *__nullable)attributedContentAtPath:(NSString *__nonnull)aPath;

+ (NSArray<File *> *__nullable)filesAtPath:(NSString *__nonnull)aPath;
+ (NSArray<File *> *__nullable)filesExtension:(NSString *__nonnull)aExtension atPath:(NSString *__nonnull)aPath;
+ (NSArray<File *> *__nullable)filesType:(NSFileAttributeType __nonnull)aType atPath:(NSString *__nonnull)aPath;
+ (NSArray<File *> *__nullable)filesType:(NSFileAttributeType __nonnull)aType extension:(NSString *__nonnull)aExtension atPath:(NSString *__nonnull)aPath;


@end
