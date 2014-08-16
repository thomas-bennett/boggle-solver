//
//  BasicDictionary.m
//  Bungie
//
//  Created by Bennett, Tom on 12/2/12.
//  Copyright (c) 2012 Tom Bennett. All rights reserved.
//

#import "BasicDictionary.h"

@implementation BasicDictionary
-(id)init {
    // Add a few words for testing basic dictionary.
    dictionary = [NSSet setWithObjects:@"bred", @"yore", @"byre", @"abed", @"oread", @"bore", @"orby", @"robed", @"broad", @"byroad", @"robe",
                                       @"bored", @"derby", @"bade", @"aero", @"read", @"orbed", @"verb", @"aery", @"bead", @"bread", @"very",
                                       @"road", @"robber", @"robbed", nil];
    [dictionary retain];
    return self;
}

-(void)dealloc {
    [dictionary release];
    [super dealloc];
}

-(BOOL)isWord:(NSString *)word {
    return [dictionary containsObject:word];
}

+(BOOL)supportsSuffixes {
    return false;
}
@end
