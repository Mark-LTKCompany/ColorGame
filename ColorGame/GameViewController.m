//
//  GameViewController.m
//  ColorGame
//
//  Created by iOS Developer on 2013. 12. 1..
//  Copyright (c) 2013년 iOS Developer. All rights reserved.
//

#import "GameViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "GameOverViewController.h"


@interface GameViewController ()

@end

@implementation GameViewController

@synthesize time;
@synthesize gametimer;
@synthesize timer;

@synthesize question;
@synthesize Opt1setting;
@synthesize Opt2setting;
@synthesize Opt3setting;
@synthesize Opt4setting;

@synthesize sort1, sort2, sort3, sort4;
@synthesize score;
@synthesize scorelabel;
@synthesize health;

@synthesize HP1, HP2, HP3;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//game time
- (void) awakeFromNib
{
    time = 50;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //timer api
    gametimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updatetime) userInfo:nil repeats:YES];
    timer.text = [NSString stringWithFormat:@"%i", time];
    [self GameLogic];
    score=0;
    scorelabel.text=[NSString stringWithFormat:@"%i", score];
    health=3;
}

//timer logic
- (void) updatetime
{
    time = time - 1;
    if (time <=0)
    {
        [gametimer invalidate];
        
        //INSERT GAME OVER CODE
        
        [self GameOver];
        
        
    }
    
    timer.text = [NSString stringWithFormat:@"%i", time];
}


