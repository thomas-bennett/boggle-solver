//
//  BoggleSolver.m
//  Bungie
//
//  Created by Bennett, Tom on 12/1/12.
//  Copyright (c) 2012 Tom Bennett. All rights reserved.
//

#import "BoggleSolver.h"
#import "Board.h"

const size_t MIN_WORD_LENGTH = 3;
@implementation BoggleSolver

-(id)initWithWidth:(const size_t)width height:(const size_t)height characters:(const char*)characters dictionary:(NSObject<Dictionary>*)d {
    self = [super init];
    board = [[Board alloc] initWithWith:width height:height characters:characters];
    [board retain];
    dictionary = d;
    [dictionary retain];
    return self;
}

+(NSArray*)solveBoardWithWidth:(const size_t)width height:(const size_t)height characters:(const char*)characters dictionary:(NSObject<Dictionary>*)d {
    BoggleSolver* solver = [[BoggleSolver alloc] initWithWidth:width height:height characters:characters dictionary:d];
    [solver autorelease];
    return [solver solve];
}


-(void)dealloc {    
    [currentString release];
    [results release];
    [board release];
    [dictionary release];
    [super dealloc];
}


-(NSArray*)solve {
    results = [[[NSMutableArray alloc] init] retain];
    
    for (size_t column = 0; column < board.width; column++) {
        for (size_t row = 0; row < board.height; row++) {
            [self searchBoardAtRow:row column:column];
        }
    }
    
    return results;
}

-(void)searchBoardAtRow:(const size_t)row column:(const size_t)column {
    if (![board isValidPositionAtRow:row column:column]) {
        // Not a valid space.
        return;
    }
    
    [board markSpaceUsed:true atRow:row column:column];
    
    if (currentString == nil) {
        currentString = [[NSMutableString string] retain];
    }
    
    NSString* nextChar = [board characterAtRow:row column:column];
    [currentString appendString:nextChar];
    
    if ([self isValidWord:currentString]) {
        // Create a copy of the current string and add it to the array.
        NSString *newWord = [[[NSString alloc] initWithString:currentString] autorelease];
        [results addObject:newWord];
    }
    
    // If the word is not a valid suffix then we can exit early.
    if ([self isSuffix:currentString]) {
        [self searchAdjacentPositionsFromRow:row column:column];
    }
    
    // Pop off the last character since we're done evaluating it.
    [currentString deleteCharactersInRange:NSMakeRange([currentString length] - 1, 1)];
    [board markSpaceUsed:false atRow:row column:column];
}

-(void)searchAdjacentPositionsFromRow:(const size_t)row column:(const size_t)column {
    for (int rowModifier = -1; rowModifier <= 1; rowModifier++) {
        for (int columnModifier = -1; columnModifier <= 1; columnModifier++) {
            [self searchBoardAtRow:rowModifier+row column:columnModifier+column];
        }
    }
}

-(BOOL)isValidWord:(NSString*)word {
    if ([word length] < MIN_WORD_LENGTH) return false;
    
    return [dictionary isWord:word];
}

// This method is meant to act as a wrapper to the dictionary. If the data structure acting as a dictionary can determine if a string as a suffix, call the appropriate method.
// If the backing data structure cannot tell us, assume it is.
-(BOOL)isSuffix:(NSString*)word {
    return [dictionary.class supportsSuffixes] ? [dictionary isSuffix:word] : true;
}

@end
