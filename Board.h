//
//  Board.h
//  Bungie
//
//  Created by Bennett, Tom on 12/1/12.
//  Copyright (c) 2012 Tom Bennett. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class CFMutableBitVector;

@interface Board : NSObject {
    // TODO: Handle the 'qu' special case.
    const char* characters;
    // Would prefer to use a bitset, but the size must be known at compile time.
    CFMutableBitVectorRef usedPositions;
}

//-Board(const size_t width, const size_t height, char board[][]);
-(id) initWithWith:(const size_t)width height:(const size_t)height characters:(const char*) board;
-(BOOL) wasSpaceUsedAtRow:(const size_t) row column:(const size_t) column;
-(BOOL) isValidPositionAtRow:(const size_t)row column:(const size_t) height;
-(void) markSpaceUsed:(BOOL)isUsed atRow:(const size_t)row column:(const size_t) column;
-(NSString *) characterAtRow:(const size_t)row column:(const size_t) column;

@property (readonly, nonatomic) size_t height, width;
@end
