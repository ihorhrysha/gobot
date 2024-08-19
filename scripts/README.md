## Bash script

Copy the script to hooks derictory in your project and make it executable.

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
pre-commit install
```