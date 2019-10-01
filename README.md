# AltTabber_infra
AltTabber Infra repository

## Домашнее задание №1
Был создан файл в форке репозитория и отправлен с помощью пулл реквеста к репозиторию источнику

## Домашнее задание №2
---

## Домашнее задание №3
Добавлены два ВМа с помощью Google Cloud Server: бастион с внешним выходом и внутренний хост. Цель задания возможность заходить на локальные машины через объедененный бастион. Так же было огранизованно обращение в VPN-серверу с помощью сервиса https://pritunl.com/. Документация к сервису: https://docs.pritunl.com/docs/getting-started.


#### Самостоятельное задание 
*Задание: Исследовать способ подключения к someinternalhost в одну команду из вашего рабочего устройства*

Операцию перехода с бастиона на внутрение сервера можно выполнить таким образом:
```
ssh -i ~/.ssh/appuser -A -J <ip бастиона> <ip внутри сети гугла>
```
В рамках решения используются Jump Host. Неизвестно насколько, это правильно, но сделанно именно так :)
#### Дополнительное задание
*Задание: Предложить вариант решения для подключения из консоли при помощи команды вида ssh someinternalhost из локальной консоли рабочего устройства, чтобы подключение выполнялось по алиасу someinternalhost*

В дополнительном задании я создал конфиг файл ~/.ssh/config в котором была описана следующая конфигурация
```
Host bastion
	HostName <ip бастиона>
	User alttabber
	IdentityFile ~/.ssh/appuser.key

Host someinternalhost
	HostName <ip внутри сети гугла>
	User alttabber
	IdentityFile ~/.ssh/appuser.key
	ProxyCommand ssh -q -W %h:%p bastion
```

## Домашнее задание №4

Для создания инстанса используется операция вида (скрипт по организации сервера из файла):
```
gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup-script=./startup-script.sh
```
Так же можно ввести скрип по организации сервера с ссылки
```
gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata startup-script-url=https://gist.githubusercontent.com/AltTabber/3d5c68f288e8a56a3a73feb2b4599928/raw/41c45eba332294783e4733ab739a784eb53d43db/startup_script.sh
```

Для организации настроек фаервола используется:
```
gcloud compute firewall-rules create default-puma-server\
  --allow=tcp:9292 \
  --target-tags=puma-server
```

testapp_IP = 34.89.190.153
testapp_port = 9292
