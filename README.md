# Домашнее задание к занятию "`Подъём инфраструктуры в Yandex Cloud`" - `Сергеева Екатерина`


### Инструкция по выполнению домашнего задания

   1. Сделайте `fork` данного репозитория к себе в Github и переименуйте его по названию или номеру занятия, например, https://github.com/имя-вашего-репозитория/git-hw или  https://github.com/имя-вашего-репозитория/7-1-ansible-hw).
   2. Выполните клонирование данного репозитория к себе на ПК с помощью команды `git clone`.
   3. Выполните домашнее задание и заполните у себя локально этот файл README.md:
      - впишите вверху название занятия и вашу фамилию и имя
      - в каждом задании добавьте решение в требуемом виде (текст/код/скриншоты/ссылка)
      - для корректного добавления скриншотов воспользуйтесь [инструкцией "Как вставить скриншот в шаблон с решением](https://github.com/netology-code/sys-pattern-homework/blob/main/screen-instruction.md)
      - при оформлении используйте возможности языка разметки md (коротко об этом можно посмотреть в [инструкции  по MarkDown](https://github.com/netology-code/sys-pattern-homework/blob/main/md-instruction.md))
   4. После завершения работы над домашним заданием сделайте коммит (`git commit -m "comment"`) и отправьте его на Github (`git push origin`);
   5. Для проверки домашнего задания преподавателем в личном кабинете прикрепите и отправьте ссылку на решение в виде md-файла в вашем Github.
   6. Любые вопросы по выполнению заданий спрашивайте в чате учебной группы и/или в разделе “Вопросы по заданию” в личном кабинете.
   
Желаем успехов в выполнении домашнего задания!
   
### Дополнительные материалы, которые могут быть полезны для выполнения задания

1. [Руководство по оформлению Markdown файлов](https://gist.github.com/Jekins/2bf2d0638163f1294637#Code)

---

### Задание 1

Повторить демонстрацию лекции(развернуть vpc, 2 веб сервера, бастион сервер)

Ответ:
![Скриншот-1](https://github.com/cat2611/Terraform/blob/main/img/vm.png)

---

### Задание 2

С помощью ansible подключиться к web-a и web-b , установить на них nginx.(написать нужный ansible playbook)

Провести тестирование и приложить скриншоты развернутых в облаке ВМ, успешно отработавшего ansible playbook.

ВМ в облаке
![Скриншот-2](https://github.com/cat2611/Terraform/blob/main/img/vm.png)

Выполнение тестового playbook
```
---
- name: test
  gather_facts: false
  hosts: webservers
  vars:
    ansible_ssh_user: user
  become: yes

  pre_tasks:
    - name: Validating the ssh port is open and
      wait_for:
        host: "{{ (ansible_ssh_host|default(ansible_host))|default(inventory_hostname) }}"
        port: 22
        delay: 5
        timeout: 300
        state: started
        search_regex: OpenSSH

  tasks:
    - name: create test file
      copy:
        dest: /tmp/test
        content: "success"
```
![Скриншот-2](https://github.com/cat2611/Terraform/blob/main/img/ansible_test_connection.png)

Выполнение плейбука по настройке nginx
```
---
- name: Install nginx and update os
  hosts: all
  become: yes

  tasks:
    - name: Обновление ВСЕХ установленных пакетов
      apt:
        upgrade: dist
        autoremove: yes
        autoclean: yes

    - name: Istall nginx
      apt:
        name: nginx
        state: present
        update_cache: yes

    - name: Start Nginx
      service:
        name: nginx
        state: started
        enabled: yes
```
![Скриншот-3](https://github.com/cat2611/Terraform/blob/main/img/ansible_nginx.png)
