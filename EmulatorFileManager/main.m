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
#import "EmulatorManager.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        //NSArray *list = [FileManager filesAtPath:TEST];
        //NSArray *list = [FileManager recursiveFilesAtPath:TEST  maxLevel:0];
        //NSArray *list = [FileManager recursiveFilesType:NSFileTypeDirectory atPath:TEST maxLevel:15];
        //NSLog(@"Desde: %@", ((File *)list[0]).fullPath);
        
        EmulatorManager *emulatorManager = [EmulatorManager new];
        NSArray *emulators = [emulatorManager emulators];
        
        
    }
    return 0;
}
