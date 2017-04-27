//
//  FileManager.m
//  EmulatorFileManager
//
//  Created by Jesus Lopez on 27/04/2017.
//  Copyright © 2017 Jesus Lopez. All rights reserved.
//

#import "FileManager.h"
#import "NSArray+FMTools.h"

#define DEFAULTFILEMANAGER [NSFileManager defaultManager]
#define KEY_FILE_PATH @"FILE_PATH"
#define KEY_FILE_NAME @"FILE_NAME"

@implementation FileManager

#pragma mark - Publics methods

+ (BOOL)pathExist:(NSString *)aPath {
    return [DEFAULTFILEMANAGER fileExistsAtPath:aPath];
}

+ (NSArray<File *> *)filesExtension:(NSString *)aExtension atPath:(NSString *)aPath {
    NSArray *files = [[self class] filesAtPath:aPath];
    return [[self class] filter:files byExtension:aExtension];
}

+ (NSArray<File *> *)filesType:(NSFileAttributeType)aType atPath:(NSString *)aPath {
    NSArray *files = [[self class] filesAtPath:aPath];
    return [[self class] filter:files byType:aType];
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
            NSString *fullFilePath = [[self class] append:filePath toPath:aPath];
            NSDictionary *fileAttributes = [[self class] attributesOfPath:fullFilePath];
            [attributedContent addObject:[[self class] addFile:filePath path:aPath toAttributes:fileAttributes]];
        }
    }
    
    return attributedContent;
}

#pragma mark - Privated Methods

+ (NSDictionary *)attributesOfPath:(NSString *)aPath {
    NSError *error;
    return [DEFAULTFILEMANAGER attributesOfItemAtPath:aPath error:&error];
}

+ (NSDictionary *)addFile:(NSString *)aName path:(NSString *)aPath toAttributes:(NSDictionary *)attributes {
    if (attributes == nil) {
        attributes = [NSDictionary new];
    }
    
    NSMutableDictionary *attributedPathDictionary = [NSMutableDictionary dictionaryWithDictionary:attributes];
    
    [attributedPathDictionary setValue:aName forKey:KEY_FILE_NAME];
    [attributedPathDictionary setValue:aPath forKey:KEY_FILE_PATH];
    
    return attributedPathDictionary.copy;
}

+ (NSString *)append:(NSString *)aName toPath:(NSString *)aPath {
    return [NSString stringWithFormat:@"%@/%@",aPath, aName];
}

+ (NSArray *)filter:(NSArray *)aFiles byExtension:(NSString *)aExtension {
    return [aFiles filterBy:@"name" endingValue:aExtension];
}

+ (NSArray *)filter:(NSArray *)aFiles byType:(NSFileAttributeType)aType {
    //TODO: Convert type to string???? Or save type...
    [NSException raise:NSInternalInconsistencyException
                format:@"Method %@ not implemented", NSStringFromSelector(_cmd)];
    return [aFiles filterBy:@"fileType" value:@"aType"];
}

@end
