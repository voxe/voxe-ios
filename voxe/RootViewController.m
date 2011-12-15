//
//  RootViewController.m
//  voxe
//
//  Created by Antoine Maillard on 04/12/11.
//  Copyright 2011 ENST. All rights reserved.
//

#import "RootViewController.h"
#import "voxeAppDelegate.h"
#import "ThemeCell.h"

@implementation RootViewController

@synthesize selectedCandidatesItem;

- (void) awakeFromNib{
    cellLoader = [[UINib nibWithNibName:@"ThemeCell" bundle:[NSBundle mainBundle]] retain];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    compareViewController = [[CompareViewController alloc] initWithRootViewController:self];
    candidatesViewController = [[CandidatesViewController alloc] initWithRootViewController:self];
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Thèmes" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem: backButton];
    [backButton release];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setToolbarHidden:NO animated:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

// Customize the number of sections in the table view.



- (void) loadComparisonWebPage{
    
    
    NSDictionary *currentCandidate;
    NSMutableArray *ids = [[NSMutableArray alloc] init];
    NSEnumerator *objEnum = [[candidatesViewController selectedCandidates] objectEnumerator];
    while(currentCandidate = [objEnum nextObject]){
        [ids addObject:[currentCandidate valueForKey:@"id"]];        
    }
    NSString *idsList = [ids componentsJoinedByString:@","];
    
    NSString *compareUrl = [NSString stringWithFormat:@"http://voxe.org/webviews/compare?electionId=%@&candidateIds=%@&themeId=%@", @"4ed1cb0203ad190006000001", idsList, [currentTheme valueForKey:@"id"]];
    
    
    [compareViewController setTitle:[currentTheme valueForKey:@"name"]];
    [compareViewController loadComparisonPage:compareUrl];
    
}

- (void) candidateModalViewDidDismiss{
    
    if([[self navigationController] visibleViewController] == compareViewController){
        
        [self loadComparisonWebPage];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[(voxeAppDelegate*)[[UIApplication sharedApplication] delegate] electionThemes] count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *electionThemes = [(voxeAppDelegate*)[[UIApplication sharedApplication] delegate] electionThemes];
    NSDictionary *electionTheme = [electionThemes objectAtIndex:[indexPath row]];
    
    
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"theme_%d", [electionTheme valueForKey:@"id"]];
    
    ThemeCell *cell = (ThemeCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:self options:nil];
        cell = [topLevelItems objectAtIndex:0];
        [cell setCustomIdentifier:CellIdentifier];
        [cell setAssociatedTheme:electionTheme];
    }
    
    // Configure the cell.
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    //URL example : http://voxe.org/webviews/compare?electionId=4ed1cb0203ad190006000001&candidateIds=4ed1cb0203ad190006000132,4ed1cb0203ad190006000133&themeId=4ed1cb0203ad190006000016
    
    
    
    

    NSArray *electionThemes = [(voxeAppDelegate*)[[UIApplication sharedApplication] delegate] electionThemes];
    NSDictionary *electionTheme = [electionThemes objectAtIndex:[indexPath row]];
    
    currentTheme = electionTheme;
    
    
    
    
                            
    [[self navigationController] pushViewController:compareViewController animated:YES];

    [self loadComparisonWebPage];
    
}

#pragma mark - Buttons

- (void) showCandidatesPopup{
    //[[self navigationController] setModalPresentationStyle:UIModalPresentationPageSheet];
    [[self navigationController] presentModalViewController:candidatesViewController animated:YES];
    
}

- (IBAction)changeCandidates:(id)sender{
    [self showCandidatesPopup];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [super dealloc];
}

@end
