Workspace_Dir='/workspaces/'${RepositoryName}
# cd '/workspaces/'${RepositoryName}

LOG_FILE=$Workspace_Dir'/.dotfiles/install_log.txt'

if [ ! -d $Workspace_Dir'/.dotfiles' ]; then 
    mkdir $Workspace_Dir'/.dotfiles'
    #  copy the dotfiles into the workspace
    cp -r ./dotfiles/* $Workspace_Dir'/.dotfiles'
fi

echo "Installing linters "  >> $LOG_FILE
# Install the linters
bash ./install_linters.sh >> $LOG_FILE
echo "... Done" >> $LOG_FILE


echo "Dotfile loaded at $(date +"%H:%M:%SS, %d_%m_%Y")" | tee $LOG_FILE
echo "dotfile commit hash:" $(git rev-parse HEAD)  | tee -a $LOG_FILE

echo ""  | tee -a $LOG_FILE

# add .dotfiles folder to the gitignore
echo "Adding .dotfiles to .gitignore"  | tee -a $LOG_FILE
if ! grep -Fxq '.dotfiles/' $Workspace_Dir'/.gitignore'
then
    echo "" >> $Workspace_Dir'/.gitignore'
    echo "#Dotfiles " >> $Workspace_Dir'/.gitignore'
    echo '.dotfiles/' >> $Workspace_Dir'/.gitignore'
    echo "Added lines to .gitignore" >> $LOG_FILE
fi
echo "Done .gitignore"  | tee -a $LOG_FILE



## Set an environment variable for user email 
echo "Setting up environment variables"  | tee -a $LOG_FILE
CMFIVE_USER_EMAIL=dane@2pisoftware.com
export CMFIVE_USER_EMAIL
echo "   Done"  | tee -a $LOG_FILE


# ## Setup GHCLI 
# # uses GITHUB_TOKEN 
# # dump the existing token, it has no rights 
# export GITHUB_TOKEN=
# # Copy in the one from the secrets. note, this is only valid for this script
# export GITHUB_TOKEN=${PERSONAL_TOKEN}
# gh cs list
# ## gets us this list, but doesn't persist ... 
# echo "Got a codespaces list: " >> $LOG_FILE
# gh cs list >> $LOG_FILE
# echo "... Done"


## Setup the ssh key to clone any private repos that we need. 
# echo "Setting up SSH keys"  | tee -a $LOG_FILE

# SSH_DIR="/home/vscode/.ssh"

# if [ ! -d $SSH_DIR ]; then
#     mkdir -p $SSH_DIR
# else 
#     chmod -R 777 $SSH_DIR
# fi

# if [ ! -f $SSH_DIR"/id_rsa" ]
# then 
#     # sudo touch $SSH_DIR'/id_rsa'
#     sudo printf "%s" "${PERSONAL_SSH_KEY}" > $SSH_DIR"/id_rsa"
#     chmod 400 $SSH_DIR"/id_rsa" 
# fi

# ## add github to hosts to prevent a warning 
# if [ ! -f $SSH_DIR"/known_hosts" ]
# then 
#     touch $SSH_DIR"/known_hosts"
# fi

# if ! grep github.com $SSH_DIR/known_hosts > /dev/null
# then
# 	ssh-keyscan github.com >> $SSH_DIR/known_hosts
# fi
# echo "... Done"


# echo "Cloning a private repo " >> $LOG_FILE

# # test clone a private repo 
# git clone git@github.com:2pisoftware/artifax-module-bundle.git $PWD'/artifax-module-bundle' >> $LOG_FILE
# echo "... Done"

echo "Adding vscode settings:" >> $LOG_FILE
# Add the settings.json file
cp $Workspace_Dir'/.dotfiles/settings.json' $Workspace_Dir'/.vscode/settings.json'
echo "... Done" >> $LOG_FILE




echo "Loading Personal Extensions: " >> $LOG_FILE
# Add additional extensions 
code --install-extension "Gruntfuggly.todo-tree" 
code --install-extension "oderwat.indent-rainbow"
code --install-extension "mhutchie.git-graph"
code --install-extension "JozefChmelar.compare" 
code --install-extension "DavidAnson.vscode-markdownlint" 
code --install-extension "waderyan.gitblame"
code --install-extension "eamodio.gitlens"
code --install-extension "mutantdino.resourcemonitor"
code --install-extension "github.vscode-github-actions"

# theme
code --install-extension "max-SS.Cyberpunk"

echo "... Done" >> $LOG_FILE


exit 0

