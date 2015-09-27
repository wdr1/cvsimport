//
//  Red_RememberViewController.m
//  Red Remember
//
//  Created by Bill Reardon on 8/14/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "Red_RememberViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@implementation Red_RememberViewController

@synthesize puzzle;
@synthesize level_label;
@synthesize redButton;
@synthesize greenButton;
@synthesize yellowButton;
@synthesize blueButton;
@synthesize button_mapping;
@synthesize sound_mapping;

@synthesize timer_counter;
@synthesize button_wait;

const double INITIAL_BUTTON_WAIT = 3.0;
const double HIGHLIGHT_SECONDS = 0.5; // 500 ms
const double NEXT_SECONDS = 0.8; 
const double WRONG_ANSWER_DELAY = 0.300;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (IBAction) resetSequence:(id)sender {
	[puzzle reset];
	[level_label setText:[puzzle sequenceLevelString]];
}


-(void) failedGameOverAlert {
	NSLog(@"failedGameOverAlert");
	NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"gameover" ofType:@"wav"];
	NSURL *soundFileURL = [NSURL fileURLWithPath:soundPath];
	AVAudioPlayer *sound = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
	[sound play];
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Game Over!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
	[alert show]; 
	[alert release];
	[puzzle reset];
}


- (void) failedGameOver {
	[self displayPuzzleSequenceAndWait:NO];
	
	NSInteger level = [puzzle sequenceLevel];
	double delay = (level + 1) * NEXT_SECONDS;
	
	[self performSelector:@selector(failedGameOverAlert) withObject:nil afterDelay:delay];		
}


- (void)wrongButton:(NSInteger)correct_button {
	timer_counter++;
	UIButton *button = [button_mapping objectAtIndex:correct_button];
	button.highlighted = YES;

	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);	
	
	NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"wrong" ofType:@"wav"];
	NSURL *soundFileURL = [NSURL fileURLWithPath:soundPath];
	AVAudioPlayer *sound = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
	[sound play];
	double sound_delay = [sound duration];
	
	[NSTimer scheduledTimerWithTimeInterval:sound_delay target:self selector:@selector(highlightOff:) userInfo:button repeats:NO];
	[self performSelector:@selector(failedGameOver) withObject:nil afterDelay:sound_delay + WRONG_ANSWER_DELAY];	
}


- (IBAction) colorPressed:(id)sender {
	timer_counter++;
	NSInteger button_tag = [sender tag] - 1;
	PuzzleSequenceStatus status = [puzzle checkStep:button_tag];
	NSLog(@"Button %d  Status: %@", button_tag, [puzzle PuzzleSequenceStatusToText:&status]);
	
	AVAudioPlayer *sound = [sound_mapping objectAtIndex:button_tag];
	[sound play];
	
	double delay;	
	NSInteger correct_button;
	switch (status) {
		case kPuzzleSequenceDone:
			// TODO: change the wait time based on level
			delay = button_wait;
			if (delay > 1.0) {
				delay = 1.0;
			}
			[self performSelector:@selector(displayPuzzleSequence) withObject:nil afterDelay:delay];	
			break;
		case kPuzzleSequenceMistake:
			correct_button = [[[puzzle puzzle_sequence] objectAtIndex:[puzzle puzzle_sequence_position]] intValue];
			[self wrongButton:button_tag];
			break;
		default:
			[self waitForNextStep];
			break;
	}
}


- (IBAction) startGame:(id)sender {
	[puzzle reset];
	[level_label setText:[puzzle sequenceLevelString]];
	button_wait = INITIAL_BUTTON_WAIT;
	[self performSelector:@selector(displayPuzzleSequence) withObject:nil afterDelay:0.5];	
}

- (void) displayPuzzleSequence {
	[self displayPuzzleSequenceAndWait:YES];
}


