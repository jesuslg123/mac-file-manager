//
//  NSArray+FMTools.m
//  EmulatorFileManager
//
//  Created by Jesus Lopez Garcia on 27/04/2017.
//  Copyright © 2017 Jesus Lopez. All rights reserved.
//

#import "NSArray+FMTools.h"

@implementation NSArray (FMTools)

- (NSArray *)filterBy:(NSString *)aProperty value:(NSString *)aValue {
    NSPredicate *predicateEqual = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"self.%@ = '%@'",aProperty, aValue]];
    return [self filteredArrayUsingPredicate:predicateEqual];
}


- (NSArray *)filterBy:(NSString *)aProperty endingValue:(NSString *)aValue {
    NSPredicate *predicateEqual = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"self.%@ ENDSWITH '%@'",aProperty, aValue]];
    return [self filteredArrayUsingPredicate:predicateEqual];
}

@end