- (void) GameLogic
{
    int randomtext=arc4random()%7, randomcolor=arc4random()%7;
    int trueanswertext=arc4random()%7, trueanswercolor=arc4random()%7;
    int falseanswer1text=arc4random()%7, falseanswer1color=arc4random()%7, falseanswer2text=arc4random()%7, falseanswer2color=arc4random()%7, falseanswer3text=arc4random()%7, falseanswer3color=arc4random()%7;
    
    sort1=arc4random()%4+1, sort2=arc4random()%4+1, sort3=arc4random()%4+1, sort4=arc4random()%4+1;
    
    //정답 배열 랜덤화
    while(sort2==sort1)
    {
        sort2=arc4random()%4+1;
    }
    while(sort3==sort2||sort3==sort1)
    {
        sort3=arc4random()%4+1;
    }
    while(sort4==sort3||sort4==sort2||sort4==sort1)
    {
        sort4=arc4random()%4+1;
    }
    
    
    //문제의 색과 글씨 다르게 설정
    while(randomcolor==randomtext)
    {
        randomcolor=arc4random()%7;
    }
    
    //혹시 모를 시간차 대비, 숨기기
    [question setHidden:YES];
    [Opt1setting setHidden:YES];
    [Opt2setting setHidden:YES];
    [Opt3setting setHidden:YES];
    [Opt4setting setHidden:YES];
    
    //문제의 색과 글씨 다르게 실제로 주입
    question.text=[self ReturnColorText:randomtext];
    question.textColor=[self ReturnColorValue:randomcolor];
    
    //옳은 보기의 글씨는 문제의 실제 색과 같아야 한다
    trueanswertext=randomcolor;
    
    
    //옳은 보기의 색과 글씨 다르게 설정 (문제의 색과 글씨가, 옳은 보기의 색과 글씨가 달라야 헷갈린다.)
    while(trueanswercolor==trueanswertext)
    {
        trueanswercolor=arc4random()%7;
    }
    
    //다른 보기의 글씨는 옳은 보기의 글씨와 같으면 안된다! (복수정답 예방)
    while(falseanswer1text==trueanswertext)
    {
        falseanswer1text=arc4random()%7;
    }
    while(falseanswer2text==trueanswertext||falseanswer2text==falseanswer1text)
    {
        falseanswer2text=arc4random()%7;
    }
    while(falseanswer3text==trueanswertext||falseanswer3text==falseanswer2text||falseanswer3text==falseanswer1text)
    {
        falseanswer3text=arc4random()%7;
    }
    
    
    
    //버전1: 다른 보기의 색과 글씨가 달라야 한다
    //한계점: 같은 색이 많이 보여서 좀 안 예쁘다
    /*
    while(falseanswer1color==falseanswer1text)
    {
        falseanswer1color=arc4random()%7;
    }
    
    while(falseanswer2color==falseanswer2text)
    {
        falseanswer2color=arc4random()%7;
    }
    
    while(falseanswer3color==falseanswer3text)
    {
        falseanswer3color=arc4random()%7;
    }
    */
    
    
    
    //버전2: 보기의 색깔은 예뻐야 한다(...)
    //한계점: 글씨와 색깔이 같은 경우가 있다
    while(falseanswer1color==trueanswercolor)
    {
        falseanswer1color=arc4random()%7;
    }
    while(falseanswer2color==falseanswer1color||falseanswer2color==trueanswercolor)
    {
        falseanswer2color=arc4random()%7;
    }
    while(falseanswer3color==falseanswer2color||falseanswer3color==falseanswer1color||falseanswer3color==trueanswercolor)
    {
        falseanswer3color=arc4random()%7;
    }
    
    
    //아직 간소화할 방법 찾지 못함: 보기 랜덤 배열. 로직은, sort 1~4는 각각 버튼 1~4에 대응되는데, sort의 실제값이 보기를 집어넣게 된다.
    //즉, sort1==3이면 3번 보기가 1번에 들어가며, sort2==1이면 (1번 보기, 즉 정답)이 2번에 들어간다.
    switch (sort1)
    {
        case 1:
            [Opt1setting setTitle:[self ReturnColorText:trueanswertext] forState:(UIControlStateNormal)];
            [Opt1setting setTitleColor:[self ReturnColorValue:trueanswercolor] forState:(UIControlStateNormal)];
            break;
        case 2:
            [Opt1setting setTitle:[self ReturnColorText:falseanswer1text] forState:(UIControlStateNormal)];
            [Opt1setting setTitleColor:[self ReturnColorValue:falseanswer1color] forState:(UIControlStateNormal)];
            break;
        case 3:
            [Opt1setting setTitle:[self ReturnColorText:falseanswer2text] forState:(UIControlStateNormal)];
            [Opt1setting setTitleColor:[self ReturnColorValue:falseanswer2color] forState:(UIControlStateNormal)];
            break;
        case 4:
            [Opt1setting setTitle:[self ReturnColorText:falseanswer3text] forState:(UIControlStateNormal)];
            [Opt1setting setTitleColor:[self ReturnColorValue:falseanswer3color] forState:(UIControlStateNormal)];
            break;
    }
    switch (sort2)
    {
        case 1:
            [Opt2setting setTitle:[self ReturnColorText:trueanswertext] forState:(UIControlStateNormal)];
            [Opt2setting setTitleColor:[self ReturnColorValue:trueanswercolor] forState:(UIControlStateNormal)];
            break;
        case 2:
            [Opt2setting setTitle:[self ReturnColorText:falseanswer1text] forState:(UIControlStateNormal)];
            [Opt2setting setTitleColor:[self ReturnColorValue:falseanswer1color] forState:(UIControlStateNormal)];
            break;
        case 3:
            [Opt2setting setTitle:[self ReturnColorText:falseanswer2text] forState:(UIControlStateNormal)];
            [Opt2setting setTitleColor:[self ReturnColorValue:falseanswer2color] forState:(UIControlStateNormal)];
            break;
        case 4:
            [Opt2setting setTitle:[self ReturnColorText:falseanswer3text] forState:(UIControlStateNormal)];
            [Opt2setting setTitleColor:[self ReturnColorValue:falseanswer3color] forState:(UIControlStateNormal)];
            break;
    }
    switch (sort3)
    {
        case 1:
            [Opt3setting setTitle:[self ReturnColorText:trueanswertext] forState:(UIControlStateNormal)];
            [Opt3setting setTitleColor:[self ReturnColorValue:trueanswercolor] forState:(UIControlStateNormal)];
            break;
        case 2:
            [Opt3setting setTitle:[self ReturnColorText:falseanswer1text] forState:(UIControlStateNormal)];
            [Opt3setting setTitleColor:[self ReturnColorValue:falseanswer1color] forState:(UIControlStateNormal)];
            break;
        case 3:
            [Opt3setting setTitle:[self ReturnColorText:falseanswer2text] forState:(UIControlStateNormal)];
            [Opt3setting setTitleColor:[self ReturnColorValue:falseanswer2color] forState:(UIControlStateNormal)];
            break;
        case 4:
            [Opt3setting setTitle:[self ReturnColorText:falseanswer3text] forState:(UIControlStateNormal)];
            [Opt3setting setTitleColor:[self ReturnColorValue:falseanswer3color] forState:(UIControlStateNormal)];
            break;
    }
    switch (sort4)
    {
        case 1:
            [Opt4setting setTitle:[self ReturnColorText:trueanswertext] forState:(UIControlStateNormal)];
            [Opt4setting setTitleColor:[self ReturnColorValue:trueanswercolor] forState:(UIControlStateNormal)];
            break;
        case 2:
            [Opt4setting setTitle:[self ReturnColorText:falseanswer1text] forState:(UIControlStateNormal)];
            [Opt4setting setTitleColor:[self ReturnColorValue:falseanswer1color] forState:(UIControlStateNormal)];
            break;
        case 3:
            [Opt4setting setTitle:[self ReturnColorText:falseanswer2text] forState:(UIControlStateNormal)];
            [Opt4setting setTitleColor:[self ReturnColorValue:falseanswer2color] forState:(UIControlStateNormal)];
            break;
        case 4:
            [Opt4setting setTitle:[self ReturnColorText:falseanswer3text] forState:(UIControlStateNormal)];
            [Opt4setting setTitleColor:[self ReturnColorValue:falseanswer3color] forState:(UIControlStateNormal)];
            break;
    }
    
    //숨기기 취소
    [question setHidden:NO];
    [Opt1setting setHidden:NO];
    [Opt2setting setHidden:NO];
    [Opt3setting setHidden:NO];
    [Opt4setting setHidden:NO];
}


