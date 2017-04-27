//
//  FileManager.h
//  EmulatorFileManager
//
//  Created by Jesus Lopez on 27/04/2017.
//  Copyright © 2017 Jesus Lopez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

+ (BOOL)pathExist:(NSString *)aPath;
+ (NSArray *)attributedContentAtPath:(NSString *)aPath;

@end
