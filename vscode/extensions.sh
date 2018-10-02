EXTENSIONS=(
    'dbaeumer.vscode-eslint' \
    'donjayamanne.githistory' \
    'dracula-theme.theme-dracula' \
    'dunstontc.viml' \
    'eamodio.gitlens' \
    'EditorConfig.EditorConfig' \
    'mechatroner.rainbow-csv' \
    'ms-mssql.mssql' \
    'ms-python.python' \
    'ms-vscode.azurecli' \
    'ms-vscode.csharp' \
    'ms-vscode.Go' \
    'ms-vsts.team' \
    'PeterJausovec.vscode-docker' \
    'PKief.material-icon-theme' \
    'streetsidesoftware.code-spell-checker' \
    'vscodevim.vim' \
    'Zignd.html-css-class-completion'
)

for VARIANT in 'code' \
               'code-insiders'
do
  if hash $VARIANT 2>/dev/null; then
    echo 'Installing extensions for $VARIANT'
    for EXTENSION in ${EXTENSIONS[@]}
    do
      $VARIANT --install-extension $EXTENSION
    done
  fi
done