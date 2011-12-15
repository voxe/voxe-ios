//
//  RootViewController-iPad.m
//  voxe
//
//  Created by Antoine Maillard on 10/12/11.
//  Copyright 2011 ENST. All rights reserved.
//

#import "RootViewController-iPad.h"

@implementation RootViewController_iPad
@synthesize candidatesViewController_iPad;

- (void) awakeFromNib{

    candidatesViewController_iPad = [[CandidatesViewController_iPad alloc] init];
    splitViewController = [[SplitViewController alloc] initWithCandidatesViewController:candidatesViewController_iPad];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void) showCandidatesPopup{
    
    
    [candidatesViewController_iPad showWithParentInitialisator:self];
    
    
}
- (void) candidatesPopupValidated{
    [self dismissModalViewControllerAnimated:YES];
    
    //[[(voxeAppDelegate*)[[UIApplication sharedApplication] delegate] window] performSelector:@selector(setRootViewController:) withObject:[(voxeAppDelegate*)[[UIApplication sharedApplication] delegate] splitViewController] afterDelay:.5];
    [[self view] addSubview:[splitViewController view]];
}

- (void) hideWaitingMessages{
    [waitingLabel setHidden:YES];
    [waitingIndicator stopAnimating];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
