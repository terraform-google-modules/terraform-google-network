Postfix Relay
=============

Configures Postfix to use another SMTP server as a relay host for all mail
received.

Requirements
------------

- RHEL 7/8 instance
- SMTP server + username/password

Role Variables
--------------

- `postfix_relay_smtp_address`: The SMTP address for the remote relay host. If
  left empty, send email directly to the world.
- `postfix_relay_smtp_port`: The SMTP address for the remote relay host
- `postfix_relay_username`: The username for authenticating with the remote relay host
- `postfix_relay_password`: The password for authenticating with the remote relay host
- `postfix_envelope_sender`: This allows Postfix to update the envelope from (the
  `MAIL FROM` used in the SMTP conversation), without modifying the headers in
  the email itself. This is useful when you have to send email for a domain but
  do not have the ability to configure SPF records for the domain you are
  sending as.

  This is a mapping from a domain that we are going to masquerade to the domain
  we are masquerading as.

  All email sent from example.com will have its envelope sender change to
  example.net, so an email sent from jane@example.com will be sent as
  jane-example.com@example.net as the envelope sender. This allows us to
  configure SPF for example.net and email should validate for SPF.

  ```
  postfix_envelope_sender:
    example.com: example.net
  ```

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

```
- hosts: all
  tasks:
  - name: Configure Postfix with the relay settings
    include_role:
      name: postfix-relay
      apply:
        become: true
```

```
ansible-playbook -i mail.example.com, postfix-relay-playbook.yml \
    -e "postfix_relay_smtp_address=mail.example.net" \
    -e "postfix_relay_username=johndoe" \
    -e "postfix_relay_password=foobar"
```

License
-------

BSD

Author Information
------------------

Bert JW Regeer (bert.regeer@sapns2.com)
