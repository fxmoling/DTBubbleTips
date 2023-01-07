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
  
  UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
  [self.view addSubview:button];
  [button setTitle:@"good" forState:UIControlStateNormal];
  button.backgroundColor = UIColor.grayColor;
  
  [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
  
  UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(250, 250, 100, 100)];
  [self.view addSubview:button2];
  [button2 setTitle:@"good" forState:UIControlStateNormal];
  button2.backgroundColor = UIColor.grayColor;
  
  UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(200, 400, 100, 100)];
  [self.view addSubview:button3];
  [button3 setTitle:@"good" forState:UIControlStateNormal];
  button3.backgroundColor = UIColor.grayColor;
  
  [DTBubbleTipsHelper showTipsWithConfig:DTBubbleTipsCommonConfig.exampleConfig pointingToView:button spacing:3];
  [DTBubbleTipsHelper showTipsWithConfig:DTBubbleTipsCommonConfig.exampleConfig pointingToView:button2 spacing:3];
  [DTBubbleTipsHelper showTipsWithConfig:DTBubbleTipsCommonConfig.exampleConfig pointingToView:button3 spacing:3];
}

- (void)clickButton {
  NSLog(@"123");
}


@end
