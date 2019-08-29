
To modify those jobs that fail:
``` 
cat check_eqtl.txt | grep False | cut -f2 | xargs -I '{}' sed -i 's/4:00/48:00/g' '{}'
```