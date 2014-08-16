//
//  BoggleSolver.h
//  Bungie
//
//  Created by Bennett, Tom on 12/1/12.
//  Copyright (c) 2012 Tom Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Board;

@protocol Dictionary <NSObject>
-(BOOL)isWord:(NSString*)word;
// Classes that implement the Dictionary protocol might not be capable of determining if a string is a suffix (for example, if the backing data structure is a simple map).
// We require classes to indicate if they support suffixes, but make the suffix method optional.
+(BOOL)supportsSuffixes;

@optional
-(BOOL)isSuffix:(NSString*)word;
@end

@interface BoggleSolver : NSObject {
    Board* board;
    NSMutableArray* results;
    NSMutableString* currentString;    
    NSObject<Dictionary>* dictionary;
}

+(NSArray*)solveBoardWithWidth:(const size_t)width height:(const size_t)height characters:(const char*)characters dictionary:(NSObject<Dictionary>*)d;
// The calling method is responsible for releasing the array and all the strings it contains. 
-(NSArray*)solve;
@end
