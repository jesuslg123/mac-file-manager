//
//  File.h
//  EmulatorFileManager
//
//  Created by Jesus Lopez on 27/04/2017.
//  Copyright © 2017 Jesus Lopez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface File : NSObject

@property (strong, nonatomic, nonnull, readonly) NSString *fullPath;

@property (strong, nonatomic, nonnull) NSString *name;
@property (strong, nonatomic, nonnull) NSString *path;
@property (strong, nonatomic, nonnull) NSString *fileType;
@property (strong, nonatomic, nonnull) NSDate *created;
@property (strong, nonatomic, nonnull) NSDate *modified;

- (instancetype __nullable)initWithDictionary:(NSDictionary *__nonnull)aDictionary;

- (NSString *__nonnull)fullPath;

@end
