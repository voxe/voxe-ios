//
//  ThemeCell.m
//  voxe
//
//  Created by Antoine Maillard on 08/12/11.
//  Copyright 2011 ENST. All rights reserved.
//

#import "ThemeCell.h"

@implementation ThemeCell

@synthesize customIdentifier;

- (NSDictionary*)associatedTheme{
    return [associatedTheme retain];
}

- (void)setAssociatedTheme:(NSDictionary *)aTheme
{
    [aTheme retain];
    [aTheme release];
    associatedTheme = aTheme;
    
    [themeName setText:[aTheme valueForKey:@"name"]];
    
    /*
    
    NSString *photoUrl = [[[[associatedCandidate valueForKey:@"photo"] valueForKey:@"sizes"] valueForKey:@"small"] valueForKey:@"url"];
    
    NSURL *dataURL = [NSURL URLWithString:photoUrl];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:dataURL];
    [request setDelegate:self];
    [request startAsynchronous];
     */
    
}


-(void) requestFinished: (ASIHTTPRequest *) request {
    //[candidatePhoto setImage:[UIImage imageWithData:[request responseData]]];
}

- (NSString *) reuseIdentifier {
    return customIdentifier;
}


@end
