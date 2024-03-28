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

$response = Invoke-RestMethod -Uri $url -Headers $headers -Method Get

$prData = @()

foreach ($pr in $response) {
   $prNumber = $pr.number
   $prTitle = $pr.title
   $prClosedBy = $pr.user.login
   $prClosedAt = $pr.closed_at
   $prBaseBranch = $pr.base.ref
   $prHeadBranch = $pr.head.ref
  
   if (($prClosedAt -like "$today*") -and ($prBaseBranch -eq "$base_branch")) {
     
       $prData += [PSCustomObject]@{
           'PR Number' = $prNumber
           'Title' = $prTitle
           'Closed By' = $prClosedBy
           'Closed At' = $prClosedAt
           'Base Branch' = $prBaseBranch
           'Head Branch' = $prHeadBranch
       }
   }
}

$csvFilePath = " $env:GITHUB_WORKSPACE\Closed_PRs_$($owner)_$($repo)_$(Get-Date -Format 'yyyyMMdd_HHmmss').csv"
$prData | Export-Csv -Path $csvFilePath -NoTypeInformation
Write-Host "Data exported to $csvFilePath."
