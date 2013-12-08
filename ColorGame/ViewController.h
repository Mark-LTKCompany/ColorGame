//
//  ViewController.h
//  ColorGame
//
//  Created by iOS Developer on 2013. 12. 1..
//  Copyright (c) 2013년 iOS Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameCenterManager.h"

@interface ViewController : UIViewController <GKGameCenterControllerDelegate, UIActionSheetDelegate, GameCenterManagerDelegate>
{
    NSTimer *frenzylogictimer;
    float realR, realG, realB, Ra, Ga, Ba, Rv, Gv, Bv, directionB,directionG,directionR,directionRv,directionGv,directionBv;
}

@property (strong, nonatomic) IBOutlet UILabel *statusDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *actionLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *actionBarLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *playerPicture;
@property (weak, nonatomic) IBOutlet UILabel *playerName;
@property (weak, nonatomic) IBOutlet UILabel *playerStatus;

- (IBAction)Gamecenterlabel:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *Frenzylabel;

@end
