//
//  ViewController.h
//  ColorGame
//
//  Created by iOS Developer on 2013. 12. 1..
//  Copyright (c) 2013년 iOS Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import "GameCenterManager.h"

@class GameCenterManager;

@interface ViewController : UIViewController <UIActionSheetDelegate, GKLeaderboardViewControllerDelegate, GKAchievementViewControllerDelegate, GameCenterManagerDelegate> {
    GameCenterManager *gameCenterManager;
    int64_t  currentScore;
    NSString* currentLeaderBoard;
    IBOutlet UILabel *currentScoreLabel;
}
@property (nonatomic, retain) GameCenterManager *gameCenterManager;
@property (nonatomic, assign) int64_t currentScore;
@property (nonatomic, retain) NSString* currentLeaderBoard;
@property (nonatomic, retain) UILabel *currentScoreLabel;
- (IBAction) reset;
- (IBAction) showLeaderboard;
- (IBAction) showAchievements;
- (IBAction) submitScore;
- (IBAction) increaseScore;
- (void) checkAchievements;

@end
