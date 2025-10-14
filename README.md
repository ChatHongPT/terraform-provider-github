# Terraform GitHub Actions Pipeline

[![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)](https://terraform.io)
[![GitHub Actions](https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white)](https://github.com/features/actions)
[![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)](https://github.com)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=for-the-badge)](LICENSE)

[![Build Status](https://img.shields.io/github/actions/workflow/status/ChatHongPT/terraform-provider-github/terraform-plan.yml?branch=main&label=Plan&style=flat-square)](https://github.com/ChatHongPT/terraform-provider-github/actions/workflows/terraform-plan.yml)
[![Build Status](https://img.shields.io/github/actions/workflow/status/ChatHongPT/terraform-provider-github/terraform-apply.yml?branch=main&label=Apply&style=flat-square)](https://github.com/ChatHongPT/terraform-provider-github/actions/workflows/terraform-apply.yml)
[![Last Commit](https://img.shields.io/github/last-commit/ChatHongPT/terraform-provider-github?style=flat-square)](https://github.com/ChatHongPT/terraform-provider-github/commits/main)

안전한 Terraform 리소스 관리를 위한 GitHub Actions 기반 CI/CD 파이프라인입니다.

## 주요 기능

- **PR 기반 Plan 검토**: Pull Request에서 `terraform plan` 실행 및 결과를 코멘트로 표시
- **환경 승인 프로세스**: `terraform` 환경에서 수동 승인 후 `terraform apply` 실행
- **자동화된 검증**: `terraform fmt`, `validate`, `plan` 자동 실행
- **안전한 배포**: Plan 검토 → 승인 → Apply 단계별 진행

## 아키텍처

```mermaid
graph LR
    A[PR 생성] --> B[Plan 실행]
    B --> C[PR 코멘트]
    C --> D[리뷰/승인]
    D --> E[PR 머지]
    E --> F[환경 승인]
    F --> G[Apply 실행]
    G --> H[리소스 생성]
```

## 파일 구조

```
├── .github/workflows/
│   ├── terraform-plan.yml    # PR 이벤트에서 Plan 실행 및 코멘트 게시
│   └── terraform-apply.yml   # main 푸시 시 Apply 실행
├── providers.tf              # Terraform Provider 설정
├── variables.tf              # 변수 정의
├── main.tf                   # 리소스 정의
└── README.md                 # 프로젝트 문서
```

## 설정 가이드

### 1. 리포지토리 권한 설정

**Settings → Actions → General → Workflow permissions**

- "Read and write permissions" 선택

**Settings → Actions → General**

- "Allow all actions and reusable workflows" 선택

### 2. 환경 설정

**Settings → Environments → New environment**

- Environment name: `terraform`
- Protection rules: "Required reviewers" 설정 (선택사항)

### 3. 시크릿 설정

**Settings → Secrets and variables → Actions**

필요한 시크릿:

- `BOT_TOKEN`: GitHub Personal Access Token (최소 권한: `repo`)

## 사용법

### 1. PR 생성 및 Plan 검토

```bash
# 새 브랜치 생성
git checkout -b feature/new-resource

# Terraform 파일 수정
vim main.tf

# 커밋 및 푸시
git add .
git commit -m "feat: add new resource"
git push origin feature/new-resource
```

PR 생성 후:

- Actions 탭에서 "Terraform Plan" 워크플로우 실행 확인
- PR 코멘트에 Plan 결과 표시 확인

### 2. Apply 실행

1. PR 리뷰 및 승인
2. PR 머지
3. Settings → Environments → `terraform`에서 승인
4. "Terraform Apply" 워크플로우 실행 확인

## 워크플로우 상세

### Plan 워크플로우

**트리거**: Pull Request 생성/업데이트

**단계**:

1. 코드 체크아웃
2. Terraform 설정
3. `terraform init`
4. `terraform fmt -check`
5. `terraform validate`
6. `terraform plan`
7. PR 코멘트로 결과 게시

### Apply 워크플로우

**트리거**: main 브랜치 푸시

**단계**:

1. 코드 체크아웃
2. Terraform 설정
3. `terraform init`
4. `terraform apply -auto-approve`

## 문제 해결

### Plan 코멘트가 생성되지 않는 경우

- 워크플로우 권한에 `pull-requests: write` 확인
- `tfplan.txt` 파일 생성 여부 확인
- Actions 탭에서 워크플로우 실행 로그 확인

### Apply가 대기 상태인 경우

- Settings → Environments → `terraform`에서 승인 필요
- 환경 설정에서 Required reviewers 확인

### Provider 인증 오류

- `BOT_TOKEN` 시크릿 설정 확인
- 토큰 권한에 `repo` 스코프 포함 확인
- `providers.tf`에서 `owner` 설정 확인

## 라이선스

MIT License - 자세한 내용은 [LICENSE](LICENSE) 파일을 참조하세요.

## 기여하기

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request
