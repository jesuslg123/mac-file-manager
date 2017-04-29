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

#pragma mark - Get files

+ (NSArray<File *> *)filesAtPath:(NSString *)aPath {
    NSArray *content = [[self class] attributedContentAtPath:aPath];
    NSMutableArray *files = [NSMutableArray new];
    
    for (NSDictionary *attributes in content) {
        File *file = [[File alloc] initWithDictionary:attributes];
        [files addObject:file];
    }
    
    return files.copy;
}

+ (NSArray<File *> *)filesType:(NSFileAttributeType)aType atPath:(NSString *)aPath {
    NSArray *files = [[self class] filesAtPath:aPath];
    return [[self class] filter:files byType:aType];
}

+ (NSArray<File *> *)filesExtension:(NSString *)aExtension atPath:(NSString *)aPath {
    NSArray *files = [[self class] filesAtPath:aPath];
    return [[self class] filter:files byExtension:aExtension];
}

+ (NSArray<File *> *)filesType:(NSFileAttributeType)aType extension:(NSString *)aExtension atPath:(NSString *)aPath {
    NSArray *files = [[self class] filesExtension:aExtension atPath:aPath];
    return [[self class] filter:files byType:aType];
}

#pragma mark - Recursive Get Files

+ (NSArray <File *>*)recursiveFilesAtPath:(NSString *)aPath {
    return [[self class] recursiveFilesType:nil extension:nil atPath:aPath];
}

+ (NSArray<File *> *)recursiveFilesType:(NSFileAttributeType)aType atPath:(NSString *)aPath {
    return [[self class] recursiveFilesType:aType extension:nil atPath:aPath];
}

+ (NSArray<File *> *)recursiveFilesExtension:(NSString *)aExtension atPath:(NSString *)aPath {
    return [[self class] recursiveFilesType:nil extension:aExtension atPath:aPath];
}

+ (NSArray<File *> *)recursiveFilesType:(NSFileAttributeType)aType extension:(NSString *)aExtension atPath:(NSString *)aPath {
    NSArray *currentPathFiles = [[self class] filesAtPath:aPath];
    NSMutableArray *allFiles = [NSMutableArray arrayWithArray:[[self class] filter:currentPathFiles byType:aType extension:aExtension]];
    
    for (File *file in currentPathFiles) {
        if ([file.fileType isEqualToString:NSFileTypeDirectory]) {
            NSString *nextPath = [[self class] append:file.name toPath:aPath];
            NSArray *nextPathFiles = [[self class] recursiveFilesAtPath:nextPath];
            [allFiles addObjectsFromArray:[[self class] filter:nextPathFiles byType:aType extension:aExtension]];
        }
    }
    
    return allFiles;
}

#pragma mark - Get attributed content

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

#pragma mark - Filters

+ (NSArray *)filter:(NSArray *)aFiles byExtension:(NSString *)aExtension {
    return [aFiles filterBy:@"name" endingValue:aExtension];
}

+ (NSArray *)filter:(NSArray *)aFiles byType:(NSFileAttributeType)aType {
    return [aFiles filterBy:@"fileType" value:aType];
}

+ (NSArray *)filter:(NSArray *)aFiles byType:(NSFileAttributeType)aType extension:(NSString *)aExtension {
    NSArray *filtered = aFiles.copy;
    if (aType != nil ) {
        filtered = [[self class] filter:aFiles byType:aType];
    }
    if (aExtension != nil) {
        filtered = [[self class] filter:filtered byExtension:aExtension];
    }
    return filtered;
}

@end
