//
//  Board.m
//  Bungie
//
//  Created by Bennett, Tom on 12/1/12.
//  Copyright (c) 2012 Tom Bennett. All rights reserved.
//

#import <CoreFoundation/CoreFoundation.h>

#import "Board.h"

@implementation Board

@synthesize width, height;

-(id) initWithWith:(const size_t)w height:(const size_t)h characters:(const char*) board {
    height = h;
    width = w;
    characters = board;
    usedPositions = CFBitVectorCreateMutable(kCFAllocatorDefault,height * width);

    return self;
}

-(void) dealloc {
    CFRelease(usedPositions);
    [super dealloc];
}

-(BOOL) wasSpaceUsedAtRow:(const size_t) row column:(const size_t) column {
    // Check if this space has been used.
    size_t bitVectorPosition = [self getByteArrayPositionForRow:row column:column];
    CFBit bit = CFBitVectorGetBitAtIndex(usedPositions, bitVectorPosition);
    
    return bit == 0;
}

-(BOOL) isValidPositionAtRow:(const size_t)row column:(const size_t) column {
    // Out of bounds of the grid.
    if (row > height - 1 || column > width - 1) return false;
    
    return [self wasSpaceUsedAtRow:row column:column];
}

-(void) markSpaceUsed:(BOOL)isUsed atRow:(const size_t)row column:(const size_t) column {
    size_t bitVectorPosition = [self getByteArrayPositionForRow:row column:column];
    CFBit bitValue = isUsed ? 1 : 0;
    CFBitVectorSetBitAtIndex(usedPositions, bitVectorPosition, bitValue);
}

-(NSString *) characterAtRow:(const size_t)row column:(const size_t) column {
    const unichar character = characters[column + row * width];
    return [NSString stringWithCharacters:&character length:1];
}

-(size_t)getByteArrayPositionForRow:(const size_t)row column:(const size_t) column {
    return column + row * width;
}
@end
