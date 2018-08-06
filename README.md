this is a puppet server demo, puppetmaster is the puppet server, wiki and wikitest will have the same configuration but across different environments (`vagrant up` to boot each dir)

dependencies:
- vagrant
- virtualbox
- ChefDK note: `which berks` should respond with `/opt/chefdk/bin/berks` or provisioning with chef will fail.  You may need to uninstall `gem uninstall berks` if it responds with something else
