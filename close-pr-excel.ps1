$owner = $env:INPUT_GITHUB_OWNER
$repo = $env:INPUT_GITHUB_REPO
$token = $env:INPUT_GITHUB_TOKEN
$base_branch = $env:INPUT_GITHUB_BRANCH

Write-Host "token: $token"
Write-Host "owner: $owner"
Write-Host "repo: $repo"
Write-Host "base_branch: $base_branch"



$url = "https://api.github.com/repos/$owner/$repo/pulls?state=closed"

$headers = @{
   "Authorization" = "Bearer $token"
   "Accept" = "application/vnd.github.v3+json"
}

Write-Host "url: $url"

$today = Get-Date -Format "yyyy-MM-dd"
Write-Host "$today"
$response = Invoke-RestMethod -Uri $url -Headers $headers -Method Get

Write-Host "$response"
foreach ($pr in $response) {
   $prNumber = $pr.number
   $prTitle = $pr.title
   $prClosedBy = $pr.user.login
   $prClosedAt = $pr.closed_at
   $prBaseBranch = $pr.base.ref
   $prHeadBranch = $pr.head.ref
  
   if (($prClosedAt -like "$today*") -and ($prBaseBranch -eq "$base_branch")) {
     
     Write-Host "PR #$prNumber"
       }
   }


