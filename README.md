# gtk-theme
`gtk-theme` is a simple shell script which lets you apply GTK theme, GTK icon theme and X cursor theme globally, without side effects such as one application still using Adwaita theme while other ones using specified theme or cursor chaging size/theme when you hover over different applications.

It uses gsettings and also writes settings to GTK 2 and GTK 3 configuration files.

```
Usage:
  gtk-theme [theme-name]
  gtk-theme -i [icon-theme-name]
  gtk-theme -c [cursor-theme-name] [cursor-theme-size]
```
