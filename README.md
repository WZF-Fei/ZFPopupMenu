# ZFPopupMenu
popupMenu can support for the layout type of Horizontal or Vertical.

##How to user ZFPopupMenu?

copy the "ZFPopupMenu" folder in your project.

##Create Horizontal popupMenu.

```obj-c
ZFPopupMenu *popupMenu = [[ZFPopupMenu alloc] initWithItems:[self menuItems]];
[popupMenu showInView:self.view fromRect:fromRect layoutType:Horizontal];
``` 
