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

+ (BOOL)pathExist:(NSString *)aPath;

+ (NSArray<NSDictionary *> *)attributedContentAtPath:(NSString *)aPath;

+ (NSArray<File *> *)filesAtPath:(NSString *)aPath;
+ (NSArray<File *> *)filesExtension:(NSString *)aExtension atPath:(NSString *)aPath;
+ (NSArray<File *> *)filesType:(NSFileAttributeType)aType atPath:(NSString *)aPath;
+ (NSArray<File *> *)filesType:(NSFileAttributeType)aType extension:(NSString *)aExtension atPath:(NSString *)aPath;


@end
