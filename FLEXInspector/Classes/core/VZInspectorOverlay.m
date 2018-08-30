//
//  VZInspectorOverlay.m
//  VZInspector
//
//  Created by moxin.xt on 14-9-23.
//  Copyright (c) 2014年 VizLab. All rights reserved.
//

#import "VZInspectorOverlay.h"
#import "VZInspector.h"
#import "VZInspectorResource.h"
#import "FLEX.h"

@implementation VZInspectorOverlay

+ (instancetype)sharedInstance
{
    static VZInspectorOverlay* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        int x = [UIScreen mainScreen].bounds.size.width > 320 ? 250 :180 ;
        instance = [[VZInspectorOverlay alloc]initWithFrame:CGRectMake(x, 0, 60, 20)];
    });
    return instance;
    
}

+(void)show
{
    VZInspectorOverlay* o = [self sharedInstance];
    o.tag = 100;
    o.windowLevel = UIWindowLevelStatusBar+1;
    o.hidden = NO;
    
    //flex
    NSString* imageStr= @"iVBORw0KGgoAAAANSUhEUgAAADwAAAA8CAYAAAA6/NlyAAAAAXNSR0IArs4c6QAAABxpRE9UAAAAAgAAAAAAAAAeAAAAKAAAAB4AAAAeAAAC0RVI5j4AAAKdSURBVGgF7Ji/axRBFMdjJCIIJmBlJ3bGRoRgCsFKO20UrfwLgkVsrNSrY3JnIWJAiLiNBG1SxJ29QCo7YxDcmctJkk4kRTiCyu2sl+d3dnOwFy63c7mdWZU7GPZuf7zv9zNvZmfeDQz0P/0e6PdAXj1A/vwxKdxnoWCP8/JgTZdo/ihA30rBSLVQeNesiechJIU33YTdO67k4cOKZsDZnX2wUZYlL49bMWBTJPAXRwH7ox1wKNxHNr0Y16KviycBKtrBRuc4c4ybsCVAREfwYnp3IGz04mILtvwY1wm597ATbHzNnTNuxIZAveLdAFAjFZizSRt+jGpIn10C6M9UWAzpwHfPGzVjOnhQLZ8D6JYOLO75aNqP0fgqW4D4rglLQYXdMmrIZHDpexcAqptZkhW2SlQYNOnJWOy6YNcBu6ObWdzX+Cd3WLS5fDwQ7AkAdruAxZbSmzbW+6YCh5xdBWS1O1BVJbmfVIloylfmcYm7pzH/3nQPGpWEtXp16WzmpkwEVLUsIO+h1Q4JS5K7d014S41Js7NDVHIuUtG5TTPOTfW700Ny7f0YIFcODbpX8CtgVUx00sr0GpXmzgDyJVoNjRJtqp1QVOlw9hyg6VvEJlT6MUS8D6iPp9T2k8TSqXbaPZ2jQmEQmSwAMEhAJoH9/QLhWvkyjG32nNX0DlBv+C+qA1BZXel5bVYlGiBfHQAaQ5ec7SRwyN0HMPHbAmz8r0drp2wofVpdHkl60v5OxdeTHWHjoV1rBsQ8e5oTaAs81vdvaulr+tI6Ys6OAHZHA3hXBZTcm/gbYBMefnVVTWHe3teAjYc1hj6E9PfCrcOwJTsJw1mcf6GVXXUTlh5PG3i9PJyx0SxgVQyhD1x0tv4D4AZ9ZieS0H8AAAD//2mX/m8AAAI7SURBVO3ZwUtUQRgAcMmgDFI6B961QPoDig5FlyDwJCZeCiS8RB4iOrRHodoNr51an4f2IJiyO/Me4iU7WYHwZt6yRUiHyFOXkplZ/fyeJ0dmx+Hhbm8HFz7Y75vHvO83b98ub7anx/CCQuEMFOfBOb5HA5JTyGXE0TUDUS/BbGXAGZsuTI7BTU7v6jpD5hNYJOGEgaiXfALLhD7SdYbMKzALHxqIesknsOBkXNcZMp/Aikd3DES95BNYxNVhXWfIPALvwsbyBQNRL/kDJnVd1iLzBszC9y2Ietkj8LQua5H5AhYxudKCqJe9ADP6TVdZMh/AgtOXFqI+5ANY1smIrrJkMBf0d/nj4WcLzzyE4D1ndN6ehxl9YFZZqojd6kYw3ru/4OenPgvNPASloOIM/rF2Hrd3mnnY4lE8fGIWHVOFYjDuCk6nkklYzgF4K9PVTQFQWDuL4IYDunlwfKN6DsHB/0QLRsfSXjK/4M3CDQSLY9B/Dp9AJOSeZJR1Go73bu1wH5nfQ6k8iuAdC3r76OQAlV7Ba6OIjjB2O4D//a++evloH5lzeBUMI/gDhumnat028U4cDSpOZhD9sU14oWJy3dZD5jG82kPwuvwM4YsYX6E0vwGld7dcJ4TNlUsHH3lOi5KTLyewAHvSZZPOtcF2HweNar/itZuSkccyIW9xAdYxtjFc/sX4KxJ6v909dmR+SJYu4jfuVcXobVyMScnDKcXIU8XpC9xYn1UJfZ7eKh1p5vQkXbYC+5jsqbMgGWftAAAAAElFTkSuQmCC";
    NSData*  imageData = [[NSData alloc]initWithBase64EncodedString:imageStr options:0];
    UIImage* image=[UIImage imageWithData:imageData];
    
    VZInspectorToolItem *netItem = [VZInspectorToolItem itemWithName:@"flex" icon:image callback:^{
        if ([VZInspector isShow]) {
            [VZInspector hide];
            [[FLEXManager sharedManager]showExplorer];
        }
    }];
    [VZInspector addToolItem:netItem];
}

+(void)hide
{
    for (UIWindow* window in [UIApplication sharedApplication].windows) {
        if ([window isKindOfClass:[VZInspectorOverlay class]]) {
            window.hidden = YES;
            break;
        }
    }
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if ( self )
    {
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView* imgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        imgv.contentMode = UIViewContentModeScaleAspectFit;
        imgv.image = [VZInspectorResource eye];
        imgv.userInteractionEnabled = true;
        [imgv addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onSelfClicked:)]];
        [self addSubview:imgv];
        
    }
    return self;
}

- (void)onSelfClicked:(UIButton* )sender
{
    if([VZInspector isShow])
        [VZInspector hide];
    else
        [VZInspector show];
}

- (void)becomeKeyWindow
{
    //fix keywindow problem:
    //UIActionSheet在close后回重置keywindow，防止自己被设成keywindow
    [[[UIApplication sharedApplication].delegate window] makeKeyWindow];
}


@end
