//
//  InstructionViewController.m
//  ColorGame
//
//  Created by iOS Developer on 2013. 12. 1..
//  Copyright (c) 2013년 iOS Developer. All rights reserved.
//

#import "InstructionViewController.h"

@interface InstructionViewController ()

@end

@implementation InstructionViewController

@synthesize Frenzylabelstate;
@synthesize Timeattacklabelstate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *FrenzySetting = [defaults objectForKey:@"FrenzySetting"];
    if([FrenzySetting intValue]==1)
        Frenzylabelstate.on=YES;
    else
        Frenzylabelstate.on=NO;
    NSNumber *Timeattacksetting = [defaults objectForKey:@"TimeattackSetting"];
    if([Timeattacksetting intValue]==1)
        Timeattacklabelstate.on=YES;
    else
        Timeattacklabelstate.on=NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resetAchievements
{
    //Game center actual achievement 초기화
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Really Reset ALL Achievements?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Reset Achievements" otherButtonTitles:nil];
    [actionSheet showInView:self.view];
    
    
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"Reset Achievements"])
    {
        [[GameCenterManager sharedManager] resetAchievementsWithCompletion:^(NSError *error)
        {
            if (error) NSLog(@"Error Resetting Achievements: %@", error);
        }];
        
        //Local score 초기화 (게임센터는 현재 불가능)
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSNumber *scoretosave=[NSNumber numberWithInt:0];
        [defaults setObject:scoretosave forKey:@"scoretosave"];
        [defaults synchronize];
        
        //Local Achievement도 초기화
        NSNumber *under_achiever=[NSNumber numberWithInt:0];
        [defaults setObject:under_achiever forKey:@"Under_Achiever"];
        [defaults synchronize];
        NSNumber *meaning_of_life=[NSNumber numberWithInt:0];
        [defaults setObject:meaning_of_life forKey:@"Meaning_of_life"];
        [defaults synchronize];
        NSNumber *risk_aversion=[NSNumber numberWithInt:0];
        [defaults setObject:risk_aversion forKey:@"Risk_Aversion"];
        [defaults synchronize];
        NSNumber *groovy=[NSNumber numberWithInt:0];
        [defaults setObject:groovy forKey:@"Groovy"];
        [defaults synchronize];
    }
}
- (IBAction)FRENZYlabel:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *FrenzySetting = [defaults objectForKey:@"FrenzySetting"];
    
    if([FrenzySetting intValue]==1)
    {
        FrenzySetting=[NSNumber numberWithInt:0];
        [defaults setObject:FrenzySetting
                     forKey:@"FrenzySetting"];
        [defaults synchronize];
    }
    else
    {
        FrenzySetting=[NSNumber numberWithInt:1];
        [defaults setObject:FrenzySetting
                     forKey:@"FrenzySetting"];
        [defaults synchronize];
        
        NSNumber *groovy = [defaults objectForKey:@"Groovy"];
        
        if([[GameCenterManager sharedManager] progressForAchievement:@"Groovy"]!=100||[groovy intValue]!=1)
        {
            [[GameCenterManager sharedManager] saveAndReportAchievement:@"Groovy" percentComplete:100 shouldDisplayNotification:YES];
        }
        else
        {
            [[GameCenterManager sharedManager] saveAndReportAchievement:@"Groovy" percentComplete:100 shouldDisplayNotification:NO];
        }
        groovy=[NSNumber numberWithInt:1];
        [defaults setObject:groovy forKey:@"Groovy"];
        [defaults synchronize];
    }
    
    
}

- (IBAction)TimeAttacklabel:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *Timeattacksetting = [defaults objectForKey:@"TimeattackSetting"];
    
    if([Timeattacksetting intValue]==1)
    {
        Timeattacksetting=[NSNumber numberWithInt:0];
        [defaults setObject:Timeattacksetting
                     forKey:@"TimeattackSetting"];
        [defaults synchronize];
    }
    else
    {
        Timeattacksetting=[NSNumber numberWithInt:1];
        [defaults setObject:Timeattacksetting
                     forKey:@"TimeattackSetting"];
        [defaults synchronize];
    }

}


@end