- (IBAction)Opt1
{
    if(sort1==1)
        score++;
    else
    {
        score--;
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        if(health==1)
        {
            HP1.text=@"";
            health--;
            [self GameOver];
        }
        else if(health==2)
        {
            HP2.text=@"";
            health--;
        }
        else if(health==3)
        {
            HP3.text=@"";
            health--;
        }
    }
    scorelabel.text=[NSString stringWithFormat:@"%i", score];
    if(score==42)
    {
    [[GameCenterManager sharedGameCenterManager] submitAchievement:kAchievement_Meaing_of_life percentComplete:100.f];
    }
    [self GameLogic];
}

- (IBAction)Opt2
{
    if(sort2==1)
        score++;
    else
    {
        score--;
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        if(health==1)
        {
            HP1.text=@"";
            health--;
            [self GameOver];
        }
        else if(health==2)
        {
            HP2.text=@"";
            health--;
        }
        else if(health==3)
        {
            HP3.text=@"";
            health--;
        }
        

    }
    scorelabel.text=[NSString stringWithFormat:@"%i", score];
    if(score==42)
    {
        [[GameCenterManager sharedGameCenterManager] submitAchievement:kAchievement_Meaing_of_life percentComplete:100.f];
    }
    [self GameLogic];
}

- (IBAction)Opt3
{
    if (sort3==1)
        score++;
    else
    {
        score--;
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        if(health==1)
        {
            HP1.text=@"";
            health--;
            [self GameOver];
        }
        else if(health==2)
        {
            HP2.text=@"";
            health--;
        }
        else if(health==3)
        {
            HP3.text=@"";
            health--;
        }

    }
    
    scorelabel.text=[NSString stringWithFormat:@"%i", score];
    if(score==42)
    {
        [[GameCenterManager sharedGameCenterManager] submitAchievement:kAchievement_Meaing_of_life percentComplete:100.f];
    }
    [self GameLogic];
}

- (IBAction)Opt4
{
    if(sort4==1)
        score++;
    else
    {
        score--;
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        if(health==1)
        {
            HP1.text=@"";
            health--;
            [self GameOver];
        }
        else if(health==2)
        {
            HP2.text=@"";
            health--;
        }
        else if(health==3)
        {
            HP3.text=@"";
            health--;
        }

    }
    scorelabel.text=[NSString stringWithFormat:@"%i", score];
    if(score==42)
    {
        [[GameCenterManager sharedGameCenterManager] submitAchievement:kAchievement_Meaing_of_life percentComplete:100.f];
    }
    [self GameLogic];
}

- (NSString*)ReturnColorText:(int)i
{
    NSString* value;
    
    switch (i)
    {
        case 0: value=@"RED";
            break;
        case 1: value=@"GREEN";
            break;
        case 2: value=@"BLUE";
            break;
        case 3: value=@"BLACK";
            break;
        case 4: value=@"YELLOW";
            break;
        case 5: value=@"PURPLE";
            break;
        case 6: value=@"SILVER";
    }
    return value;
}

- (UIColor*)ReturnColorValue:(int)i
{
    UIColor* value;
    
    switch (i)
    {
        case 0: value = [UIColor redColor];
            break;
        case 1: value = [UIColor greenColor];
            break;
        case 2: value = [UIColor blueColor];
            break;
        case 3: value = [UIColor blackColor];
            break;
        case 4: value = [UIColor yellowColor];
            break;
        case 5: value = [UIColor purpleColor];
            break;
        case 6: value = [UIColor colorWithRed:0.854 green:0.854 blue:0.854 alpha:1];
    }
    return value;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)GameOver
{
    if(score==-3)
    {
        [[GameCenterManager sharedGameCenterManager] submitAchievement:kAchievement_Under_Achiever percentComplete:100.f];
    }
    if(score==0)
    {
        [[GameCenterManager sharedGameCenterManager] submitAchievement:kAchievement_Risk_Aversion percentComplete:100.f];
    }
    //Load highscore, compare, and save new highscore if necessary
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *highscore = [defaults objectForKey:@"scoretosave"];
    if(score>[highscore intValue])
    {
        NSNumber *scoretosave=[NSNumber numberWithInt:score];
        [defaults setObject:scoretosave forKey:@"scoretosave"];
        [defaults synchronize];
        //without the code below, the highscore will only be updated next time, because NSNumber highscore is based on previous value
        highscore = [NSNumber numberWithInt:score];
        [[GameCenterManager sharedGameCenterManager] submitScore:self.score forLeaderboard:kLeaderboard_1];
    }
    
    GameOverViewController *GameOverViewController =
    [self.storyboard instantiateViewControllerWithIdentifier:@"GameOverViewController"];
    GameOverViewController.score=[NSString stringWithFormat:@"%i", score];
    GameOverViewController.highscore=[highscore intValue];
    [self presentViewController:GameOverViewController animated:YES completion:nil];
    
    
    //[self dismissViewControllerAnimated:YES completion:nil];
}




@end
