set dotfiles=%USERPROFILE%\dev\dotfiles

if not exist %USERPROFILE%\.local\bin mkdir -p %USERPROFILE%\.local\bin
if not exist %USERPROFILE%\.gitconfig mklink %USERPROFILE%\.gitconfig %dotfiles%\git\.gitconfig
if not exist %USERPROFILE%\.githelpers mklink %USERPROFILE%\.githelpers %dotfiles%\git\.githelpers
if not exist %USERPROFILE%\.local\bin\git_diff_wrapper mklink %USERPROFILE%\.local\bin\git_diff_wrapper %dotfiles%\git\git_diff_wrapper
if not exist %USERPROFILE%\.bashrc mklink %USERPROFILE%\.bashrc %dotfiles%\bash\.bashrc
if exist %USERPROFILE%\AppData\Roaming\ConEmu.xml (
   del %USERPROFILE%\AppData\Roaming\ConEmu.xml
   mklink %USERPROFILE%\AppData\Roaming\ConEmu.xml %dotfiles%\conemu\ConEmu.xml
)
