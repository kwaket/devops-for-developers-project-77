all:
  children:
    webservers:
      hosts:
        web1:
          ansible_host: ${web_1_ip}
          ansible_user: ${vm_user}

        web2:
          ansible_host: ${web_2_ip}
          ansible_user: ${vm_user}
