#ocapull.sh
#!/bin/bash
for d in ./*/ ; do (cd "$d" && git pull); done; cd ..