- (void) displayPuzzleSequenceAndWait:(BOOL)do_wait {
	[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
	[level_label setText:[puzzle sequenceLevelString]];
	NSArray* sequence = [puzzle puzzle_sequence];
	for (NSInteger i = 0; i < [sequence count]; i++) {
//		UIButton *button = [button_mapping objectAtIndex:[[sequence objectAtIndex:i] intValue]];
//		[self highlightButton:button Delay:NEXT_SECONDS * i];
		[self highlightButton:[[sequence objectAtIndex:i] intValue] Delay:NEXT_SECONDS * i];
	}
	
	[[UIApplication sharedApplication] performSelector:@selector(endIgnoringInteractionEvents) withObject:nil afterDelay:NEXT_SECONDS * [sequence count]];	
	if (do_wait) {
		[self performSelector:@selector(waitForNextStep) withObject:nil afterDelay:NEXT_SECONDS * [sequence count]];	
	}
}


#pragma mark Timers: Player Response

- (void)checkIfPlayerTookTooLong:(NSTimer*)theTimer {	
    NSUInteger c = [[[theTimer userInfo] objectForKey:@"timerCounter"] intValue];
    NSLog(@"Checking timer for %d", c);
	if (c == timer_counter) {
		[self failedGameOver];
	}
}


- (void) waitForNextStep {
	NSLog(@"Setting timer for %d -- delay: %f", timer_counter, button_wait);
    [NSTimer scheduledTimerWithTimeInterval:button_wait
									 target:self
								   selector:@selector(checkIfPlayerTookTooLong:)
								   userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:timer_counter] forKey:@"timerCounter"]
									repeats:NO];
}


#pragma mark Timers: Button Highlights 

- (void)highlightButton:(NSInteger)button_tag Delay:(double)delay {
	UIButton *button = [button_mapping objectAtIndex:button_tag];
	[NSTimer scheduledTimerWithTimeInterval:delay target:self selector:@selector(highlightOn:) userInfo:button repeats:NO];
	
	AVAudioPlayer *sound = [sound_mapping objectAtIndex:button_tag];
	[NSTimer scheduledTimerWithTimeInterval:delay target:self selector:@selector(playBeep:) userInfo:sound repeats:NO];
}



- (void)highlightButtonOld:(UIButton*)button Delay:(double)delay {
	[NSTimer scheduledTimerWithTimeInterval:delay target:self selector:@selector(highlightOn:) userInfo:button repeats:NO];
}

- (void)playBeep:(NSTimer*)timer {
	AVAudioPlayer *sound = (AVAudioPlayer*)[timer userInfo];
	[sound play];
}

- (void)highlightOn:(NSTimer*)timer {
	UIButton *button = (UIButton*)[timer userInfo];
	
	button.highlighted = YES;
	
	[NSTimer scheduledTimerWithTimeInterval:HIGHLIGHT_SECONDS target:self selector:@selector(highlightOff:) userInfo:button repeats:NO];
}

- (void)highlightOff:(NSTimer*)timer {
	UIButton *button = (UIButton*)[timer userInfo];
	
	button.highlighted = NO;
}



# pragma mark Testing Buttons

- (IBAction) displayPuzzleSequenceButton:(id)sender {
	[self displayPuzzleSequence];
}


-(IBAction)nextLevelButton:(id)sender {
	//	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Button!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	//	[alert show];
	//	[alert release];
	
	[puzzle increasePuzzleSequence];	
}

#pragma mark Core Stuff

- (void)loadSounds {
	NSMutableArray *sounds = [[NSMutableArray alloc] initWithCapacity:4];
	
	for (NSInteger i = 1; i <= 4; i++) {
		NSString *sound_name = [[NSString alloc] initWithFormat:@"ButtonSound%d", i];		
		NSString *soundPath = [[NSBundle mainBundle] pathForResource:sound_name ofType:@"wav"];
		NSURL *soundFileURL = [NSURL fileURLWithPath:soundPath];
		AVAudioPlayer *sound = [[[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil] autorelease];
		
		[sounds addObject:sound];
		[sound_name dealloc];
	}
	sound_mapping = sounds;
	
	NSString *soundPath2 = [[NSBundle mainBundle] pathForResource:@"gameover" ofType:@"wav"];
	NSURL *soundFileURL2 = [NSURL fileURLWithPath:soundPath2];
	NSError *err;
	AVAudioPlayer *sound2 = [[[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL2 error:&err] autorelease];
	NSLog(@"Error: %@", [err description]);
	NSLog(@"Duration: %f ", [sound2 duration]);
	BOOL b = [sound2 play];
	NSLog(@"Play Bool: %d", b);
	NSLog(@"here"); 
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	button_mapping = [[NSArray alloc] initWithObjects:redButton, greenButton, blueButton, yellowButton, nil];	
	[self loadSounds];
	
	self.puzzle = [[Puzzle alloc] init];
	[puzzle increasePuzzleSequence];
}


- (void) viewDidAppear:(BOOL)animated  {
	[super viewDidAppear:animated];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
	[sound_mapping dealloc];
}

@end
