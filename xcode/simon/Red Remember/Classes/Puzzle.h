//
//  Puzzle.h
//  Red Remember
//
//  Created by Bill Reardon on 8/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <stdlib.h>

#define NUMBER_OF_BUTTONS 4

@interface Puzzle : NSObject {
	NSMutableArray *puzzle_sequence;
	NSInteger puzzle_sequence_position;
};

typedef enum PuzzleSequenceStatus {
	kPuzzleSequenceOk,
	kPuzzleSequenceDone,
	kPuzzleSequenceMistake
} PuzzleSequenceStatus;
	
- (void) increasePuzzleSequence;
- (void) reset;
- (PuzzleSequenceStatus) checkStep:(NSInteger)answer;
- (NSString *) PuzzleSequenceStatusToText:(PuzzleSequenceStatus *)status;
- (NSString*) sequenceLevelString;
- (NSInteger) sequenceLevel;

@property (nonatomic, retain) NSMutableArray *puzzle_sequence;
@property (nonatomic) NSInteger puzzle_sequence_position;
@end
