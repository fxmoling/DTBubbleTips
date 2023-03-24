//
//  ViewController.m
//  DTBubbleTipsDemo
//
//  Created by aa on 2022/6/27.
//

#import "ViewController.h"
#import "DTBubbleTipsHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBackground)];
  [self.view addGestureRecognizer:tap];
  
  UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
  [self.view addSubview:button];
  [button setTitle:@"good" forState:UIControlStateNormal];
  button.backgroundColor = UIColor.grayColor;
  
  [button addTarget:self action:@selector(clickButton1) forControlEvents:UIControlEventTouchUpInside];
  
  UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2Button1)];
  tap2.numberOfTapsRequired = 2;
  [button addGestureRecognizer:tap2];
  
  UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(250, 250, 100, 100)];
  [self.view addSubview:button2];
  [button2 setTitle:@"good" forState:UIControlStateNormal];
  button2.backgroundColor = UIColor.grayColor;
  
  UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(200, 400, 100, 100)];
  [self.view addSubview:button3];
  [button3 setTitle:@"good" forState:UIControlStateNormal];
  button3.backgroundColor = UIColor.grayColor;
  
  DTBubbleTipsView *tipsView = [DTBubbleTipsHelper showTipsWithConfig:DTBubbleTipsCommonConfig.exampleConfig onView:button pointingToView:button];
  tipsView.userInteractionEnabled = YES;
  
  [DTBubbleTipsHelper showTipsWithConfig:DTBubbleTipsCommonConfig.exampleConfig onView:self.view pointingToView:button2];
  [DTBubbleTipsHelper showTipsWithConfig:DTBubbleTipsCommonConfig.exampleConfig onView:nil pointingToView:button3];
}

- (void)clickButton1 {
  NSLog(@"111 Click button 1.");
}

- (void)clickBackground {
  NSLog(@"Click background.");
}

- (void)tap2Button1 {
  NSLog(@"Tap 2 on button 1.");
}

@end
