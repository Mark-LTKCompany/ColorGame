//
//  GameOverViewController.h
//  ColorGame
//
//  Created by iOS Developer on 2013. 12. 1..
//  Copyright (c) 2013년 iOS Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameCenterManager.h"

@interface GameOverViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *scorelabel;
@property (weak, nonatomic) IBOutlet UILabel *highscorelabel;
@property NSString* score;
@property int highscore;
@end
