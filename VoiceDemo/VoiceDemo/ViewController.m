//
//  ViewController.m
//  VoiceDemo
//
//  Created by David on 2019/12/23.
//  Copyright © 2019 genetek. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *remoteUserIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *msgTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)callButton:(UIButton *)sender {
    //[self leaveChannel];
     NSLog(@"callButton clicked! userId: %@", self.remoteUserIdTextField.text);
}

- (IBAction)regButton:(UIButton *)sender {
    //[self leaveChannel];
    NSLog(@"Reg button clicked! userId: %@",self.userIdTextField.text);
}

- (IBAction)sendMsgButton:(UIButton *)sender {
    //[self leaveChannel];
    NSLog(@"sendMsgButton clicked! userId: %@", self.msgTextField.text);
}

@end
