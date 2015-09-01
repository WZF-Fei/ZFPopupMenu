# ZFPopupMenu
popupMenu can support for the layout type of Horizontal or Vertical.

##How to user ZFPopupMenu?

add the "ZFPopupMenu" folder in your project.

##Create Horizontal popupMenu.
# 1. create PopupMenuItem
```obj-c
    ZFPopupMenuItem *item1 = [ZFPopupMenuItem initWithMenuName:@"新建"
                                                         image:[UIImage imageNamed:@"图标1"]
                                                        action:@selector(test1)
                                                        target:self];
```
# 2. ZFPopupMenu init
```obj-c
ZFPopupMenu *popupMenu = [[ZFPopupMenu alloc] initWithItems:[self menuItems]];
[popupMenu showInView:self.view fromRect:fromRect layoutType:Horizontal];
``` 
