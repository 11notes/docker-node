package main

import (
	"os"

  "github.com/11notes/go-eleven"
)

func main(){
	_ = os.Chdir("/node/var")
	if _, err := os.Stat("/node/var/main.js"); !os.IsNotExist(err){
		eleven.Container.Run("/usr/local/bin", "node", []string{"main.js"})
	}else if _, err := os.Stat("/node/var/package.json"); !os.IsNotExist(err){
		out, err := eleven.Util.Run("/usr/local/bin/pnpm", []string{"install", "--store-dir=/node/run"})
		if err == nil {
			eleven.Container.Run("/usr/local/bin", "pnpm", []string{"start"})
		}else{
			eleven.LogFatal(out)
		}
	}
}