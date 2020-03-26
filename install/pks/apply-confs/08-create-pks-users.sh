uaac user add idemia-admin --emails idemia-admin@local -p Idemia2020
uaac user add idemia-user --emails idemia-user@local -p Idemia2020

uaac member add pks.clusters.admin idemia-admin
uaac member add pks.clusters.manage idemia-user