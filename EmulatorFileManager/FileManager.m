//
//  FileManager.m
//  EmulatorFileManager
//
//  Created by Jesus Lopez on 27/04/2017.
//  Copyright © 2017 Jesus Lopez. All rights reserved.
//

#import "FileManager.h"

#define DEFAULTFILEMANAGER [NSFileManager defaultManager]
#define KEY_PATH @"FILE_PATH"

@implementation FileManager


+ (BOOL)pathExist:(NSString *)aPath {
    return [DEFAULTFILEMANAGER fileExistsAtPath:aPath];
}

+ (NSArray<File *> *)filesAtPath:(NSString *)aPath {
    NSArray *content = [[self class] attributedContentAtPath:aPath];
    NSMutableArray *files = [NSMutableArray new];
    
    for (NSDictionary *attributes in content) {
        File *file = [[File alloc] initWithDictionary:attributes];
        [files addObject:file];
    }
    
    return files.copy;
}

+ (NSArray *)attributedContentAtPath:(NSString *)aPath {
    if (![[self class] pathExist:aPath]) {
        return nil;
    }
    
    NSMutableArray *attributedContent = [NSMutableArray new];
    
    NSError *error;
    NSArray *content = [DEFAULTFILEMANAGER contentsOfDirectoryAtPath:aPath error:&error];
    
    if (!error) {
        for (NSString *filePath in content) {
            NSString *fullPath = [[self class] append:filePath toPath:aPath];
            [attributedContent addObject:[[self class] addPath:fullPath toAttributes:[[self class] attributesOfPath:fullPath]]];
        }
    }
    
    return attributedContent;
}

+ (NSDictionary *)attributesOfPath:(NSString *)aPath {
    NSError *error;
    return [DEFAULTFILEMANAGER attributesOfItemAtPath:aPath error:&error];
}

+ (NSDictionary *)addPath:(NSString *)aPath toAttributes:(NSDictionary *)attributes {
    if (attributes == nil) {
        attributes = [NSDictionary new];
    }
    
    NSMutableDictionary *attributedPathDictionary = [NSMutableDictionary dictionaryWithDictionary:attributes];
    
    [attributedPathDictionary setValue:aPath forKey:KEY_PATH];
    
    return attributedPathDictionary.copy;
}

+ (NSString *)append:(NSString *)aName toPath:(NSString *)aPath {
    return [NSString stringWithFormat:@"%@/%@",aPath, aName];
}

@end
