//
//  ViewController.m
//  ColorGame
//
//  Created by iOS Developer on 2013. 12. 1..
//  Copyright (c) 2013년 iOS Developer. All rights reserved.
//

#import "ViewController.h"
#import "GameViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize scrollView;
@synthesize statusDetailLabel, actionLabel, actionBarLabel;
@synthesize playerPicture, playerName, playerStatus;

@synthesize Frenzylabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[GameCenterManager sharedManager] setDelegate:self];
    [[GameCenterManager sharedManager] initGameCenter];
    
    //If Frenzy mode is enabled, show frenzy mode indicator
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *FrenzySetting = [defaults objectForKey:@"FrenzySetting"];
    if([FrenzySetting intValue]==1)
    {
        Frenzylabel.transform = CGAffineTransformMakeRotation(-10*M_PI / 180.0);
        Frenzylabel.hidden=NO;
    }
    else
    {
        Frenzylabel.hidden=YES;
    }
    
    if([FrenzySetting intValue]==1)
    {
        realR=1;
        realG=1;
        realB=1;
        frenzylogictimer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(frenzytime) userInfo:nil repeats:YES];
    }

}

- (void) frenzytime
{
    
    
    float a=arc4random()%1000;
    float b=arc4random()%1000;
    float c=arc4random()%1000;
    
    if(Ra>=0.01)
        directionRv=1;
    if(Ra<=0.008)
        directionRv=0;
    if(directionRv==0)
        Ra+=a/1000000;
    if(directionRv==1)
        Ra-=a/1000000;
    
    if(Ga>=0.01)
        directionGv=1;
    if(Ga<=0.008)
        directionGv=0;
    if(directionGv==0)
        Ga+=b/1000000;
    if(directionGv==1)
        Ga-=b/1000000;
    
    if(Ba>=0.01)
        directionBv=1;
    if(Ba<=0.008)
        directionBv=0;
    if(directionBv==0)
        Ba+=c/1000000;
    if(directionBv==1)
        Ba-=c/1000000;
    
    Rv=Ra*0.7;
    Gv=Ga*0.8;
    Bv=Ba*0.9;
    
    
    
    if(realR>=0.9)
        directionR=1;
    if(realR<=0.1)
        directionR=0;
    if(directionR==0)
        realR+=Rv;
    if(directionR==1)
        realR-=Rv;
    
    if(realG>=0.9)
        directionG=1;
    if(realG<=0.1)
        directionG=0;
    if(directionG==0)
        realG+=Gv;
    if(directionG==1)
        realG-=Gv;
    
    if(realB>=0.9)
        directionB=1;
    if(realB<=0.1)
        directionB=0;
    if(directionB==0)
        realB+=Bv;
    if(directionG==1)
        realB-=Bv;
    
    
    self.view.backgroundColor=[UIColor colorWithRed:realR green:realG blue:realB alpha:1];
    
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    BOOL available = [[GameCenterManager sharedManager] checkGameCenterAvailability];
    if (available) {
        [self.navigationController.navigationBar setValue:@"GameCenter Available" forKeyPath:@"prompt"];
    } else {
        [self.navigationController.navigationBar setValue:@"GameCenter Unavailable" forKeyPath:@"prompt"];
    }
    
    GKLocalPlayer *player = [[GameCenterManager sharedManager] localPlayerData];
    if (player) {
        if ([player isUnderage] == NO) {
            actionBarLabel.title = [NSString stringWithFormat:@"%@ signed in.", player.displayName];
            playerName.text = player.displayName;
            playerStatus.text = @"Player is not underage";
            [[GameCenterManager sharedManager] localPlayerPhoto:^(UIImage *playerPhoto) {
                playerPicture.image = playerPhoto;
            }];
        } else {
            playerName.text = player.displayName;
            playerStatus.text = @"Player is underage";
            actionBarLabel.title = [NSString stringWithFormat:@"Underage player, %@, signed in.", player.displayName];
        }
    } else {
        actionBarLabel.title = [NSString stringWithFormat:@"No GameCenter player found."];
    }
}

