# template_pce_customer

template for a pce customer variable repository

Structure
---------

Each product group may have its own sub-directory, this way it can be targetted
by `-i` in `ansible-playbook` and other Ansible commands, and variables can be
automatically picked up from `group_vars` and `host_vars` folders if they
exist.

Inventories may also exist stand-alone, and all variables may be defined in the
inventory.

Stand-alone var files that expected to be passed in using "extra vars" support
(`-e`) should go into the `variables` folder.

Submodules
----------

When cloning the repository use the recursive attribute to initialize the submodules on clone
example:
```
git clone https://example.git --recursive
```

To update the submodule in the repository use the following command:
```
git submodule update --init
```


