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


/**
 Get current user home path

 @return User home path
 */
+ (NSString *__nonnull)currentHomeUserPath;

/**
 Check if path exist

 @param aPath Path to check
 @return Boolean result indicating if exist a path
 */
+ (BOOL)pathExist:(NSString *__nonnull)aPath;


/**
 Get a list of dictionaries with all files attributes found at path

 @param aPath Path to search on
 @return List of dictionaries with attributed files info
 */
+ (NSArray<NSDictionary *> *__nullable)attributedContentAtPath:(NSString *__nonnull)aPath;

#pragma mark - GET methods

/**
 Get files at path

 @param aPath Path where seach files
 @return List of files found on path
 */
+ (NSArray<File *> *__nullable)filesAtPath:(NSString *__nonnull)aPath;

/**
 Get files at path by type

 @param aExtension File extension
 @param aPath Path where seach files
 @return List of extension matching files found on path
 */
+ (NSArray<File *> *__nullable)filesExtension:(NSString *__nonnull)aExtension atPath:(NSString *__nonnull)aPath;

/**
 Get files at path by extension
 
 @param aType File type
 @param aPath Path where seach files
 @return List of type matching files found on path
 */
+ (NSArray<File *> *__nullable)filesType:(NSFileAttributeType __nonnull)aType atPath:(NSString *__nonnull)aPath;

/**
 Get files at path by type and extension
 
 @param aType File type
 @param aExtension File extension
 @param aPath Path where seach files
 @return List of type and extension matching files found on path
 */
+ (NSArray<File *> *__nullable)filesType:(NSFileAttributeType __nonnull)aType extension:(NSString *__nonnull)aExtension atPath:(NSString *__nonnull)aPath;


#pragma mark - Recurive GET methods

/**
 Recursive get files.

 @param aPath Start path folder
 @param aLevel Number of deep path to explore, 0 = no levels, NSIntegerMax = Infinite
 @return List of files found on path and deepest paths
 */
+ (NSArray <File *>*__nullable)recursiveFilesAtPath:(NSString *__nonnull)aPath maxLevel:(NSInteger)aLevel;

/**
 Recursive get files filtered by extesion file.
 
 @param aName File nme
 @param aPath Start path folder
 @param aLevel Number of deep path to explore, 0 = no levels, NSIntegerMax = Infinite
 @return List of name matching files found on path and deepest paths
 */
+ (NSArray<File *> *__nullable)recursiveFilesName:(NSString *__nonnull)aName atPath:(NSString *__nonnull)aPath maxLevel:(NSInteger)aLevel;

/**
 Recursive get files filtered by extesion file.

 @param aExtension Extension file
 @param aPath Start path folder
 @param aLevel Number of deep path to explore, 0 = no levels, NSIntegerMax = Infinite
 @return List of extesion matching files found on path and deepest paths
 */
+ (NSArray<File *> *__nullable)recursiveFilesExtension:(NSString *__nonnull)aExtension atPath:(NSString *__nonnull)aPath maxLevel:(NSInteger)aLevel;

/**
 Recursive get files filtered by file type.

 @param aType File type. (Folfer, regular file, etc)
 @param aPath Start path folder
 @param aLevel Number of deep path to explore, 0 = no levels, NSIntegerMax = Infinite
 @return List of type matching files found on path and deepest paths
 */
+ (NSArray<File *> *__nullable)recursiveFilesType:(NSFileAttributeType __nonnull)aType atPath:(NSString *__nonnull)aPath maxLevel:(NSInteger)aLevel;

/**
 Recursive get files filtered by extesion and type file.

 @param aType File type. (Folfer, regular file, etc)
 @param aExtension Extension file
 @param aPath Start path folder
 @param aLevel Number of deep path to explore, 0 = no levels, NSIntegerMax = Infinite
 @return List of type and extension matching files found on path and deepest paths
 */
+ (NSArray<File *> *__nullable)recursiveFilesType:(NSFileAttributeType __nullable)aType extension:(NSString *__nullable)aExtension atPath:(NSString *__nonnull)aPath maxLevel:(NSInteger)aLevel;


@end
