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

 ## Teraform
 - dependencies: aws account with an IAM user that has API access + an ec2 keypair

 - `brew install terraform`
 - `terraform init`
 - `terraform plan` (will prompt for aws_key_path or you can set ENV var `TF_VAR_aws_key_path`)
 - `terraform apply` or `terraform destroy` to provision/teardown
 - import modules from https://registry.terraform.io via `terraform import`
 - new modules can be added by creating a directory with terraform files, and then specifying that dir. as the module source:
- note: the variables for the module are defined within the module itself, and we can then pass in values here
 ```
 module "vpc" {
   source = ".\\Modules\\path\\here"
   some = "foo"
   vars = "bar"
   for = "the"
   vpc = "here"
 }
 ```
 - workspaces: `terraform workspace new foo` (creates new workspace, different state files etc)
 - templates:
  ```
  data "template_file" "some_name" {
    template = "${file("path/file.tpl")}"
    vars {
      my_var = "${var.parent_var_name}"
    }
  }

  # referenced as: (notice the `rendered` on the end)
  some_var = "${data.template_file.some_name.rendered}"
  ```
  - data sources: templates (see above), http, external (we've seen templates as well as external data sources with some aws examples)
    * http data source:
    ```
    data "http" "example" {
      url = "https://url.to.website.com"  # must return text or json
      request_headers {
        header_name = "header_value"
      }
    }
    # note the use of `body` when we fetch the data source
    some_var = "${data.http.example.body}"
    ```
    * external data source
    ```
    data "external" "example" {
      program = [ "name of program", "path to script" ]
      # sent as json
      query = {
        var1 = "value1"
      }
    }
    some_var = "${$data.external.example.result.some_value}" # the script must return valid json
    ```

 ## Kubernetes
 - composed of masters and nodes.
 - kube-apiserver (only master with a frontend, has a rest api + consumes json)
   * cluster store: stored in `etcd`
   * controllers: loop and watch for changes
   * scheduler: watches for new pods
 - nodes:
   * kubelet: register node with cluster, watches apiserver, instantiates pod + reports to master (exposed on port 10255  /spec /health   /pods
- interaction with kubernetes:
  * declarative manifest (not imperative commands) - tell it the desired state, it will figure out how to get there.
 - pods:
   * shared resources within the pod (ip, cpu etc)
   * can have many containers
   * when we scale, we do so by adding more pods, not by adding things to existing pods
   * pods only live on a single node
   * if a pod dies, a new one is created in it's place, we don't restart existing pods
   * constantly changing ips when scaled up/down (not reliable to point to IP of a pod)
  - service object (maintains its IP) useful for load balancing across pods
   * pods belong to a service via labels
