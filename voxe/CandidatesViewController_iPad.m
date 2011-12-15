//
//  CandidatesViewController_iPad.m
//  voxe
//
//  Created by Antoine Maillard on 10/12/11.
//  Copyright 2011 ENST. All rights reserved.
//

#import "CandidatesViewController_iPad.h"

@implementation CandidatesViewController_iPad

@synthesize selectedCandidates;


- (id)init{
    
    self = [super init];
    if(self){
        
        selectedCandidates = [[NSMutableArray alloc] init];
        cellLoader = [[UINib nibWithNibName:@"CandidateCell" bundle:[NSBundle mainBundle]] retain];
    }
    
    return self;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark - Display


- (void) showWithParentInitialisator:(UIViewController*)anInitialisator{
    initialisator = anInitialisator;
    
    self.modalPresentationStyle = UIModalPresentationPageSheet;
    self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [initialisator presentModalViewController:self animated:YES];
       
    self.view.superview.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;    
    self.view.superview.frame = CGRectMake(
                                                                    248,
                                                                    132,
                                                                    540.0f,
                                                                    530.0f
                                                                    );
    
}


#pragma mark - Buttons

- (IBAction)validateCandidates:(id)sender{
    [initialisator candidatesPopupValidated];
}


#pragma mark - TableView delegate and data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85.0;
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[(voxeAppDelegate*)[[UIApplication sharedApplication] delegate] electionCandidates] count];;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *electionCandidates = [(voxeAppDelegate*)[[UIApplication sharedApplication] delegate] electionCandidates];
    NSDictionary *electionCandidate = [electionCandidates objectAtIndex:[indexPath row]];
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"candidate_%d", [electionCandidate valueForKey:@"id"]];
    
    CandidateCell *cell = (CandidateCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:self options:nil];
        cell = [topLevelItems objectAtIndex:0];
        [cell setCustomIdentifier:CellIdentifier];
        [cell setAssociatedCandidate:electionCandidate];
    }
    
    
    // Configure the cell.
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CandidateCell *selectedCell = (CandidateCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    
    [selectedCell selectCell];
    
    if([selectedCell selected]){
        [selectedCandidates addObject:[selectedCell associatedCandidate]];
    }else{
        [selectedCandidates removeObject:[selectedCell associatedCandidate]];
    }
    
    [compareButton setEnabled:([selectedCandidates count]>0 && [selectedCandidates count]<=3)];
}

- (NSArray*) selectedCandidates{
    return selectedCandidates;
}


- (NSString*) selectedCandidatesString{
    
    NSDictionary *currentCandidate;
    NSMutableArray *names = [[NSMutableArray alloc] init];
    NSEnumerator *objEnum = [selectedCandidates objectEnumerator];
    while(currentCandidate = [objEnum nextObject]){
        [names addObject:[NSString stringWithFormat:@"%@. %@", [[currentCandidate valueForKey:@"firstName"] substringToIndex:1], [currentCandidate valueForKey:@"lastName"]]];        
    }
    return [names componentsJoinedByString:@", "];
    
}



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [titleItem setTitle:[(voxeAppDelegate*)[[UIApplication sharedApplication] delegate] electionName]];
    [compareButton setEnabled:([selectedCandidates count]>0 && [selectedCandidates count]<=3)];
    
    
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
	return YES;
}

@end
