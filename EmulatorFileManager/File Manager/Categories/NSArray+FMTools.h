//
//  NSArray+FMTools.h
//  EmulatorFileManager
//
//  Created by Jesus Lopez Garcia on 27/04/2017.
//  Copyright © 2017 Jesus Lopez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (FMTools)

- (NSArray *)filterBy:(NSString *)aProperty value:(NSString *)aValue;
- (NSArray *)filterBy:(NSString *)aProperty endingValue:(NSString *)aValue;

@end
