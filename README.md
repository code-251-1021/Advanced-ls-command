***

# final.sh

A simple tool to list files and directories. I created this because the standard `ls` command can be a bit messy. This script helps me see exactly what I need quickly.

## How it works

You can use this tool to filter files or directories easily. Just run:

```bash
./final.sh [OPTION] [PATH]
```

### Options

| Option | What it does |
| :--- | :--- |
| `-f` | Show only files (names only) |
| `-d` | Show only directories (names only) |
| `-a` | Show everything with full details |
| `-p` | Show file permissions |
| `-h` | Show help and exit |

### Combined Options

I added these to make it faster to get specific information:

*   `-fa` or `-af`: List files with full details.
*   `-da` or `-ad`: List directories with full details.

## Installation

If you want to use `final` as a regular command, follow these steps:

1. Make the installer script executable:
   ```bash
   chmod +x installer.sh
   ```
2. Run the installer:
   ```bash
   ./installer.sh
   ```

After that, you can use `final` directly from your terminal.

---

*Built by [Amir Rezaei]*
3.  **وضوح:** جداول و دستورات همان‌طور که می‌خواستی مرتب و تمیز هستند تا کاربر در کمتر از ۱۰ ثانیه بفهمد جریان چیست.

اگر دوست داشتی کلمه یا جمله خاصی رو تغییر بدم (مثلاً اگر می‌خوای یه کم لحنش صمیمی‌تر یا فنی‌تر بشه)، حتماً بهم بگو! چطوره
