C:\Users\danny>nmap -p- -T5 127.0.0.1
Starting Nmap 7.94 ( https://nmap.org ) at 2024-07-22 20:04 Central Daylight Time
Nmap scan report for kubernetes.docker.internal (127.0.0.1)
Host is up (0.00011s latency).
Not shown: 65476 closed tcp ports (reset)
PORT      STATE    SERVICE
135/tcp   open     msrpc
137/tcp   filtered netbios-ns
443/tcp   open     https
445/tcp   open     microsoft-ds
843/tcp   open     unknown
902/tcp   open     iss-realsecure
912/tcp   open     apex-mesh
1042/tcp  open     afrog
1043/tcp  open     boinc
1801/tcp  open     msmq
2015/tcp  open     cypress
2103/tcp  open     zephyr-clt
2105/tcp  open     eklogin
2107/tcp  open     msmq-mgmt
5040/tcp  open     unknown
5354/tcp  open     mdnsresponder
5357/tcp  open     wsdapi
5426/tcp  open     devbasic
6463/tcp  open     unknown
8090/tcp  open     opsmessaging
8307/tcp  open     unknown
9012/tcp  open     unknown
9013/tcp  open     unknown
9922/tcp  open     unknown
13010/tcp open     unknown
13030/tcp open     unknown
13031/tcp open     unknown
13032/tcp open     unknown
13333/tcp open     unknown
17500/tcp open     db-lsp
17532/tcp open     unknown
17600/tcp open     unknown
17945/tcp open     unknown
22112/tcp open     unknown
27036/tcp open     unknown
27060/tcp open     unknown
27339/tcp open     unknown
36021/tcp open     unknown
49664/tcp open     unknown
49665/tcp open     unknown
49666/tcp open     unknown
49667/tcp open     unknown
49668/tcp open     unknown
49669/tcp open     unknown
49670/tcp open     unknown
49671/tcp open     unknown
49672/tcp open     unknown
49676/tcp open     unknown
49678/tcp open     unknown
52557/tcp open     unknown
53047/tcp open     unknown
53048/tcp open     unknown
53060/tcp open     unknown
53342/tcp open     unknown
53343/tcp open     unknown
53344/tcp open     unknown
53345/tcp open     unknown
55000/tcp open     unknown
65001/tcp open     unknown

Nmap done: 1 IP address (1 host up) scanned in 3.51 seconds