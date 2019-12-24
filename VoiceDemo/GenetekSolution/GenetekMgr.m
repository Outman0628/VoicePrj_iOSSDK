//
//  GenetekMgr.m
//  VoiceDemo
//
//  Created by David on 2019/12/23.
//  Copyright © 2019 genetek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GenetekMgr.h"

static AgoraRtmKit *_kit = nil;
static LoginStatus _status = LoginStatusOffline;

@implementation GenetekMgr

+ (void) InitSoloution: (NSString *) appId{
    _kit = [[AgoraRtmKit alloc] initWithAppId:appId delegate:nil];
}

+ (AgoraRtmKit * _Nullable)kit {
    return _kit;
}

+ (LoginStatus)status {
    return _status;
}

+ (void)setStatus:(LoginStatus)status {
    _status = status;
}

/*
 RtmNotifyBean rtmCall = new RtmNotifyBean();
 rtmCall.setTitle(RtmNotifyBean.RTM_TITLE_AUDIOCALL);
 rtmCall.setAccountCaller(uerAccount);
 rtmCall.setAccountRemote(remoteAccount);
 rtmCall.setChannel(uerAccount+remoteAccount);
 */

+ (void)phoneCall: (NSString *)remoteUid  UserID:(NSString *) userId{
    
    //NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObj options:NSJSONWritingPrettyPrinted error:&error];
    //NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary * rtmNotifyBean =
    @{@"title":@"audiocall",
    @"accountCaller": userId,
    @"accountRemote":remoteUid,
    @"channel":  [NSString stringWithFormat:@"%@%@", userId, remoteUid]
    };
    
    NSError *error;
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:rtmNotifyBean options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    AgoraRtmMessage *rtmMessage = [[AgoraRtmMessage alloc] initWithText:jsonStr];
    
    [_kit sendMessage:rtmMessage toPeer:remoteUid
           
                   completion:^(AgoraRtmSendPeerMessageErrorCode errorCode) {
                       
                       //sent((int)errorCode);
                       if(errorCode == AgoraRtmSendPeerMessageErrorOk)
                       {
                          // [self showAlert: @"消息已发送!"];
                           NSLog(@"Send phone call succeed!");
                       }
                       else
                       {
                           NSString *errNote =  [[NSString alloc] initWithString:[NSString stringWithFormat:@"Send phone call failed:%d", (int)errorCode]];
                           //[self showAlert: errNote];
                           NSLog(errNote);
                       }
                   }];
}

+ (void)sendMsg: (NSString *)remoteUid  UserID:(NSString *) userId  MSG:(NSString *) msg{
    
    //NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObj options:NSJSONWritingPrettyPrinted error:&error];
    //NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary * rtmNotifyBean =
    @{@"title":@"textmsg",
      @"accountCaller": userId,
      @"accountRemote":remoteUid,
      @"channel":  [NSString stringWithFormat:@"%@%@", userId, remoteUid],
      @"data": msg
    };
    
    NSError *error;
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:rtmNotifyBean options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    AgoraRtmMessage *rtmMessage = [[AgoraRtmMessage alloc] initWithText:jsonStr];
    
    [_kit sendMessage:rtmMessage toPeer:remoteUid
     
           completion:^(AgoraRtmSendPeerMessageErrorCode errorCode) {
               
               //sent((int)errorCode);
               if(errorCode == AgoraRtmSendPeerMessageErrorOk)
               {
                   // [self showAlert: @"消息已发送!"];
                   NSLog(@"Send phone call succeed!");
               }
               else
               {
                   NSString *errNote =  [[NSString alloc] initWithString:[NSString stringWithFormat:@"Send phone call failed:%d", (int)errorCode]];
                   //[self showAlert: errNote];
                   NSLog(errNote);
               }
           }];
}

+ (void)updateDelegate:(id <AgoraRtmDelegate> _Nullable)delegate {
    _kit.agoraRtmDelegate = delegate;
}

@end
