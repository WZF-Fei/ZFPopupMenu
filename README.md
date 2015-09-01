# ZFPopupMenu
popupMenu can support for the layout type of Horizontal or Vertical.

##How to user ZFPopupMenu?

add the "ZFPopupMenu" folder in your project.

##Create Horizontal popupMenu.
### 1. create PopupMenuItem
```obj-c
ZFPopupMenuItem *item1 = [ZFPopupMenuItem initWithMenuName:@"新建"
                                                     image:[UIImage imageNamed:@"图标1"]
                                                    action:@selector(test1)
                                                    target:self];
```
### 2. ZFPopupMenu init
Horizontal:
```obj-c
ZFPopupMenu *popupMenu = [[ZFPopupMenu alloc] initWithItems:[self menuItems]];
[popupMenu showInView:self.view fromRect:fromRect layoutType:Horizontal];
``` 
Vertical:
```obj-c
ZFPopupMenu *popupMenu = [[ZFPopupMenu alloc] initWithItems:[self menuItems]];
[popupMenu showInView:self.view fromRect:fromRect layoutType:Vertical];
``` 
##Set ZFPopupMenu Porterty.
### SetTextColor

```obj-c
[ZFPopupMenu setTextColorWithRed:1 green:1 blue:1 aphla:1.0];
```
### SetBackgroundColor

```obj-c
[ZFPopupMenu setMenuBackgroundColorWithRed:0.6 green:0.4 blue:0.2 aphla:1];
```

### SetHighlightedImage
```obj-c
[ZFPopupMenu setHighlightedImage:[UIImage imageNamed:@"cancelBg"]];
```

### SetAphla
```obj-c
[ZFPopupMenu setMenuBackgroundColorWithRed:0 green:0 blue:0 aphla:0.2];
```
### SetSeparationLineColor
```obj-c
[ZFPopupMenu setSeparationLineColor:[UIColor grayColor]];
```