- (IBAction)startGame:(id)sender
{
    GameViewController *GameViewController =
    [self.storyboard instantiateViewControllerWithIdentifier:@"GameViewController"];
    GameViewController.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    GameViewController.realR=realR;
    GameViewController.realG=realG;
    GameViewController.realB=realB;
    [frenzylogictimer invalidate];
    [self presentViewController:GameViewController animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Gamecenterlabel:(id)sender {
    
    [[GameCenterManager sharedManager] checkGameCenterAvailability];
    
    GKGameCenterViewController *leaderboardViewController = [[GKGameCenterViewController alloc] init];
    leaderboardViewController.viewState = GKGameCenterViewControllerStateLeaderboards;
    leaderboardViewController.gameCenterDelegate = self;
    [self presentViewController:leaderboardViewController animated:YES completion:nil];

}

//------------------------------------------------------------------------------------------------------------//
//------- GameCenter Scores ----------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------------//
#pragma mark - GameCenter Scores



//------------------------------------------------------------------------------------------------------------//
//------- GameCenter Achievements ----------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------------//
#pragma mark - GameCenter Achievements


- (IBAction)showAchievements {
    GKGameCenterViewController *achievementViewController = [[GKGameCenterViewController alloc] init];
    achievementViewController.viewState = GKGameCenterViewControllerStateAchievements;
    achievementViewController.gameCenterDelegate = self;
    [self presentViewController:achievementViewController animated:YES completion:nil];
    actionBarLabel.title = [NSString stringWithFormat:@"Attempting to display GameCenter achievements."];
}

- (IBAction)resetAchievements {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Really Reset ALL Achievements?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Reset Achievements" otherButtonTitles:nil];
    [actionSheet showInView:self.view];
}

//------------------------------------------------------------------------------------------------------------//
//------- GameCenter Challenges ------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------------//
#pragma mark - GameCenter Challenges

- (IBAction)loadChallenges {
    // This feature is only supported in iOS 6 and higher (don't worry - GC Manager will check for you and return NIL if it isn't available)
    [[GameCenterManager sharedManager] getChallengesWithCompletion:^(NSArray *challenges, NSError *error) {
        actionBarLabel.title = [NSString stringWithFormat:@"Loaded GameCenter challenges."];
        NSLog(@"GC Challenges: %@ | Error: %@", challenges, error);
    }];
}

//------------------------------------------------------------------------------------------------------------//
//------- GameKit Delegate -----------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------------//
#pragma mark - GameKit Delegate

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
    if (gameCenterViewController.viewState == GKGameCenterViewControllerStateAchievements) {
        actionBarLabel.title = [NSString stringWithFormat:@"Displayed GameCenter achievements."];
    } else if (gameCenterViewController.viewState == GKGameCenterViewControllerStateLeaderboards) {
        actionBarLabel.title = [NSString stringWithFormat:@"Displayed GameCenter leaderboard."];
    } else {
        actionBarLabel.title = [NSString stringWithFormat:@"Displayed GameCenter controller."];
    }
}

//------------------------------------------------------------------------------------------------------------//
//------- GameCenter Manager Delegate ------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------------//
#pragma mark - GameCenter Manager Delegate

- (void)gameCenterManager:(GameCenterManager *)manager authenticateUser:(UIViewController *)gameCenterLoginController {
    [self presentViewController:gameCenterLoginController animated:YES completion:^{
        NSLog(@"Finished Presenting Authentication Controller");
    }];
}

- (void)gameCenterManager:(GameCenterManager *)manager availabilityChanged:(NSDictionary *)availabilityInformation {
    NSLog(@"GC Availabilty: %@", availabilityInformation);
    if ([[availabilityInformation objectForKey:@"status"] isEqualToString:@"GameCenter Available"]) {
        [self.navigationController.navigationBar setValue:@"GameCenter Available" forKeyPath:@"prompt"];
        statusDetailLabel.text = @"Game Center is online, the current player is logged in, and this app is setup.";
    } else {
        [self.navigationController.navigationBar setValue:@"GameCenter Unavailable" forKeyPath:@"prompt"];
        statusDetailLabel.text = [availabilityInformation objectForKey:@"error"];
    }
    
    GKLocalPlayer *player = [[GameCenterManager sharedManager] localPlayerData];
    if (player) {
        if ([player isUnderage] == NO) {
            actionBarLabel.title = [NSString stringWithFormat:@"%@ signed in.", player.displayName];
            playerName.text = player.displayName;
            playerStatus.text = @"Player is not underage and is signed-in";
            [[GameCenterManager sharedManager] localPlayerPhoto:^(UIImage *playerPhoto) {
                playerPicture.image = playerPhoto;
            }];
        } else {
            playerName.text = player.displayName;
            playerStatus.text = @"Player is underage";
            actionBarLabel.title = [NSString stringWithFormat:@"Underage player, %@, signed in.", player.displayName];
        }
    } else {
        actionBarLabel.title = [NSString stringWithFormat:@"No GameCenter player found."];
    }
}

- (void)gameCenterManager:(GameCenterManager *)manager error:(NSError *)error {
    NSLog(@"GCM Error: %@", error);
    actionBarLabel.title = error.domain;
}

- (void)gameCenterManager:(GameCenterManager *)manager reportedAchievement:(GKAchievement *)achievement withError:(NSError *)error {
    if (!error) {
        NSLog(@"GCM Reported Achievement: %@", achievement);
        actionBarLabel.title = [NSString stringWithFormat:@"Reported achievement with %.1f percent completed", achievement.percentComplete];
    } else {
        NSLog(@"GCM Error while reporting achievement: %@", error);
    }
}

- (void)gameCenterManager:(GameCenterManager *)manager reportedScore:(GKScore *)score withError:(NSError *)error {
    if (!error) {
        NSLog(@"GCM Reported Score: %@", score);
        actionBarLabel.title = [NSString stringWithFormat:@"Reported leaderboard score: %lld", score.value];
    } else {
        NSLog(@"GCM Error while reporting score: %@", error);
    }
}

- (void)gameCenterManager:(GameCenterManager *)manager didSaveScore:(GKScore *)score {
    NSLog(@"Saved GCM Score with value: %lld", score.value);
    actionBarLabel.title = [NSString stringWithFormat:@"Score saved for upload to GameCenter."];
}

- (void)gameCenterManager:(GameCenterManager *)manager didSaveAchievement:(GKAchievement *)achievement {
    NSLog(@"Saved GCM Achievement: %@", achievement);
    actionBarLabel.title = [NSString stringWithFormat:@"Achievement saved for upload to GameCenter."];
}

//------------------------------------------------------------------------------------------------------------//
//------- UIActionSheet Delegate -----------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------------//
#pragma mark - UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"Reset Achievements"]) {
        [[GameCenterManager sharedManager] resetAchievementsWithCompletion:^(NSError *error) {
            if (error) NSLog(@"Error Resetting Achievements: %@", error);
        }];
    }
}

@end
