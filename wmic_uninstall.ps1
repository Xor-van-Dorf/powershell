#Uninstall using wmic
wmic product where "name like 'Forti%%'" call uninstall /nointeractive
