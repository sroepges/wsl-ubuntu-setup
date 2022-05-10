# wsl-setup

## Install WSL

Open the Powsershell and type:

```shell
wsl --install -d Ubuntu
```

## Update & Upgrade script

We start with adding a update script to Linux, so we can simply update the whole system with one command.

```shell
sudo nano /usr/bin/update
```

The script looks like this:

```shell
#!/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt dist-upgrade -y
sudo apt autoremove -y
```

Just copy the script with the button in the top right corner and paste it into nano. Press CTRL + X and then Y + ENTER.
Make the script executable by typing

```shell
sudo chmod +x /usr/bin/update
```

Now you can just use the command `update` and type in the admin password.

## Oh My Zsh

First install the zsh shell with the command:

```shell
sudo apt install zsh -y
```

Then install ohmyzsh:

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

When asked if you want to with to the zsh shell press Y + ENTER.

## Node Version Manager

First install the node version manager and then install the node lts version.

```shell
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source ~/.zshrc
nvm install --lts
```

Now enable yarn as an alternative to npm.

```shell
corepack enable
```

## Git & GitHub

### Git

Install the newest git version:

```shell
sudo apt install git -y
```

Add your git credentials to your config file:

```shell
git config --global user.name "John Doe"
git config --global user.email johndoe@example.com
```

### SSH

Add SSH to connect to GitHub without entering the username and password.

```shell
ssh-keygen -t ed25519 -C "your_email@example.com"
```

> Enter a file in which to save the key (/home/you/.ssh/algorithm): **[Press enter]**
>
> Enter passphrase (empty for no passphrase): **[Type a passphrase]**
>
> Enter same passphrase again: **[Type passphrase again]**

Add the ssh key to the ssh agent:

```shell
ssh-add ~/.ssh/id_ed25519
```

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

### GPG & VS-Code

If you use WSL in combination with VS-Code, you need to setup the GPG pinentry dialog for Windows.

Install the simple installer of the current GnuPG:

[GnuPG - Download Page](https://www.gnupg.org/download/index.html)

[GnuPG - Direct Download Link v.2.3.6](https://www.gnupg.org/ftp/gcrypt/binary/gnupg-w32-2.3.6_20220425.exe)

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

### Keychain

We use the Keychain to save the passphrase to our SSH key, so we don't have to type it with every git command.

Install the keychain tool for Ubuntu:

```shell
sudo apt install keychain
```

Open the zsh shell config and append the following code:

```shell
nano ~/.zshrc
```

```shell
### START-Keychain ###
hs=`hostname`
# Let  re-use ssh-agent and/or gpg-agent between logins
/usr/bin/keychain $HOME/.ssh/id_ed25519
source $HOME/.keychain/$hs-sh
### End-Keychain ###
```

### GitHub CLI

Install the CLI:

```shell
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh
```

Upgrading the CLI:

```shell
sudo apt update
sudo apt install gh
```

Login with GitHub Account:

```shell
gh auth login
```

> What account do you want to log into? **[GitHub.com]**
>
> What is your preferred protocol for Git operations? **[SSH]**
>
> Upload your SSH public key to your GitHub account? **[/home/user/.ssh/id_ed25519.pub]**
>
> How would you like to authenticate GitHub CLI? **[Login with a web browser]**
>
> First copy your one-time code: **[aaaa-bbbb]**
>
> Press Enter to open github.com in your browser...

Continue the setup in your browser and test the ssh connection:

```shell
ssh -T git@github.com
```
