//
//  DetailViewController_iPad.m
//  voxe
//
//  Created by Antoine Maillard on 11/12/11.
//  Copyright 2011 ENST. All rights reserved.
//

#import "DetailViewController_iPad.h"

@implementation DetailViewController_iPad

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


- (void) showWithParentInitialisator:(UIViewController*)anInitialisator forRequest:(NSURLRequest*)urlRequest{
    
    
    
    
    initialisator = anInitialisator;
    
    self.modalPresentationStyle = UIModalPresentationPageSheet;
    self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [initialisator presentModalViewController:self animated:YES];
    
    self.view.superview.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;    
    self.view.superview.frame = CGRectMake(
                                           187,
                                           84,
                                           650.0f,
                                           600.0f
                                           );
    
    [webView loadRequest:[urlRequest retain]];
    [urlRequest release];
    
}


- (IBAction)close:(id)sender{
    
    [initialisator dismissModalViewControllerAnimated:YES];
    
}

#pragma mark - WebView delegate

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    [indicatorView startAnimating];
    
    if([[[request URL] path] isEqualToString:@"/webviews/proposition"]){
        
        return YES;
        
    }
    
    return NO;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [indicatorView stopAnimating];
    
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
	return YES;
}

@end
