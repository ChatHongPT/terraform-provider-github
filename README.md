# terraform-k8s-openstack

Terraform + GitHub Actions로 PR Plan 코멘트와 승인 기반 Apply 파이프라인

## 개요

- PR에서 `terraform fmt/validate/plan`을 실행하고, `tfcmt`로 Plan 결과를 PR 코멘트에 게시합니다.
- `main`에 머지되면 `terraform` 환경에 대한 Deployments 승인을 거쳐 `terraform apply`를 실행합니다.

## 디렉터리

- `.github/workflows/terraform-plan.yml`: PR 이벤트에서 Plan 실행 및 코멘트 게시
- `.github/workflows/terraform-apply.yml`: main 푸시 시 Apply 실행, Deployments 기록
- `.tfcmt.yaml`: PR 코멘트 템플릿

## 준비사항

1. 리포지토리 시크릿
   - 기본: `GITHUB_TOKEN`(자동 제공). GitHub provider만 사용 시로 충분
   - 기타 클라우드 사용 시 해당 자격증명 시크릿 추가 후 워크플로우에 주입
2. Terraform 프로젝트 루트에 `providers`, `backend`, `.terraform.lock.hcl` 등이 정상 구성되어 있어야 합니다.

## 동작 흐름

1. 개발자가 PR 생성 → Actions가 Plan 수행 → `tfcmt`가 PR 코멘트로 결과 게시
2. 플랫폼 팀이 변경사항 검토 후 승인
3. PR 머지 → `Terraform Apply` 워크플로우가 `terraform` 환경 승인을 요청 → 승인 시 `terraform apply` 실행

## 자주 보는 문제

- Plan 코멘트가 안 달림: `tfcmt`가 읽을 `tfplan.txt` 생성 여부 확인, 워크플로우 권한에 `pull-requests: write` 필요
- Apply가 대기 상태: 리포지토리의 Environments에서 `terraform` 환경 승인이 필요
