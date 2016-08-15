//
//  ViewController.m
//  YTZG
//
//  Created by 李 恒 on 16/7/12.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "ViewController.h"
#import "MainViewController.h"
@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *Usertextfeild;//账号
@property (weak, nonatomic) IBOutlet UITextField *Passtesxtfeild;//密码
@property (weak, nonatomic) IBOutlet UIButton *LoginBT;//登陆

@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated
{
    //设置导航栏半透明为NO
    self.navigationController.navigationBar.translucent = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    //标题
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationItem.title = @"登陆";
    
    //设置rightBarButtonItem
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithTitle:@"岱山" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
    
    
    //设置用户信息登录
    self.LoginBT.layer.masksToBounds =YES;
    self.LoginBT.layer.cornerRadius = 4;
    self.LoginBT.backgroundColor = [UIColor colorWithRed:0.19 green:0.53 blue:0.90 alpha:1.0];
    
    self.Usertextfeild.backgroundColor = [UIColor whiteColor];
    self.Usertextfeild.layer.masksToBounds =YES;
    self.Usertextfeild.layer.cornerRadius = 4;
//    self.Usertextfeild.layer.borderColor = [UIColor blackColor].CGColor;
//    self.Usertextfeild.layer.borderWidth = 1;
    
    self.Passtesxtfeild.backgroundColor = [UIColor whiteColor];
    self.Passtesxtfeild.layer.masksToBounds =YES;
    self.Passtesxtfeild.layer.cornerRadius = 4;
//    self.Passtesxtfeild.layer.borderColor = [UIColor blackColor].CGColor;
//    self.Passtesxtfeild.layer.borderWidth = 1;
    
    //textfeild点击事件
    self.Usertextfeild.delegate = self;
    self.Passtesxtfeild.delegate = self;
    
    //点击view
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickView)];
    [self.view addGestureRecognizer:tap];
}


- (void)clickView {
    [self.Usertextfeild resignFirstResponder];
    [self.Passtesxtfeild resignFirstResponder];

}

///键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    //计算出键盘顶端到passtextfeild底端的距离
    CGFloat offset = (self.Passtesxtfeild.frame.origin.y+self.Passtesxtfeild.frame.size.height+70) - (self.view.frame.size.height - kbHeight);
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}

///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    }];
    
}




//登录
- (IBAction)MainVCsender:(id)sender {
    MainViewController *mainMenu = [[MainViewController alloc]init];
    [self.navigationController pushViewController:mainMenu animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
