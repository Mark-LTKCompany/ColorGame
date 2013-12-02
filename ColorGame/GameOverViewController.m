//
//  GameOverViewController.m
//  ColorGame
//
//  Created by iOS Developer on 2013. 12. 1..
//  Copyright (c) 2013년 iOS Developer. All rights reserved.
//

#import "GameOverViewController.h"



@interface GameOverViewController ()

@end

@implementation GameOverViewController

@synthesize scorelabel;
@synthesize score;
@synthesize highscorelabel;
@synthesize highscore;


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
    
    scorelabel.text=score;
    highscorelabel.text=[NSString stringWithFormat:@"%i", highscore];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
