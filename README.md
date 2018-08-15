this is a puppet server demo, puppetmaster is the puppet server, wiki and wikitest will have the same configuration but across different environments (`vagrant up` to boot each dir)

 ## Dependencies
- vagrant
- virtualbox
- ChefDK note: `which berks` should respond with `/opt/chefdk/bin/berks` or provisioning with chef will fail.  You may need to uninstall `gem uninstall berks` if it responds with something else

 ## Getting Started

- ` cd puppetmaster`
- `vagrant up`

- repeat the steps above for `wiki` and `wikitest` (the puppetmaster must be running for the 2 agent hosts to succeed)

 ## Customization

- Puppet environments are managed via a separate git repo that is set via: `node['puppetmaster']['environments_git_repo']`
- this folder should have at least 1 environment name + a manifests directory for at least one manifest file `some_file.pp` for puppet to configure our nodes with

## Useful Commands
- `puppet agent --version`, `puppet config print`
- `puppet parser validate <some manifest file>` (validates that file has no syntax errors)
