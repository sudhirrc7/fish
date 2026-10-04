# Flutter via FVM — all SDKs, git cache and pub cache live on the external SSD
set -gx FVM_CACHE_PATH /Volumes/devssd/fvm
set -gx FVM_GIT_CACHE_PATH /Volumes/devssd/fvm/cache.git
set -gx PUB_CACHE /Volumes/devssd/fvm/pub-cache

# `fvm global <version>` points this symlink at the chosen SDK
fish_add_path -g $FVM_CACHE_PATH/default/bin
fish_add_path -g $PUB_CACHE/bin
