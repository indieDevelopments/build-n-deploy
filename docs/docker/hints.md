## Replace envsubst compatible variable placholders to play with Node-config
```bash
sed 's/"[$]/"/g' config/_default.json config/default.json
```
