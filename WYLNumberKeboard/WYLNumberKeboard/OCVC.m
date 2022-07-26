//
//  OCVC.m
//  WYLNumberKeboard
//
//  Created by 王延磊 on 2022/7/26.
//

#import "OCVC.h"
#import "WYLNumberKeboard-Swift.h"
@interface OCVC ()
@property (weak, nonatomic) IBOutlet UITextField *myTextField;

@end

@implementation OCVC
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    WYLNumberKeyboardView *keyBoard = [[WYLNumberKeyboardView alloc] init:self.myTextField :nil :^(id _Nullable) {
        NSLog(@"提现");
    }];
    _myTextField.inputView = keyBoard;
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
