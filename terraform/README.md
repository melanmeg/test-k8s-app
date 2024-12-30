## terraform 実行
```bash
$ terraform init
$ terraform plan
$ terraform apply
```

```bash
# 再作成時は、Workload Identity プール/プロバイダ が30日間は完全削除されないため、以下コマンドでundelete,importしておくことによりTerraformのエラーを回避。
$ gcloud iam workload-identity-pools undelete gitlab-pool --location global --project my-project-melanmeg
$ gcloud iam workload-identity-pools providers undelete gitlab-pool-provider --workload-identity-pool gitlab-pool --location global --project my-project-melanmeg
# もし依存関係でエラーが起こった場合は、先にterraform applyしてから再度試す。
$ terraform import google_iam_workload_identity_pool.github_pool projects/my-project-melanmeg/locations/global/workloadIdentityPools/github-pool
$ terraform import google_iam_workload_identity_pool_provider.github_pool_provider projects/my-project-melanmeg/locations/global/workloadIdentityPools/github-pool/providers/github-pool-provider
```

## tfstate 移行

- 下記追記
```hcl
terraform {
  backend "gcs" {
    bucket  = "my-project-melanmeg-tfstate"
    prefix  = "my-project-melanmeg/state"
  }
}
```

- 移行
```bash
# 初期化
$ rm -rf .terraform .terraform.lock.hcl

$ terraform init
  Enter a value: yes
  # この時点で移行が完了する
$ terraform plan
  # 差分が表示されないこと

$ rm -f terraform.tfstate*
```
