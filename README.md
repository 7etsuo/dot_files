![Repository Preview](https://github.com/user-attachments/assets/1437441f-88a9-4be8-ba07-ddf53e4f1206)

```c
(x.com/@7etsuo) - 2024 :: DOTFILES ::
▄▄▄█████▓▓█████▄▄▄█████▓  ██████  █    ██  ▒█████  
▓  ██▒ ▓▒▓█   ▀▓  ██▒ ▓▒▒██    ▒  ██  ▓██▒▒██▒  ██▒
▒ ▓██░ ▒░▒███  ▒ ▓██░ ▒░░ ▓██▄   ▓██  ▒██░▒██░  ██▒
░ ▓██▓ ░ ▒▓█  ▄░ ▓██▓ ░   ▒   ██▒▓▓█  ░██░▒██   ██░
  ▒██▒ ░ ░▒████▒ ▒██▒ ░ ▒██████▒▒▒▒█████▓ ░ ████▓▒░
  ▒ ░░   ░░ ▒░ ░ ▒ ░░   ▒ ▒▓▒ ▒ ░░▒▓▒ ▒ ▒ ░ ▒░▒░▒░ 
    ░     ░ ░  ░   ░    ░ ░▒  ░ ░░░▒░ ░ ░   ░ ▒ ▒░ 
  ░         ░    ░      ░  ░  ░   ░░░ ░ ░ ░ ░ ░ ▒  
            ░  ░              ░     ░         ░ ░  
```

To install JetBrains Mono Nerd Font, follow these steps:

1. Download Nerd Fonts from the jetBrains website : https://www.jetbrains.com/lp/mono/
2. Extract the contents of the downloaded zip file.
3. Move the extracted font files to /usr/share/fonts/TTF/:
```bash
sudo mv path/to/extracted/fonts/*.ttf /usr/share/fonts/TTF/
```
4. Update the font cache:
```bash
sudo fc-cache -fv
```
5. Verify the installation:
```bash
fc-list | grep "JetBrains Mono Nerd Font"
```

![image](https://github.com/user-attachments/assets/d88d85b6-6512-4a0c-9985-5ec223f2e7b5)
