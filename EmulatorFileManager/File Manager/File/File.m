//
//  File.m
//  EmulatorFileManager
//
//  Created by Jesus Lopez on 27/04/2017.
//  Copyright © 2017 Jesus Lopez. All rights reserved.
//

#import "File.h"

@implementation File

- (instancetype __nullable)initWithDictionary:(NSDictionary *__nonnull)aDictionary {
    if (self = [super init]) {
        [self setDataFromDictionary:aDictionary];
    }
    return self;
}

- (void)setDataFromDictionary:(NSDictionary *__nonnull)aDictionary {
    self.created = aDictionary[NSFileCreationDate];
    self.modified = aDictionary[NSFileModificationDate];
    self.fileType = aDictionary[NSFileType];
    
    self.path = aDictionary[@"FILE_PATH"];
    self.name = aDictionary[@"FILE_NAME"];
}

#pragma mark - Getters

- (NSString *)fullPath {
    return [NSString stringWithFormat:@"%@/%@", self.path, self.name];
}

@end
