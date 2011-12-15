//
//  SplitViewController.m
//  voxe
//
//  Created by Antoine Maillard on 11/12/11.
//  Copyright 2011 ENST. All rights reserved.
//

#import "SplitViewController.h"

@implementation SplitViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithCandidatesViewController:(CandidatesViewController_iPad*)aCandidatesViewController{
    
    self = [super init];
    if (self) {
        candidatesViewController = [aCandidatesViewController retain];
        cellLoader = [[UINib nibWithNibName:@"ThemeCell" bundle:[NSBundle mainBundle]] retain];
    }
    return self;
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - TableView delegate

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
    
    
    [self loadComparisonWebPage];
    
}


#pragma mark - Buttons

- (IBAction) changeCandidates:(id)sender{
    
    [candidatesViewController showWithParentInitialisator:self];
    
}

- (void) candidatesPopupValidated{
    [self dismissModalViewControllerAnimated:YES];
    [self loadCandidatesImageList];
    [self loadComparisonWebPage];
}


- (void) loadCandidatesImageList{
        
    int i;

    for(i=0;i<3;i++){
        
        if([[candidatesViewController selectedCandidates] count] > i){
            
            NSString *photoUrl = [[[[[[candidatesViewController selectedCandidates] objectAtIndex:i] valueForKey:@"photo"] valueForKey:@"sizes"] valueForKey:@"small"] valueForKey:@"url"];
            
            if(photoUrl){
                NSURL *dataURL = [NSURL URLWithString:photoUrl];
                ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:dataURL];
                [request setDelegate:self];
                [request startAsynchronous];
                [request setTag:i];
            }else{
                
                [[candidatesImageViews objectAtIndex:i] setImage:[UIImage imageNamed:@"candidateIcon.png"]];
                
            }
            

            CALayer *l = [[candidatesImageViews objectAtIndex:i] layer];
            [l setMasksToBounds:YES];
            [l setCornerRadius:5.0];

            
            
        }else{
            [[candidatesImageViews objectAtIndex:i] setImage:nil];
            
        }
    }
}


-(void) requestFinished: (ASIHTTPRequest *) request {
    [[candidatesImageViews objectAtIndex:[request tag]] setImage:[UIImage imageWithData:[request responseData]]];
}





#pragma mark - Webview actions

- (void) loadComparisonWebPage{
    
    if([themeTableView indexPathForSelectedRow]){
        
        NSDictionary *currentCandidate;
        NSMutableArray *ids = [[NSMutableArray alloc] init];
        NSEnumerator *objEnum = [[candidatesViewController selectedCandidates] objectEnumerator];
        while(currentCandidate = [objEnum nextObject]){
            [ids addObject:[currentCandidate valueForKey:@"id"]];        
        }
        NSString *idsList = [ids componentsJoinedByString:@","];
        
        NSString *compareUrl = [NSString stringWithFormat:@"http://voxe.org/webviews/compare?electionId=%@&candidateIds=%@&themeId=%@", @"4ed1cb0203ad190006000001", idsList, [currentTheme valueForKey:@"id"]];
        
        [detailBar setTitle:[currentTheme valueForKey:@"name"]];
        [detailWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:compareUrl]]];
        
    }
    


}

#pragma mark - Webview delegate

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
        
    
    
    if([[[request URL] path] isEqualToString:@"/webviews/proposition"]){
        
        [detailViewController showWithParentInitialisator:self forRequest:request];
        
        return NO;
        
    }else{
        
        [indicatorView startAnimating];
        return YES;
        
    }
    
    return YES;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [indicatorView stopAnimating];
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    candidatesImageViews = [[NSArray alloc] initWithObjects:candidate1ImageView, candidate2ImageView, candidate3ImageView, nil];
    detailViewController = [[DetailViewController_iPad alloc] init];
    [self loadCandidatesImageList];
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
