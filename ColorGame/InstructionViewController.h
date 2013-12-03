//
//  InstructionViewController.h
//  ColorGame
//
//  Created by iOS Developer on 2013. 12. 1..
//  Copyright (c) 2013년 iOS Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameCenterManager.h"

@interface InstructionViewController : UIViewController <GKGameCenterControllerDelegate, UIActionSheetDelegate, GameCenterManagerDelegate>
- (IBAction)resetAchievements;
@property (weak, nonatomic) IBOutlet UISwitch *Frenzylabelstate;

@end
