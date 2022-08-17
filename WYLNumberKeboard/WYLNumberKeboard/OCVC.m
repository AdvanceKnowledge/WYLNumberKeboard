//
//  OCVC.m
//  WYLNumberKeboard
//
//  Created by 王延磊 on 2022/7/26.
//

#import "OCVC.h"
#import "WYLNumberKeboard-Swift.h"
#import "Masonry.h"
@interface OCVC ()
@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property (strong, nonatomic) UITextView *myTextView;
@end

@implementation OCVC
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    WYLNumberKeyboardView *keyBoard = [[WYLNumberKeyboardView alloc] init:self.myTextField :nil :^(id _Nullable any) {
        NSLog(@"提现");
    }];
    _myTextField.inputView = keyBoard;
    _myTextView = [[UITextView alloc]init];
    _myTextView.scrollEnabled = NO;
    _myTextView.backgroundColor = [UIColor redColor];
    _myTextView.inputView = [[WYLNumberKeyboardView alloc] init:nil :self.myTextView :^(id _Nullable any) {
        NSLog(@"提现");
    }];
    
    [self.view addSubview:_myTextView];
    [_myTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.offset(-20);
        make.top.equalTo(_myTextField.mas_bottom).offset(400);
        make.height.mas_greaterThanOrEqualTo(50);
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
