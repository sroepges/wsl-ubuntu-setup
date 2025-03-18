# wsl-ubuntu-setup

## Install WSL

Open the Powsershell as admin and run the following command:

```shell
wsl --install
```

[Microsoft Docs](https://learn.microsoft.com/en-us/windows/wsl/install)

## (Optional) Install Windows Terminal

via MS Store:

[Windows Terminal](https://apps.microsoft.com/detail/9n0dx20hk701)

via winget:

```shell
winget install -e --id Microsoft.WindowsTerminal
```

## Clone the repo and run the setup script

```shell
git clone https://github.com/sroepges/wsl-ubuntu-setup.git &&
cd wsl-setup &&
bash run.sh
```

## (Optional) Additional setup

### GPG

Generate a new GPG key pair:

```shell
gpg --full-generate-key
```

> Please select what kind of key you want: **[ENTER]**
>
> What keysize do you want? **[4096]**
>
> Key is valid for? **[ENTER]**

List the long form of the gpg key pair:

```shell
gpg --list-secret-keys --keyid-format=long
```

Add the gpg key pair to your git config:

```shell
git config --global user.signingkey GPG-KEY-ID
```

If you want to automatically sign your commits use:

```shell
git config --global commit.gpgSign true
```

Add this line to your `.zshrc` file:

```shell
[ -f ~/.zshrc ] && echo 'export GPG_TTY=$(tty)' >> ~/.zshrc
```

```shell
gpg --armor --export GPG-KEY-ID
```

Now we add the gpg key pair to github in the browser under your settings page.

---

### GPG & VS-Code

If you use WSL in combination with VS-Code, you need to setup the GPG pinentry dialog for Windows.

Install the simple installer of the current GnuPG:

[GnuPG - Download Page](https://www.gnupg.org/download/index.html#binary)

[GnuPG - Direct Download Link v.2.4.7](https://www.gnupg.org/ftp/gcrypt/binary/gnupg-w32-2.4.7_20241125.exe)

Edit the gpg-agent config so it shows the pinentry dialog in Windows:

```shell
nano ~/.gnupg/gpg-agent.conf
```

Paste the following inside:

```shell
default-cache-ttl 34560000
max-cache-ttl 34560000
pinentry-program "/mnt/c/Program Files (x86)/gnupg/bin/pinentry-basic.exe"
```

Restart the gpg agent:

```shell
gpgconf --kill gpg-agent
```
