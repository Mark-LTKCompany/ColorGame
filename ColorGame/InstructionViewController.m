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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resetAchievements
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Really Reset ALL Achievements?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Reset Achievements" otherButtonTitles:nil];
    [actionSheet showInView:self.view];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *scoretosave=[NSNumber numberWithInt:0];
    [defaults setObject:scoretosave forKey:@"scoretosave"];
    [defaults synchronize];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"Reset Achievements"]) {
        [[GameCenterManager sharedManager] resetAchievementsWithCompletion:^(NSError *error) {
            if (error) NSLog(@"Error Resetting Achievements: %@", error);
        }];
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
    }

}

@end
