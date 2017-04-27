//
//  main.m
//  EmulatorFileManager
//
//  Created by Jesus Lopez on 27/04/2017.
//  Copyright © 2017 Jesus Lopez. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TEST @"/Users/jesus/Library/Developer/CoreSimulator/Devices"

#import "FileManager.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        NSArray *list = [FileManager filesAtPath:TEST];
        NSLog(@"Desde: %f", ((File *)list[0]).modified.timeIntervalSince1970);
    }
    return 0;
}
