# import all submodules
git submodule update --init --recursive

# build font information cached files
fc-cache -vf ~/.fonts/
