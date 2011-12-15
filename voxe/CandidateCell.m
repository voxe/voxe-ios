//
//  CandidateCell.m
//  voxe
//
//  Created by Antoine Maillard on 06/12/11.
//  Copyright 2011 ENST. All rights reserved.
//

#import "CandidateCell.h"

@implementation CandidateCell
@synthesize customIdentifier;

- (NSDictionary*)associatedCandidate{
    return [associatedCandidate retain];
}

- (void)setAssociatedCandidate:(NSDictionary *)aCandidate
{
    
    

    
    [aCandidate retain];
    [associatedCandidate release];
    associatedCandidate = aCandidate;
    
    [candidateName setText:[NSString stringWithFormat:@"%@ %@", [aCandidate valueForKey:@"firstName"], [aCandidate valueForKey:@"lastName"]]];
    

    
    NSString *photoUrl = [[[[associatedCandidate valueForKey:@"photo"] valueForKey:@"sizes"] valueForKey:@"small"] valueForKey:@"url"];

    NSURL *dataURL = [NSURL URLWithString:photoUrl];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:dataURL];
    [request setDelegate:self];
    [request startAsynchronous];
    CALayer *l = [candidatePhoto layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:5.0];
}


-(void) requestFinished: (ASIHTTPRequest *) request {
    [candidatePhoto setImage:[UIImage imageWithData:[request responseData]]];
}

- (int)selected{
    return selected;
}

- (void)selectCell{
    selected = !selected;
    [selectedBullet setHidden:!selected];
}

- (NSString *) reuseIdentifier {
    return customIdentifier;
}


@end
