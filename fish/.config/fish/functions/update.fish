function update --wraps='sudo apt update -y && sudo apt upgrade -y && sleep 5 && sudo shutdown -r now' --description 'alias update=sudo apt update -y && sudo apt upgrade -y && sleep 5 && sudo shutdown -r now'
  sudo apt update -y && sudo apt upgrade -y && sleep 5 && sudo shutdown -r now $argv
        
end
