## 概要

おうちkubernetesのマニフェストを管理する

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
# argocd-test-http   192.168.11.161 80   30001
# argocd-test-https  192.168.11.161 443  30002
# argocd             192.168.11.161 8081 30003
# grafana            192.168.11.161 8082 30004
# minio              192.168.11.161 8083 30005
# longhorn           192.168.11.161 8084 30006
# misskey-http       192.168.11.161 8085 30007
# misskey-https      192.168.11.161 8086 30008
```

## 初期構築
- terraform から Actions へ移行
  - ./terraform参照

## 運用
- Terraform 更新時 Actions で `/apply ci` をコメントして apply

- シークレット追加
```bash
$ SECRET_ID=xxxxxx
$ echo -n $SECRET_ID | gcloud secrets create "${SECRET_ID}-sm" --replication-policy=automatic --data-file=-
$ gcloud secrets list
# gcloud secrets delete SECRET_NAME # 削除したいとき
```

# ※重要 SSO時のキャッシュについて

- Cloudflareのキャッシュルール(all_cache)があるとSSOの挙動に影響がでる。
- Cloudflareのキャッシュルールは一旦、今後作らない方針とする
