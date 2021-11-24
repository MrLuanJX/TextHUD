# TextHUD

TextHUD


pod 'TextHUD'

#import "TextHUD"


*使用方法

*show

[TextHUD showInWindowWithDuration:2 Text:@"这是一个纯文本的HUD"];

[TextHUD showIn:self.view text:@"这是一个纯文本的HUD"];

[TextHUD showIn:self.view Duration:2 Text:@"这是一个纯文本的HUD"];

*hidden

[TextHUD hideIn:self.view];

[TextHUD dismiss];