<div align="center">

ToolGit
===========================================================================================================================================================================================================================

GIT 생산성 툴킷

</div>

도구는 다양한 하위 명령으로 GIT를 확장하여 삶을 더 편하게 만들 수있는 스크립트 모음입니다.

Commands
--------


| Command                    | Description                                                                          |
| ---------------------------- | -------------------------------------------------------------------------------------- |
| git amend | 현재 staged 상태의 변경사항을 amend (Alias) |
| git-delete-gone-branches | 원격에 더 이상 존재하지 않는 로컬 브랜치 삭제 |
| git dir | 이 Git 저장소의 .git 디렉토리 경로 출력 (Alias) |
| git-force-pull | hard reset을 사용하여 원격 트래킹 브랜치를 fetch하고 강제로 pull |
| git-forward | 모든 원격 트래킹 브랜치를 fetch하고 fast-forward |
| git gc-all | reflog를 만료시키고 Git 저장소에 대해 전체 가비지 컬렉션 실행 (Alias) |
| git-in-repo | 현재 작업 디렉토리가 Git 저장소이면 0 반환, 그렇지 않으면 0이 아닌 값 반환 |
| git-is-branch-remote | 브랜치가 원격 브랜치를 참조하면 0 반환 |
| git-is-head-detached | HEAD가 detached 상태이면 0 반환, 그렇지 않으면 0이 아닌 값 반환 |
| git-is-worktree-clean | 작업 트리에 변경사항이나 추적되지 않은 파일이 없으면 0 반환, 그렇지 않으면 0이 아닌 값 반환 |
| git-legacy | 의 top에 현재 HEAD의 전체 히스토리를 rebase |
| git-main-branch | 메인(기본) 브랜치의 이름 가져오기 |
| git-mode-restore | 인덱스 및/또는 작업 트리에서 파일 모드 복원 |
| git root | 이 Git 저장소의 루트 경로 출력 |
| git-xlog | 추가되거나 제거된 라인에서만 문자열 히스토리 검색 |
