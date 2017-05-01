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

+ (NSString *)currentHomeUserPath {
    NSURL *url = [DEFAULTFILEMANAGER homeDirectoryForCurrentUser];
    return url.path;
}

#pragma mark - Get files

+ (NSArray<File *> *)filesAtPath:(NSString *)aPath {
    return [[self class] recursiveFilesAtPath:aPath maxLevel:0];
}

+ (NSArray<File *> *)filesType:(NSFileAttributeType)aType atPath:(NSString *)aPath {
    return [[self class] recursiveFilesType:aType atPath:aPath maxLevel:0];
}

+ (NSArray<File *> *)filesExtension:(NSString *)aExtension atPath:(NSString *)aPath {
    return [[self class] recursiveFilesExtension:aExtension atPath:aPath maxLevel:0];
}

+ (NSArray<File *> *)filesType:(NSFileAttributeType)aType extension:(NSString *)aExtension atPath:(NSString *)aPath {
    return [[self class] recursiveFilesType:aType extension:aExtension atPath:aPath maxLevel:0];
}

#pragma mark - Recursive Get Files

+ (NSArray <File *>*)recursiveFilesAtPath:(NSString *)aPath maxLevel:(NSInteger)maxLevel {
    return [[self class] recursiveFilesType:nil extension:nil atPath:aPath maxLevel:maxLevel currentLevel:0];
}

+ (NSArray<File *> *)recursiveFilesType:(NSFileAttributeType)aType atPath:(NSString *)aPath maxLevel:(NSInteger)maxLevel {
    return [[self class] recursiveFilesType:aType extension:nil atPath:aPath maxLevel:maxLevel currentLevel:0];
}

+ (NSArray<File *> *)recursiveFilesExtension:(NSString *)aExtension atPath:(NSString *)aPath  maxLevel:(NSInteger)maxLevel {
    return [[self class] recursiveFilesType:nil extension:aExtension atPath:aPath maxLevel:maxLevel currentLevel:0];
}

+ (NSArray<File *> *)recursiveFilesType:(NSFileAttributeType)aType extension:(NSString *)aExtension atPath:(NSString *)aPath  maxLevel:(NSInteger)maxLevel {
    return [[self class] recursiveFilesType:aType extension:aExtension atPath:aPath maxLevel:maxLevel currentLevel:0];
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
        for (NSString *fileName in content) {
            NSString *fullFilePath = [[self class] append:fileName toPath:aPath];
            NSDictionary *fileAttributes = [[self class] attributesOfPath:fullFilePath];
            [attributedContent addObject:[[self class] addFile:fileName path:aPath toAttributes:fileAttributes]];
        }
    }
    
    return attributedContent;
}








#pragma mark - Privated Methods

#pragma mark - Get Files

+ (NSArray<File *> *)searchFilesAtPath:(NSString *)aPath {
    NSArray *content = [[self class] attributedContentAtPath:aPath];
    NSMutableArray *files = [NSMutableArray new];
    
    for (NSDictionary *attributes in content) {
        File *file = [[File alloc] initWithDictionary:attributes];
        [files addObject:file];
    }
    
    return files.copy;
}

#pragma mark - Recursive

+ (NSArray<File *> *)recursiveFilesType:(NSFileAttributeType)aType extension:(NSString *)aExtension atPath:(NSString *)aPath  maxLevel:(NSInteger)maxLevel currentLevel:(NSInteger)currentLevel {
    
    NSArray *currentPathFiles = [[self class] searchFilesAtPath:aPath];
    NSMutableArray *allFiles = [NSMutableArray arrayWithArray:[[self class] filter:currentPathFiles byType:aType extension:aExtension]];
    
    NSInteger nextLevel = currentLevel + 1;
    if (nextLevel > maxLevel) {
        return allFiles;
    }
    
    for (File *file in currentPathFiles) {
        if ([file.fileType isEqualToString:NSFileTypeDirectory]) {
            NSString *nextPath = [[self class] append:file.name toPath:aPath];
            NSArray *nextPathFiles = [[self class] recursiveFilesType:nil extension:nil atPath:nextPath maxLevel:maxLevel currentLevel:nextLevel];
            [allFiles addObjectsFromArray:[[self class] filter:nextPathFiles byType:aType extension:aExtension]];
        }
    }
    
    return allFiles;
}

#pragma mark - Attributes

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
