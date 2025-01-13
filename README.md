## 概要

おうちkubernetesのマニフェストを管理する

## サーバースペック
| name      | cpu(s) | mem(GiB) | disk(GiB) |
| --------- | ------ | -------- | --------- |
| physical1 | 8      | 32       | 500       |
| physical2 | 16     | 128      | 1000      |

## ホスト

| hostname | IP             |
| -------- | -------------- |
| k8s-api  | 192.168.11.130 |
| k8s-lb-1 | 192.168.11.131 |
| k8s-lb-2 | 192.168.11.132 |
| k8s-cp-1 | 192.168.11.141 |
| k8s-cp-2 | 192.168.11.142 |
| k8s-cp-3 | 192.168.11.143 |
| k8s-wk-1 | 192.168.11.151 |
| k8s-wk-2 | 192.168.11.152 |
| k8s-wk-3 | 192.168.11.153 |

## LBリスト

```bash
# argocd-test-http        192.168.11.161 80   30001
# argocd-test-https       192.168.11.161 443  30002
# argocd                  192.168.11.161 8081 30003
# grafana                 192.168.11.161 8082 30004
# minio                   192.168.11.161 8083 30005
# longhorn                192.168.11.161 8084 30006
# misskey-http            192.168.11.161 8085 30007
# misskey-https           192.168.11.161 8086 30008
# opensearch              192.168.11.161 8087 30009
# opensearch-dashboard    192.168.11.161 8088 30010
# twicas-monitoring       192.168.11.161 8089 30011
# rabbitmq-ui             192.168.11.161 8090 30012
# rabbitmq                192.168.11.161 8091 30013
```

## ※重要 SSO時のキャッシュについて

- Cloudflareのキャッシュルール(all_cache)があるとSSOの挙動に影響がでる
- Cloudflareのキャッシュルールは一旦、今後作らない方針とする

## ※重要 バージョンはすべて最新の１つ手前のマイナーバージョン最新にする

## cloudflared 導入手順

```bash
$ cloudflared tunnel login
$ cloudflared tunnel create test-k8s-tunnel
$ cloudflared tunnel route dns test-k8s-tunnel test-k8s.melanmeg.com
$ cloudflared tunnel token --cred-file ./credentials.json test-k8s-tunnel

$ kubectl create secret generic tunnel-credentials \
  --from-file=credentials.json=credentials.json

$ wget https://raw.githubusercontent.com/cloudflare/argo-tunnel-examples/master/named-tunnel-k8s/app.yaml
$ wget https://github.com/cloudflare/argo-tunnel-examples/blob/master/named-tunnel-k8s/cloudflared.yaml

# Fix cloudflared.yaml
$ kubectl apply -f cloudflared.yaml
```

- ブラウザからトンネルの移行を実施する

- パブリックホストの設定は、ブラウザからのみ

## rabbitmq
```bash
$ get_rabbitmq_password.sh
# http://192.168.11.161:8090/
# ログインして、以下ユーザー作成
# ユーザー：admin
# パスワード：admin
# タグ：administrator
# 仮想ホスト：/
# トピック権限：/

```
