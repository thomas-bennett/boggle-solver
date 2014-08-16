//
//  BasicDictionary.h
//  Bungie
//
//  Created by Bennett, Tom on 12/2/12.
//  Copyright (c) 2012 Tom Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoggleSolver.h"

/**
 Basic dictionary with a very few english entries. Intended solely for test purposes.
 **/
@interface BasicDictionary : NSObject<Dictionary> {
    NSSet* dictionary;
}
@end
