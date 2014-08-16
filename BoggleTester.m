//
//  BoggleTester.m
//  Bungie
//
//  Created by Bennett, Tom on 12/1/12.
//  Copyright (c) 2012 Tom Bennett. All rights reserved.
//

#import "BoggleSolver.h"
#import "BasicDictionary.h"

int main(int argc, const char * argv[]) {
    size_t height = 3;
    size_t width = 3;
    const char characters[] = {
        'y', 'o', 'x',
        'r', 'b', 'a',
        'v', 'e', 'd'};
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    BasicDictionary* d = [[[BasicDictionary alloc] init] autorelease];
    NSArray* words = [BoggleSolver solveBoardWithWidth:width height:height characters:characters dictionary:d];    
    NSArray* sortedResults = [words sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    NSMutableSet* expectedResults = [NSMutableSet setWithObjects:@"bred", @"yore", @"byre", @"abed", @"oread", @"bore", @"orby", @"robed", @"broad", @"byroad", @"robe",
                                     @"bored", @"derby", @"bade", @"aero", @"read", @"orbed", @"verb", @"aery", @"bead", @"bread", @"very", @"road", nil];
     
     
    for (NSString *word in sortedResults) {
        if (![expectedResults containsObject:word]) {
            printf("Found %s but it is not in the expected set!\n", [word UTF8String]);
        } else {
            printf("%s\n", [word UTF8String]);
        }
        // Remove the corresponding result to make it easier to note if we found all of the results.
        [expectedResults removeObject:word];
    }
    if ([expectedResults count] != 0) {
        printf("Failed to find all the expected results! Did not find:");
        for (NSString *word in expectedResults) {
            printf("%s\n", [word UTF8String]);
        }
    } else {
        printf("Successfully found all target words.");
    }
    [pool release];
    
    return 0;
}