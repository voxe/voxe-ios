//
//  CandidateCell.h
//  voxe
//
//  Created by Antoine Maillard on 06/12/11.
//  Copyright 2011 ENST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import <QuartzCore/QuartzCore.h>

@interface CandidateCell : UITableViewCell{
    NSDictionary *associatedCandidate;
    IBOutlet UILabel *candidateName;
    IBOutlet UIImageView *candidatePhoto;
    IBOutlet UIImageView *selectedBullet;
    int selected;
    NSString *customIdentifier;
}

@property(retain, nonatomic) NSString *customIdentifier;

- (void)setAssociatedCandidate:(NSDictionary*)aCandidate;
- (NSDictionary*)associatedCandidate;
- (void)selectCell;
- (int)selected;

@end
