set dotfiles=%USERPROFILE%\dev\dotfiles

if not exist %USERPROFILE%\.local\bin mkdir -p %USERPROFILE%\.local\bin

if exist %USERPROFILE%\.gitconfig del %USERPROFILE%\.gitconfig
mklink %USERPROFILE%\.gitconfig %dotfiles%\git\.gitconfig
if exist %USERPROFILE%\.githelpers del %USERPROFILE%\.githelpers
mklink %USERPROFILE%\.githelpers %dotfiles%\git\.githelpers
if exist %USERPROFILE%\.local\bin\git_diff_wrapper del %USERPROFILE%\.local\bin\git_diff_wrapper
mklink %USERPROFILE%\.local\bin\git_diff_wrapper %dotfiles%\git\git_diff_wrapper
if exist %USERPROFILE%\.bashrc del %USERPROFILE%\.bashrc
mklink %USERPROFILE%\.bashrc %dotfiles%\bash\.bashrc
if exist %USERPROFILE%\AppData\Roaming\ConEmu.xml del %USERPROFILE%\AppData\Roaming\ConEmu.xml
mklink %USERPROFILE%\AppData\Roaming\ConEmu.xml %dotfiles%\conemu\ConEmu.xml
if exist %USERPROFILE%\.vimrc del %USERPROFILE%\.vimrc
mklink %USERPROFILE%\.vimrc %dotfiles%\vim\minimalist-dev\.vimrc
if exist %USERPROFILE%\.gvimrc del %USERPROFILE%\.gvimrc
mklink %USERPROFILE%\.gvimrc %dotfiles%\vim\.gvimrc
