//
//  ViewController.m
//  VoiceDemo
//
//  Created by David on 2019/12/23.
//  Copyright © 2019 genetek. All rights reserved.
//

#import "ViewController.h"
#import "../GenetekSolution/GenetekMgr.h"

@interface ViewController ()  <AgoraRtmDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *remoteUserIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *msgTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [GenetekMgr InitSoloution:@"bc6642a5ce2c423c8419c20e2e9e239f"];
    
}

- (Boolean)checkParameters {
    if(GenetekMgr.status == LoginStatusOffline)
    {
        [self showAlert: @"用户未注册，请先注册!"];
        return false;
    }
    
    NSString *remoteUid = self.remoteUserIdTextField.text;
    if(remoteUid == nil || remoteUid.length == 0)
    {
        [self showAlert: @"请输消息接收用户ID!"];
        return false;
    }
    
    NSString *msg = self.msgTextField.text;
    if(msg == nil || msg.length == 0)
    {
        [self showAlert: @"消息不能为空！"];
        return false;
    }
    
    return true;
}

- (IBAction)callButton:(UIButton *)sender {
    //[self leaveChannel];
     NSLog(@"callButton clicked! userId: %@", self.remoteUserIdTextField.text);
    
    if(!self.checkParameters)
    {
        return;
    }
    
    NSString *msg = self.msgTextField.text;
    NSString *remoteUid = self.remoteUserIdTextField.text;
    
    [GenetekMgr phoneCall:remoteUid UserID:self.userIdTextField.text];
}

- (IBAction)tmpButton:(UIButton *)sender {
    [self showAlert: @"tmpButton"];
}
- (IBAction)regButton:(UIButton *)sender {
    //[self leaveChannel];
    NSLog(@"Reg button clicked! userId: %@",self.userIdTextField.text);
    
    if(self.userIdTextField.text.length == 0)
    {
        [self showAlert: @"请输入注册id"];
        return;
    }
    
    [GenetekMgr updateDelegate:self];
   
    [GenetekMgr.kit loginByToken:nil user:self.userIdTextField.text completion:^(AgoraRtmLoginErrorCode errorCode) {
        
        if (errorCode != AgoraRtmLoginErrorOk) {
            [self showAlert: [NSString stringWithFormat:@"login error: %ld", errorCode]];
            return;
        }
        else{
            [self showAlert: @"注册成功"];
        }
        
        //GenetekMgr.kit.agoraRtmDelegate = self;
        [GenetekMgr setStatus:LoginStatusOnline];
        
        __weak ViewController *weakSelf = self;
        
        
    }];
}

- (IBAction)sendMsgButton:(UIButton *)sender {
    //[self leaveChannel];
    NSLog(@"sendMsgButton clicked! userId: %@", self.msgTextField.text);
    
   // [self showAlert: @"helloworld"];
    
   if(!self.checkParameters)
   {
       return;
   }
    
    NSString *msg = self.msgTextField.text;
    NSString *remoteUid = self.remoteUserIdTextField.text;
    
    
    
    [GenetekMgr sendMsg:remoteUid UserID:self.userIdTextField.text MSG:msg];
    
    /*
     AgoraRtmMessage *rtmMessage = [[AgoraRtmMessage alloc] initWithText:msg];
    [GenetekMgr.kit sendMessage:rtmMessage toPeer:remoteUid
     
                   completion:^(AgoraRtmSendPeerMessageErrorCode errorCode) {
                       
                       //sent((int)errorCode);
                       if(errorCode == AgoraRtmSendPeerMessageErrorOk)
                       {
                           [self showAlert: @"消息已发送!"];
                       }
                       else
                       {
                           NSString *errNote =  [[NSString alloc] initWithString:[NSString stringWithFormat:@"消息发送失败,错误码:%d", (int)errorCode]];
                           [self showAlert: errNote];
                       }
                   }];
     */
}

#pragma mark - AgoraRtmDelegate
- (void)rtmKit:(AgoraRtmKit *)kit connectionStateChanged:(AgoraRtmConnectionState)state reason:(AgoraRtmConnectionChangeReason)reason {
    NSString *message = [NSString stringWithFormat:@"connection state changed: %ld", state];
    NSLog(message);
}
/*
// Receive one to one offline messages
- (void)rtmKit:(AgoraRtmKit *)kit messageReceived:(AgoraRtmMessage *)message fromPeer:(NSString *)peerId {
    NSLog(message.text);
}
 */

- (void)rtmKit:(AgoraRtmKit *)kit messageReceived:(AgoraRtmMessage *)message fromPeer:(NSString *)peerId
{
    NSLog(@"Message received from %@: %@", message.text, peerId);
}

@end
