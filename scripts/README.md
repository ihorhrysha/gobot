## Bash script

Copy the script to the git hooks directory in your project and make it executable.

```bash
cp ./scripts/pre-commit .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

Enable the `gitleaks` pre-commit hook in your project.

```bash
git config hooks.gitleaks true
```


## Or alternativelly using pre-commit framework

Install 
```bash
curl https://raw.githubusercontent.com/ihorhrysha/gobot/master/scripts/init-pre-commit | sh
```