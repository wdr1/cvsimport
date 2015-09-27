//
//  Red_RememberViewController.h
//  Red Remember
//
//  Created by Bill Reardon on 8/14/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Puzzle.h"

#define RED_BUTTON 1
#define GREEN_BUTTON 2
#define BLUE_BUTTON 3
#define YELLOW_BUTTON 4
#define EXAMPLE_BUTTON_DOWN_TIME 0.5


@interface Red_RememberViewController : UIViewController {
	IBOutlet Puzzle *puzzle;
	NSArray *button_mapping;
	NSArray *sound_mapping;
	IBOutlet UILabel *level_label;
	IBOutlet UIButton *redButton;
	IBOutlet UIButton *greenButton;
	IBOutlet UIButton *blueButton;
	IBOutlet UIButton *yellowButton;
	NSInteger timer_counter;
	double button_wait;
}

- (IBAction) colorPressed:(id)sender;
- (IBAction) nextLevelButton:(id)sender;
- (IBAction) displayPuzzleSequenceButton:(id)sender;
- (IBAction) resetSequence:(id)sender;
- (IBAction) startGame:(id)sender;

- (void) waitForNextStep;

- (void) displayPuzzleSequence;
- (void) displayPuzzleSequenceAndWait:(BOOL)do_wait;
- (void)highlightButton:(NSInteger)button_tag Delay:(double)delay;
- (void)highlightOn:(NSTimer*)timer;
- (void)highlightOff:(NSTimer*)timer;

@property (nonatomic, retain) Puzzle *puzzle;
@property (nonatomic, retain) UILabel *level_label;
@property (nonatomic, retain) NSArray *button_mapping;
@property (nonatomic, retain) NSArray *sound_mapping;
@property (nonatomic, retain) UIButton *redButton;
@property (nonatomic, retain) UIButton *greenButton;
@property (nonatomic, retain) UIButton *blueButton;
@property (nonatomic, retain) UIButton *yellowButton;
@property (nonatomic) NSInteger timer_counter;
@property (nonatomic) double button_wait;

@end

