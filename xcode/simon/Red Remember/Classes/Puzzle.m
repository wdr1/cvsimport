//
//  Puzzle.m
//  Red Remember
//
//  Created by Bill Reardon on 8/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Puzzle.h"


@implementation Puzzle

@synthesize puzzle_sequence;
@synthesize puzzle_sequence_position;

- (id) init {
	[super init];
	puzzle_sequence = [[NSMutableArray alloc] init];
	return self;
}


- (void) increasePuzzleSequence {
	
	int newStep = arc4random() % NUMBER_OF_BUTTONS;
	[puzzle_sequence addObject:[NSNumber numberWithInt:newStep]];

	NSLog(@"Puzzle sequence increased. New sequence: %@", [puzzle_sequence componentsJoinedByString:@", "]);
}


// Make sure this was the right button to click & issue a new timer
- (PuzzleSequenceStatus) checkStep:(NSInteger)answer{
	NSLog(@"given: %d   expected: %d", answer,[[puzzle_sequence objectAtIndex:puzzle_sequence_position] intValue]);
	if (answer != [[puzzle_sequence objectAtIndex:puzzle_sequence_position] intValue]){
		return kPuzzleSequenceMistake;
	}
	puzzle_sequence_position++;
	
	if (puzzle_sequence_position == [puzzle_sequence count]) {
		puzzle_sequence_position = 0;
		[self increasePuzzleSequence];
		return kPuzzleSequenceDone;
	}
	
	return kPuzzleSequenceOk;
}


- (NSString*) sequenceLevelString {
	return [NSString stringWithFormat:@"%03d", [puzzle_sequence count] - 1];
}


- (NSInteger) sequenceLevel {
	return [puzzle_sequence count] - 1;
}


- (void) reset {
	puzzle_sequence_position = 0;
	[puzzle_sequence dealloc];
	puzzle_sequence = [[NSMutableArray alloc] init];
	[self increasePuzzleSequence];
}



- (NSString *) PuzzleSequenceStatusToText:(PuzzleSequenceStatus *)status  {

	switch (*status) {
		case kPuzzleSequenceOk:
			return @"Puzzle Sequence OK";
			break;
		case kPuzzleSequenceDone:
			return @"Puzzle Sequence Done";
			break;
		case kPuzzleSequenceMistake:
			return @"Puzzle Sequence Mistake";
			break;
		default:
			return @"Unknown Sequence Status";
			break;
	}
	
}
	


- (void) dealloc
{
	[puzzle_sequence release];
	[super dealloc];
}

@end
